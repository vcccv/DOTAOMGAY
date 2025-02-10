
library EventSystem requires UnitDex

    globals
        constant integer ANY_UNIT_EVENT_DAMAGED              = 1
        constant integer ANY_UNIT_EVENT_DAMAGING             = 2
        constant integer ANY_UNIT_EVENT_PICKUP_REAL_ITEM     = 3
        constant integer ANY_UNIT_EVENT_ABILITY_END_COOLDOWN = 4

        constant integer UNIT_EVENT_DAMAGED              = 200
        constant integer UNIT_EVENT_DAMAGING             = 201
        constant integer UNIT_EVENT_PICKUP_REAL_ITEM     = 202
        constant integer UNIT_EVENT_ABILITY_END_COOLDOWN = 203
    endglobals
    
    struct Event extends array 

        static integer INDEX = 0

        static UnitEvent    array TrigUnitEvent
        static AnyUnitEvent array TrigAnyUnitEvent
        static integer      array TrigEventId
        static unit         array TrigUnit

        static unit         array TriggerUnit
        static unit         array DamageSource
        static unit         array DamageTarget

        static real         array EventDamage
        static damagetype   array DamageType

        static attacktype   array AttackType
        static boolean      array IsAttack
        static integer      array Flag1

        static item         array ManipulatedItem
        static integer      array TriggerAbilityId

        static method GetTriggerUnit takes nothing returns unit
            return thistype.TrigUnit[thistype.INDEX]
        endmethod
        static method GetManipulatedItem takes nothing returns item
            return thistype.ManipulatedItem[thistype.INDEX]
        endmethod
        static method GetTriggerAbilityId takes nothing returns integer
            return thistype.TriggerAbilityId[thistype.INDEX]
        endmethod
        static method IsAttackDamage takes nothing returns boolean
            return MHDamageEvent_IsPhysical()// thistype.IsAttack[thistype.INDEX]
        endmethod

    endstruct


    private keyword UnitEventInit

    // 单一事件
    struct UnitEvent

        private integer owner
        private integer id
        private integer executableCode

        private static TableArray ListHeadTable
        private static TableArray ListTailTable

        static thistype array UnitEventListHead
        static thistype array UnitEventListTail

        private thistype prev
        private thistype next

        private method OnExecuteCode takes nothing returns integer
            return MHGame_ExecuteCodeEx(this.executableCode)
        endmethod

        private static method Create takes integer u, integer id, code func returns thistype
            local thistype this

            if u == 0 then
                return 0
            endif

            set this = thistype.allocate()
            set this.owner = u
            set this.id    = id
            set this.executableCode = MHTool_CodeToInt(func)

            if thistype.ListHeadTable[u][id] == 0 then
                set thistype.ListHeadTable[u][id] = this
                set thistype.ListTailTable[u][id] = this
                set this.next = 0
                set this.prev = 0
            else
                set thistype(thistype.ListTailTable[u][id]).next = this
                set this.prev = thistype(thistype.ListTailTable[u][id])
                set this.next = 0
                set thistype.ListTailTable[u][id] = this
            endif

            return this
        endmethod

        method Destroy takes nothing returns nothing
            local integer u = this.owner

            if this.prev == 0 then
                // 删除头部节点
                // 此时 UnitEventListHead[id] == this
                set thistype.ListHeadTable[u][id] = this.next
                if thistype.ListHeadTable[u][id] != 0 then
                    set thistype(thistype.ListHeadTable[u][id]).prev = 0
                else
                    set thistype.ListTailTable[u][id] = 0
                endif
            elseif this.next == 0 then
                // 删除尾部节点
                // 此时 thistype.ListTailTable[u][id] == this
                set this.prev.next = this.next
                set thistype.ListTailTable[u][id] = this.prev
            else
                set this.next.prev = this.prev
                set this.prev.next = this.next
            endif

            call this.deallocate()
        endmethod

        static method CreateEvent takes unit whichUnit, integer id, code func returns thistype
            return thistype.Create(GetUnitId(whichUnit), id, func)
        endmethod

        static method IsUnitHasEvent takes unit whichUnit, integer id returns boolean
            return thistype.ListHeadTable[GetUnitId(whichUnit)][id] > 0
        endmethod

        static method ExecuteEvent takes unit whichUnit, integer id returns nothing
            local thistype node
            local thistype next
            local integer  u    = GetUnitId(whichUnit)

            if u == 0 then
                return
            endif

            set node = thistype.ListHeadTable[u][id]

            set Event.TrigUnit[Event.INDEX]    = whichUnit
            set Event.TrigEventId[Event.INDEX] = id
            
            loop
                exitwhen node == 0

                set next = node.next
                set Event.TrigUnitEvent[Event.INDEX] = node
                call node.OnExecuteCode()

                set node = next
            endloop
        endmethod
        
        implement UnitEventInit

    endstruct

    private module UnitEventInit

        private static method onInit takes nothing returns nothing
            set thistype.ListHeadTable = TableArray[JASS_MAX_ARRAY_SIZE]
            set thistype.ListTailTable = TableArray[JASS_MAX_ARRAY_SIZE]
        endmethod

    endmodule

    struct AnyUnitEvent

        private integer id
        private integer executableCode

        static thistype array ListHead
        static thistype array ListTail

        private thistype prev
        private thistype next

        private method OnExecuteCode takes nothing returns integer
            return MHGame_ExecuteCodeEx(this.executableCode)
        endmethod

        private static method Create takes integer id, code func returns thistype
            local thistype this

            set this = thistype.allocate()
            set this.id = id
            set this.executableCode = C2I(func)

            call ThrowWarning(func == null, "Event", "AnyUnitEvent.Create", "func", id, "func == null")

            if thistype.ListHead[id] == 0 then
                set thistype.ListHead[id] = this
                set thistype.ListTail[id] = this
                set this.next = 0
                set this.prev = 0
            else
                set thistype.ListTail[id].next = this
                set this.prev = thistype.ListTail[id]
                set this.next = 0
                set thistype.ListTail[id] = this
            endif

            return this
        endmethod

        method Destroy takes nothing returns nothing
            if this.prev == 0 then
                set thistype.ListHead[id] = this.next
                if thistype.ListHead[id] != 0 then
                    set thistype.ListHead[id].prev = 0
                else
                    set thistype.ListTail[id] = 0
                endif
            elseif this.next == 0 then
                set this.prev.next = this.next
                set thistype.ListTail[id] = this.prev
            else
                set this.next.prev = this.prev
                set this.prev.next = this.next
            endif
    
            set this.prev = 0
            set this.next = 0

            call this.deallocate()
        endmethod

        static method CreateEvent takes integer id, code func returns thistype
            return thistype.Create(id, func)
        endmethod

        static method ExecuteEvent takes unit u, integer id returns nothing
            local thistype node
            local thistype next

            set node = thistype.ListHead[id]

            set Event.TrigUnit[Event.INDEX] = u
            set Event.TrigEventId[Event.INDEX]  = id
            
            loop
                exitwhen node == 0

                set next = node.next
                set Event.TrigAnyUnitEvent[Event.INDEX] = node
                call node.OnExecuteCode()

                set node = next
            endloop
        endmethod
        
    endstruct

endlibrary
