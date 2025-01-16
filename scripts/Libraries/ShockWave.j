
library ShockwaveLib /*
*************************************************************************************
*
*   */ requires /*
*
*       */ Table                    /*  https://www.hiveworkshop.com/threads/188084/
*
*************************************************************************************
*
*       */ optional ErrorMessage    /*  https://github.com/nestharus/JASS/blob/master/jass/Systems/ErrorMessage/main.j
*
************************************************************************************
*/
    globals
        private constant real TIMER_TIMEOUT                          = 0.02
        private constant real MAXIMUM_COLLISION_SIZE                 = 197.
        private constant real MAXIMUM_ITEM_COLLISION_SIZE            = 16.
    endglobals

    public function GetDestCollisionSize takes destructable d returns real
        return 48.
    endfunction

    public function GetItemCollisionSize takes item i returns real
        return 16.
    endfunction

    private keyword ShockwaveInit

    globals
        private constant trigger   CORE  = CreateTrigger()
        private constant timer     TMR   = CreateTimer()

        private constant group     GROUP = CreateGroup()

        private integer                  active = 0
        private integer          array   instances
        private boolexpr         array   expression
        private triggercondition array   condition
    endglobals

    /*
    *   2种发射方式
    *   1：根据最大距离，移动到的距离>最大距离时修正位置并Terminate
    *   2：根据持续时间，超时则Terminate
    */

    struct Shockwave

        static item tempItem
        static destructable tempDest
        static TableArray table

        static thistype array ShockwaveHead
        static thistype array ShockwaveTail
        thistype next
        thistype prev
        
        debug boolean launched

        effect  shockwaveFX
        string  model
        
        real    minRadius
        real    maxRadius
        real    radius
        real    radiusGrowth

        unit    owner
        real    speed
        real    vel
        real    acceleration // 先不考虑加速度
        real    angle
        real    height
        // 最大距离
        real    distance
        real    modelScale
        real    timeScale

        real    x
        real    y
        // 当前距离
        real    dist

        real    targetX
        real    targetY

        boolean allocated
        boolean recycle
        boolean wantDestroy

        method Destroy takes nothing returns nothing
            call table[this].flush()
            call DestroyEffect(this.shockwaveFX)
            call this.deallocate()
        endmethod

        private method ResetMembers takes nothing returns nothing
            set this.r              = 255
            set this.g              = 255
            set this.b              = 255
            set this.a              = 255
            set this.model          = null
            set this.timeScale      = 1.
            set this.radius         = 0.
            set this.minRadius      = 0.
            set this.maxRadius      = 0.
            set this.speed          = 0.
            set this.vel            = 0.
            set this.modelScale     = 1.
            set this.dist           = 0.
            set this.height         = 0.
            set this.stackSize      = 0
            set this.wantDestroy    = false
            set this.recycle        = false
            debug set this.launched = false
        endmethod

        method SetSpeed takes real speed returns nothing
            set this.speed = speed
            set this.vel   = speed * TIMER_TIMEOUT
        endmethod

        // 根据默认动画时间计算需要修正的
        method FixTimeScale takes real time returns nothing
            local real duration = this.distance / this.speed
            set this.timeScale = time / duration
        endmethod

        integer r
        integer g
        integer b
        integer a
        method SetColor takes integer r, integer g, integer b, integer a returns nothing
            set this.r = r
            set this.g = g
            set this.b = b
            set this.a = a
            if this.shockwaveFX != null then
                call MHEffect_SetColorEx(this.shockwaveFX, a, r, g, b)
            endif
        endmethod

        static method CreateByDistance takes unit owner, real startX, real startY, real angle, real distance returns thistype
            local thistype this = allocate()

            call this.ResetMembers()
            set this.owner = owner
            set this.angle = angle
            set this.x = startX + MHUnit_GetData(owner, UNIT_DATA_LAUNCH_Y) * Cos(angle)
            set this.y = startY + MHUnit_GetData(owner, UNIT_DATA_LAUNCH_Y) * Sin(angle)
            set this.targetX = this.x + distance * Cos(angle)
            set this.targetY = this.y + distance * Sin(angle)
            set this.distance = distance
            set this.allocated = true

            return this
        endmethod

        static thistype temp = 0
        method Step takes nothing returns nothing
            if this.radiusGrowth != 0. then
                set this.radius = this.radius + this.radiusGrowth
            endif
            set this.dist = this.dist + this.vel
            set this.recycle = this.dist >= this.distance
            if this.recycle then
                set this.radius = this.maxRadius
                set this.dist = this.distance
                
                set this.x = this.targetX
                set this.y = this.targetY
            else
                set this.x = this.x + this.vel * Cos(this.angle)
                set this.y = this.y + this.vel * Sin(this.angle)
            endif

            call MHEffect_SetPosition(this.shockwaveFX, this.x, this.y, MHGame_GetAxisZ(this.x, this.y) + this.height)
        endmethod
        
        method HitWidget takes widget w returns nothing
            if w != null then
                set table[this].widget[GetHandleId(w)] = w
            endif
        endmethod

        method HasHitWidget takes widget w returns boolean
            return table[this].handle.has(GetHandleId(w))
        endmethod

        method RemoveHitWidget takes widget w returns nothing
            if w != null then
                call table[this].handle.remove(GetHandleId(w))
            endif
        endmethod

        method FlushHitWidgets takes nothing returns nothing
            call table[this].flush()
        endmethod

        // Tells missile to call removeHitWidget(w) after "seconds" time.
        // Does not apply to widgets, which are already hit by this missile.
        readonly integer stackSize
        method EnableHitAfter takes widget w, real seconds returns nothing
            local integer id = GetHandleId(w)
            local Table t
            if w != null then
                set t = table[this]
                if not t.has(id) then
                    set t[id] = stackSize
                    set t[stackSize] = id
                    set stackSize = stackSize + 1
                endif
                set t.real[id] = seconds
            endif
        endmethod

        method UpdateStack takes nothing returns nothing
            local integer dex = 0
            local integer id
            local real time
            local Table t
            loop
                exitwhen dex == stackSize
                set t = table[this]
                set id = t[dex]
                set time = t.real[id] - TIMER_TIMEOUT
                if time <= 0. or not t.handle.has(id) then
                    set stackSize = stackSize - 1
                    set id = t[stackSize]
                    set t[dex] = id
                    set t[id] = dex
                    // Enables hit.
                    call t.handle.remove(id)
                    // Remove data from stack.
                    call t.real.remove(id)
                    call t.remove(id)
                    call t.remove(stackSize)
                else
                    set t.real[id] = time
                    set dex = dex + 1
                endif
            endloop
        endmethod

        private method IsWidgetInRange takes real x, real y, real ws, real ms returns boolean
            set x = x - this.x
            set y = y - this.y
            set ws = ws + ms

            return x*x + y*y <= ws*ws
        endmethod

        private method IsWidgetInCollision takes widget w, real collisionSize returns boolean
            return this.IsWidgetInRange(this.x, this.y, collisionSize, this.radius)
        endmethod

        method IsUnitInCollision takes unit whichUnit returns boolean
            return IsUnitInRangeXY(whichUnit, this.x, this.y, this.radius)
        endmethod

        //
        //  Runs for every enumerated destructable.
        //  • Directly filters out already hit destructables.
        //  • Distance formula based on the Pythagorean theorem.
        //
        static method DestFilter takes nothing returns boolean
            if temp.allocated then
                set tempDest = GetFilterDestructable()
                if not temp.HasHitWidget(tempDest) and temp.IsWidgetInCollision(tempDest, GetDestCollisionSize(tempDest)) then
                    set table[temp].destructable[GetHandleId(tempDest)] = tempDest
                    return true
                endif
            endif
            return false
        endmethod
        //
        //  Runs for every enumerated item.
        //  • Directly filters out already hit items.
        //  • Distance formula based on the Pythagorean theorem.
        //  • Items have a fix collision size of 16.
        //
        static method ItemFilter takes nothing returns boolean
            if temp.allocated then
                set tempItem = GetFilterItem()
                if not temp.HasHitWidget(tempItem) and temp.IsWidgetInCollision(tempItem, GetItemCollisionSize(tempItem)) then
                    set table[temp].item[GetHandleId(tempItem)] = tempItem
                    return true
                endif
            endif
            return false
        endmethod

        implement ShockwaveInit
    endstruct
    
    private function Fire takes nothing returns nothing
        call TriggerEvaluate(CORE)
    endfunction

    // Conditionally starts the timer.
    private function StartPeriodic takes integer structId returns nothing
        if 0 == instances[structId] then
            if 0 == active then
                call TimerStart(TMR, TIMER_TIMEOUT, true, function Fire)
            endif
            set active = active + 1
            set condition[structId] = TriggerAddCondition(CORE, expression[structId])
        endif
        set instances[structId] = instances[structId] + 1
    endfunction

    // Conditionally stops the timer in the next callback.
    private function StopPeriodic takes integer structId returns nothing
        if condition[structId] != null then
            set instances[structId] = instances[structId] - 1
            if 0 == instances[structId] then
                call TriggerRemoveCondition(CORE, condition[structId])
                set condition[structId] = null
                set active = active - 1
                if 0 == active then
                    call PauseTimer(TMR)
                endif
            endif
        endif
    endfunction

    module ShockwaveLaunch
        static method Launch takes Shockwave shockwave returns nothing
            local real      duration
            local Shockwave tailNode = Shockwave.ShockwaveTail[thistype.typeid]
            static if LIBRARY_ErrorMessage then
                debug call ThrowError(shockwave.launched, "thistype", "launch", "shockwave.launched", shockwave, "This shockwave was already launched before!")
                debug call ThrowError(shockwave.speed == 0, "thistype", "launch", "shockwave.speed", shockwave, "This shockwave speed was 0.")
            endif
            debug set shockwave.launched = true

            set shockwave.shockwaveFX = AddSpecialEffect(shockwave.model, shockwave.x, shockwave.y)
            call MHEffect_SetYaw(shockwave.shockwaveFX, shockwave.angle * bj_RADTODEG)
            call MHEffect_SetTimeScale(shockwave.shockwaveFX, shockwave.timeScale)
            call MHEffect_SetScale(shockwave.shockwaveFX, shockwave.modelScale)
            call MHEffect_SetColorEx(shockwave.shockwaveFX, shockwave.a, shockwave.r, shockwave.g, shockwave.b)

            set duration = shockwave.distance / shockwave.speed
            if duration != 0. then
                set shockwave.radiusGrowth = ( shockwave.maxRadius - shockwave.minRadius ) * ( TIMER_TIMEOUT / duration )
            endif
            if shockwave.minRadius == shockwave.maxRadius then
                set shockwave.radius = shockwave.maxRadius
            endif

            // 插入头节点时，链表为空
            if tailNode == 0 then
                set Shockwave.ShockwaveHead[thistype.typeid] = shockwave
                set Shockwave.ShockwaveTail[thistype.typeid] = shockwave
                set shockwave.prev = 0
            else
                // 插入非空链表
                set tailNode.next = shockwave
                set shockwave.prev = tailNode
                set Shockwave.ShockwaveTail[thistype.typeid] = shockwave
            endif
            set shockwave.next = 0

            call StartPeriodic(thistype.typeid)
        endmethod
    endmodule

    module ShockwaveTerminate
        static method Terminate takes Shockwave shockwave returns nothing
            local Shockwave prevNode
            local Shockwave nextNode

            if not shockwave.allocated then
                return
            endif

            static if thistype.onRemove.exists then
                call thistype.onRemove(node)
            endif

            set prevNode = shockwave.prev
            set nextNode = shockwave.next
            if prevNode == 0 then
                // 删除头部节点
                set Shockwave.ShockwaveHead[thistype.typeid] = nextNode
                if nextNode != 0 then
                    set nextNode.prev = 0
                else
                    set Shockwave.ShockwaveTail[thistype.typeid] = 0
                endif
            elseif nextNode == 0 then
                // 删除尾部节点
                set prevNode.next = 0
                set Shockwave.ShockwaveTail[thistype.typeid] = prevNode
            else
                // 删除中间节点
                set nextNode.prev = prevNode
                set prevNode.next = nextNode
            endif
            
            set shockwave.allocated = false
            call shockwave.Destroy()
            call StopPeriodic(thistype.typeid)
        endmethod
    endmodule

    // Allows you to inject missile in certain stages of the motion process.
    module ShockwaveAction
        static if thistype.OnCollide.exists then
            private static method ShockwaveActionUnit takes Shockwave node returns nothing
                local unit first
                call GroupEnumUnitsInRange(GROUP, node.x, node.y, node.radius, null)
                loop
                    set first = FirstOfGroup(GROUP)
                    exitwhen first == null
                    call GroupRemoveUnit(GROUP, first)

                    if not node.HasHitWidget(first) and node.IsUnitInCollision(first) then
                        set Shockwave.table[node].unit[GetHandleId(first)] = first
                        if thistype.OnCollide(node, first) then
                            call thistype.Terminate(node)
                        endif
                    endif
                    
                endloop
            endmethod
        endif

        static if thistype.OnItem.exists then
            private static method ShockwaveActionItem takes nothing returns nothing
                if Shockwave.ItemFilter() and thistype.OnItem(Shockwave.temp, Shockwave.tempItem) then
                    call thistype.Terminate(Missile.temp)
                endif
            endmethod
        endif

        static if thistype.OnDestructable.exists then
            private static method ShockwaveActionDest takes nothing returns nothing
                if Shockwave.DestFilter() and thistype.OnDestructable(Shockwave.temp, tempDest) then
                    call Terminate(Shockwave.temp)
                endif
            endmethod
        endif

        static method Iterate takes nothing returns boolean
            local Shockwave node = Shockwave.ShockwaveHead[thistype.typeid]
            local Shockwave next

            loop
                set next = node.next

                set Shockwave.temp = node

                call node.Step()

                if node.wantDestroy then
                    call thistype.Terminate(node)
                else
                    
                    if node.stackSize > 0 then
                        call node.UpdateStack()
                    endif

                    // Runs unit collision.
                    static if thistype.OnCollide.exists then
                        call thistype.ShockwaveActionUnit(node)
                    endif

                    // Runs destructable collision.
                    static if thistype.OnDestructable.exists then
                        call node.checkDestCollision(function thistype.ShockwaveActionDest)
                    endif

                    // Runs item collision.
                    static if thistype.OnItem.exists then
                        call node.checkItemCollision(function thistype.ShockwaveActionItem)
                    endif

                    // Runs when the destination is reached.
                    if node.recycle and node.allocated then
                        static if thistype.OnFinish.exists then
                            if thistype.OnFinish(node) then
                                call thistype.Terminate(node)
                            endif
                        else
                            call thistype.Terminate(node)
                        endif
                    endif

                    // Runs every Missile_TIMER_TIMEOUT.
                    static if thistype.OnPeriod.exists then
                        if node.allocated and thistype.OnPeriod(node) then
                            call thistype.Terminate(node)
                        endif
                    endif

                endif

                exitwhen next == 0
                set node = next
            endloop

            return false
        endmethod
    endmodule

    module ShockwaveStruct
        implement ShockwaveLaunch
        implement ShockwaveTerminate
        implement ShockwaveAction

        static method onInit takes nothing returns nothing
            set expression[thistype.typeid] = Condition(function thistype.Iterate)
        endmethod
    endmodule

    private module ShockwaveInit
        private static method onInit takes nothing returns nothing
            set table = TableArray[JASS_MAX_ARRAY_SIZE]
        endmethod
    endmodule

endlibrary
