
// 不太好使
// TriggerRegisterUnitInRange 有0.125秒的间隔

// 光环消失时候, 会在所有同名ID光环下寻找符合条件的光环, 并判断距离和等级.

// 添加动作
// 覆盖动作
// 移除动作
// 0.5 秒计时器 粘滞时间

library AuraSystem requires base, BuffSystem

    struct aura

        unit        sourceUnit
        player      sourcePlayer
        group       enumGroup

    function Loop takes nothing returns nothing
        if  then
            set Temp__Player = GetOwningPlayer(u)
            set EnumUnitMaximum = 0
            set tempGroup = LoginGroup(498)
            call GroupEnumUnitsInRange(tempGroup, x, y, a.range + MAX_UNIT_COLLISION, null)
            loop
                set firstUnit = FirstOfGroup(tempGroup)
            exitwhen firstUnit == null
                call GroupRemoveUnit(tempGroup, firstUnit)
                // 友军 存活 非建筑 非守卫
                if IsUnitInRangeXY(firstUnit, x, y, a.range) and IsUnitAlly(firstUnit, a.sourcePlayer) and IsAliveNotStrucNotWard(firstUnit) then
                    set uh = GetHandleId(firstUnit)
                    // 获取目标单位的Buff来源
                    if LoadUnitHandle(ExtraHT, uh, 'B0HC')  == null then // 如果没有来源, 则将来源设置为自己.
                        call SaveUnitHandle(ExtraHT, uh, 'B0HC', u)
                        call AddUnitMagicResistance(firstUnit, data)
                    endif
                endif
            endloop
        
            loop
                set firstUnit = FirstOfGroup(lastGroup)
            exitwhen firstUnit == null
                call GroupRemoveUnit(lastGroup, firstUnit)
                if not IsUnitInGroup(firstUnit, tempGroup) then // 如果不在组内 就表示离开了Buff范围
                    set uh = GetHandleId(firstUnit)
                    if LoadUnitHandle(ExtraHT, uh, 'B0HC') == u then
                        call ReduceUnitMagicResistance(firstUnit, data )
                        call RemoveSavedHandle(ExtraHT, uh, 'B0HC')
                        call RemoveSavedInteger(ExtraHT, uh, 'B0HC')
                    endif
                endif
            endloop

            call SaveGroupHandle(HY, h, 340,(tempGroup))
            call LogoutGroup(lastGroup)

        elseif not LoadBoolean(HY, h, 0) then
            call SaveBoolean(HY, h, 0, true)

            // 清空数据
            loop
                set firstUnit = FirstOfGroup(lastGroup)
            exitwhen firstUnit == null
                call GroupRemoveUnit(lastGroup, firstUnit) 
                set uh = GetHandleId(firstUnit)
                if LoadUnitHandle(ExtraHT, uh, 'B0HC') == u then
                    call ReduceUnitMagicResistance(firstUnit, data)
                    call RemoveSavedHandle(ExtraHT, uh, 'B0HC')
                    call RemoveSavedInteger(ExtraHT, uh, 'B0HC')
                endif
            endloop

        endif
    endfunction

        


    method AddAura takes nothing returns nothing
        
        set this.trig = CreateTrigger()
        call TriggerRegisterUnitInRange(this.trig, this.range)
    endfunction

    endstruct

endlibrary
