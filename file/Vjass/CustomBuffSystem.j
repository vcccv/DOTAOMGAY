
library BuffSystem requires base

    globals
        constant            integer             FALSE_DEATH     = 1
        constant            integer             TRUE_DEATH      = 2
                            code                BuffSystem_CallBack

        private         custombuff      array       TriggerBuff
        private         integer                     EventIndex          = 0
    endglobals


    struct custombuff

        real                dataA
        real                dataB
        real                dataC
        real                dataD
        real                dataE
        real                dataF

        integer             aid
        integer             bid

        real                dur
        timer               t

        integer             level
        unit                source
        unit                target

        boolean             overlayDur
        boolean             deathDispel
        boolean             basicDispel
        boolean             strongDispel
  
        trigger             overlayTrig
        trigger             endTrig
        trigger             removeTrig

        integer             deathDisperse

        conditionfunc       overlayCode
        conditionfunc       endCode
        conditionfunc       removeCode

        string              addActions
        string              overlayActions
        string              endActions
        string              removeActions

        boolean             stacked 

        /*method operator overlayActions= takes code funcHandle returns nothing
            set this.overlayCode = Condition(funcHandle)
        endmethod
        method operator overlayActions takes nothing returns conditionfunc
            return this.overlayCode
        endmethod

        method operator endActions= takes code funcHandle returns nothing
            set this.endCode = Condition(funcHandle)
        endmethod
        method operator endActions takes nothing returns conditionfunc
            return this.endCode
        endmethod

        method operator removeActions= takes code funcHandle returns nothing
            set this.removeCode = Condition(funcHandle)
        endmethod
        method operator removeActions takes nothing returns conditionfunc
            return this.removeCode
        endmethod*/
        
        static method create takes unit source, unit target returns custombuff

            local custombuff b = custombuff.allocate()

            set b.source = source
            set b.target = target
            set b.deathDispel = true

            return b

        endmethod

        method destroy takes nothing returns nothing
   
            set this.level = 0
            if this.t != null then
                set this.dur = 0.
                call DestroyTimer(this.t)
                set this.t = null
                call RemoveSavedInteger(HY, GetHandleId(this.t), 0)
            endif
            set this.removeActions = null
            set this.endActions = null
            set this.overlayActions = null
            set this.addActions = null
            set this.basicDispel = false
            set this.strongDispel = false
            set this.dataA = 0
            set this.dataB = 0
            set this.dataC = 0
            set this.dataD = 0
            set this.dataE = 0
            set this.dataF = 0
   
            call custombuff.deallocate(this)
   
        endmethod

        method end takes nothing returns nothing
            if this.endActions != null then
                set EventIndex = EventIndex + 1
                set TriggerBuff[EventIndex] = this
                call ExecuteFunc(this.endActions)
                set EventIndex = EventIndex - 1
                set this.endActions = null
            endif
        endmethod

        method remove takes nothing returns nothing
            if this.removeActions != null then
                set EventIndex = EventIndex + 1
                set TriggerBuff[EventIndex] = this
                call ExecuteFunc(this.removeActions)
                set EventIndex = EventIndex - 1
                set this.removeActions = null
            endif
         
            call RemoveSavedInteger(ExtraHT, GetHandleId(this.target), this.bid)
            call RemoveSavedBoolean(ExtraHT, GetHandleId(this.target), this.bid)

            if this.aid != 0 then
                call UnitRemoveAbility(this.target, this.aid)
                set this.aid = 0
            endif
            if this.bid != 0 then
                call UnitRemoveAbility(this.target, this.bid)
                set this.bid = 0
            endif

            call this.destroy()

        endmethod

        method add_buff takes nothing returns boolean
            local integer h
            local boolean b
            local real newDur
            set h = GetHandleId(this.target)

            if LoadBoolean(ExtraHT, h, this.bid) then
                if this.overlayDur then
                    set newDur = this.dur
                    call this.destroy()
                    set this = LoadInteger(ExtraHT, h, this.bid)
                    call TimerStart(this.t, newDur, false, BuffSystem_CallBack)
                    return false
                elseif this.overlayTrig != null then
                    set EventIndex = EventIndex + 1
                    set TriggerBuff[EventIndex] = this
                    set EventIndex = EventIndex - 1

                    return true
                endif
            endif
    
            call SaveInteger(ExtraHT, h, this.bid, this)
            call SaveBoolean(ExtraHT, h, this.bid, true)
            
            set EventIndex = EventIndex + 1
            set TriggerBuff[EventIndex] = this
            if this.addActions != null then
                call ExecuteFunc(this.addActions)
            endif
            set EventIndex = EventIndex - 1
            // 添加Buff并设置等级
            if this.aid != 0 then
                call UnitAddPermanentAbilitySetLevel(this.target, this.aid, this.level)
            endif
    
            if this.dur != 0. then
                set this.t = CreateTimer()
                call TimerStart(this.t, this.dur, false, BuffSystem_CallBack)
                call SaveInteger(HY, GetHandleId(this.t), 0, this)
            endif

            return true
        endmethod

    endstruct

    function GetTriggerBuff takes nothing returns custombuff
        return TriggerBuff[EventIndex]
    endfunction

    function GetBuffRemaining takes custombuff b returns real
        return TimerGetRemaining(b.t)
    endfunction

    // Buff正常结束时, 先调用结束方法, 再调用删除方法, 最后删除Buff
    function BuffSystemBuffEnd takes nothing returns boolean
        local custombuff b = LoadInteger(HY, GetHandleId(GetExpiredTimer()), 0)

 
        // 结束方法
        call b.end()

        // 删除方法
        call b.remove()
        set EventIndex = EventIndex - 1
        //call BJDebugMsg("BUFF结束"+I2S(b))

        return false
    endfunction

    function UnitHaveCustomBuff takes unit u, integer bid returns boolean
        return LoadBoolean(ExtraHT, GetHandleId(u), bid)
    endfunction

    function GetUnitCustomBuff takes unit u, integer bid returns custombuff
        return LoadInteger(ExtraHT, GetHandleId(u), bid)
    endfunction

    function GetUnitCustomBuffLevel takes unit u, integer bid returns integer
        local custombuff b = LoadInteger(ExtraHT, GetHandleId(u), bid)
        if b > 0 then
            return b.level
        endif
        return 0
    endfunction

    function UnitRemoveCustomBuffEx takes unit u, integer bid returns boolean
        local custombuff b = LoadInteger(ExtraHT, GetHandleId(u), bid)
        // 删除方法
        if b > 0 then
            call b.remove()
        endif
        return true
    endfunction

endlibrary
