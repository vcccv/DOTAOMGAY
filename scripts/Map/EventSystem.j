
library EventSystem

    globals
        constant integer ANY_UNIT_EVENT_DAMAGED  = 1
        constant integer ANY_UNIT_EVENT_DAMAGING = 2

    
        constant integer ANY_UNIT_EVENT_PICKUP_REAL_ITEM = 3
    endglobals
    
    struct Event extends array 

        static integer INDEX = 0

        static AnyUnitEvent array TrigAnyUnitEvent
        static integer      array TrigEventId
        static unit         array TrigUnit

        static unit         array TriggerUnit
        static unit         array DamageSource
        static unit         array DamageTarget

        static real         array EventDamage
        static damagetype   array DamageType

        static attacktype   array AttackType
        static boolean      array IsAttackDamage
        static integer      array Flag1

        static item         array ManipulatedItem

        static method GetTriggerUnit takes nothing returns unit
            return thistype.TrigUnit[thistype.INDEX]
        endmethod
        static method GetTManipulatedItem takes nothing returns item
            return thistype.ManipulatedItem[thistype.INDEX]
        endmethod

    endstruct

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
