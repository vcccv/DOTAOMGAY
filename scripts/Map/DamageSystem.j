
scope DamageSystem

    globals
	    trigger AnyUnitDamagedTrig
        trigger AnyUnitDamagingTrig
    endglobals
    
    // 学习 1 级技能 - 灵魂超度 为什么在伤害事件里
    function LearnLevel1Skill_SoulAssumption takes nothing returns nothing
        // 因为 有 2 个事件可能触发， 升级事件和 学习事件 所以用TriggerUnit
        local unit whichUnit = GetTriggerUnit()
        local integer h = GetHandleId(whichUnit)
        local texttag tt = CreateTextTag()
        local trigger t = CreateTrigger()
        call TriggerRegisterTimerEvent(t, .05, true)
        call TriggerAddCondition(t, Condition(function AZA))
        call SaveUnitHandle(HY,(GetHandleId(t)), 2,(whichUnit))
        // 灵魂超度 漂浮文字
        call SetTextTagText(tt, " ", .023)
        call SetTextTagPosUnit(tt, whichUnit, 0)
        call SetTextTagVisibility(tt, GetOwningPlayer(whichUnit) == LocalPlayer)
        call SetTextTagPermanent(tt, true)
        call SaveTextTagHandle(HY, h, 451,(tt))
        set MZV[GetPlayerId(GetOwningPlayer(whichUnit))] = whichUnit
        call SaveReal(HY, h, 443,(0 * 1.))

        call AWA(whichUnit, 0)

        set whichUnit = null
        set t = null
        set tt = null
    endfunction
    function A3A takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local real IXX =(LoadReal(HY, h, 20))
        if GetTriggerEventId()!= EVENT_UNIT_SPELL_EFFECT or(GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT and GetSpellAbilityId()=='A1NA') then
            if GetTriggerEventId()!= EVENT_UNIT_SPELL_EFFECT then
                call SaveReal(HY,(GetHandleId(whichUnit)), 443,(((LoadReal(HY,(GetHandleId(whichUnit)), 443))-IXX)* 1.))
            endif
            call AWA(whichUnit,(LoadReal(HY,(GetHandleId(whichUnit)), 443)))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
        set whichUnit = null
        return false
    endfunction
    // 灵魂超度
    function A4A takes unit visageUnit returns nothing
        local integer level = GetUnitAbilityLevel(visageUnit,'A1NA')
        local real A7A =(LoadReal(HY,(GetHandleId(visageUnit)), 443))
        local trigger t
        local integer h
        if IsDamageValidForProcessing(DEDamage) and ( IsPlayerValid( Player( DamagedEventSourcePlayerId ) ) or DESource == Roshan ) then
            set A7A = A7A + DEDamage
            call SaveReal(HY,(GetHandleId(visageUnit)), 443,((A7A)* 1.))
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call SaveUnitHandle(HY, h, 2,(visageUnit))
            call SaveReal(HY, h, 20,((DEDamage)* 1.))
            call TriggerRegisterTimerEvent(t, 6, false)
            call TriggerRegisterDeathEvent(t, visageUnit)
            call TriggerRegisterUnitEvent(t, visageUnit, EVENT_UNIT_SPELL_EFFECT)
            call TriggerAddCondition(t, Condition(function A3A))
            call AWA(visageUnit, A7A)
        endif
        set t = null
    endfunction

    function SoulAssumptionDamagedEvent takes nothing returns nothing
        local integer i = 1
        loop
            if MZV[i] != null and IsUnitInRange(MZV[i], DETarget, 1400) then
                call A4A(MZV[i])
            endif
            exitwhen i == 12
            set i = i + 1
        endloop
    endfunction
    
    struct DamageEvent extends array
        
        static integer INDEX = 0

        
        // 镜头震动和伤害显示
        static method OtherDamagedEvent takes unit damageTarget, unit damageSource, real rDamageValue returns nothing
            local texttag tt = null
            local string d = I2S(R2I(rDamageValue))
            local player t = GetOwningPlayer(damageTarget)
            local player a = GetOwningPlayer(damageSource)
            // 镜头震动
            if IsPlayerPlaying(t) and IsUnitType(DETarget, UNIT_TYPE_HERO) and rDamageValue>= 5 and ZR[GetPlayerId(t)] then
                call ZBE(damageTarget, rDamageValue)
            endif
            if d == "0" or( not EnableMapSetup__ShowDamageTextTag[GetPlayerId(t)] and not EnableMapSetup__ShowDamageTextTag[GetPlayerId(a)]) then
                return
            endif
            set tt = CreateTextTag()
            call SetTextTagText(tt, d, 0.0276)
            // Local__TextTagzOffset
            call SetTextTagPosUnit(tt, damageTarget, Local__TextTagzOffset)
            set Local__TextTagzOffset = Local__TextTagzOffset + 20
            if Local__TextTagzOffset > 500 then
                set Local__TextTagzOffset = 0
            endif
            call SetTextTagVelocity(tt, 0, 0.006)
            call SetTextTagLifespan(tt, 3)
            call SetTextTagPermanent(tt, false)
            call SetTextTagFadepoint(tt, 2)
            call SetTextTagVisibility(tt, false)
            if EnableMapSetup__ShowDamageTextTag[GetPlayerId(t)] and LocalPlayer == t then
                call SetTextTagColor(tt, 250, 0, 0, 255)
                call SetTextTagVisibility(tt, true)
            endif
            if EnableMapSetup__ShowDamageTextTag[GetPlayerId(a)] and LocalPlayer == a and UnitVisibleToPlayer(damageTarget, a) then
                call SetTextTagColor(tt, 0, 0, 250, 255 )
                call SetTextTagVisibility(tt, true)
            endif
            set tt = null
            set t = null
            set a = null
        endmethod

        static method SpellLifesteal takes nothing returns nothing
            if IsUnitType(DETarget, UNIT_TYPE_HERO) then
                call SetWidgetLife(DESource, DEDamage * .25 + GetWidgetLife(DESource))
            else
                call SetWidgetLife(DESource, DEDamage * .05 + GetWidgetLife(DESource))
            endif
            call DestroyEffect(AddSpecialEffectTarget("SpellFizzle.mdx", DESource, "overhead"))
        endmethod

        // 获取英雄的减伤值
        static method GerHeroReducedDamage takes nothing returns real
            local real reducedDamage = .0
            // set KE[DamagedEventSourcePlayerId] = KE[DamagedEventSourcePlayerId] + R2I(DEDamage)
            // 判断小鸡的击杀来源? (相当奇怪为什么在这里判断)
            if GetUnitAbilityLevel(DETarget,'A3D9') == 1 then
                call SaveUnitHandle(HY, GetHandleId(DETarget),'lstd', PlayerHeroes[DamagedEventSourcePlayerId])
            endif
            // 树甲
            if GetUnitAbilityLevel(DETarget,'A3KF') == 1 then
                set MC = RMinBJ(GetLivingArmorBlock(), DEDamage)
                if MC > 0 then
                    set reducedDamage = reducedDamage + MC
                    // set DEDamage = DEDamage - MC
                endif
            endif
            // 其实这一块应该是末端伤害减免 互相独立计算
            // 骷髅王绿魂
            if GetUnitAbilityLevel(DETarget,'A3DA') == 1 then
                set reducedDamage = DEDamage
                //set DEDamage = 0
                // Loa回光返照
            elseif GetUnitAbilityLevel(DETarget,'C022') == 1 then
                set reducedDamage = DEDamage
                call SetUnitToReduceDamage(DETarget, DEDamage)
                // 自己先回一下 回2次血 效果大抵是一致的
                //set DEDamage = 0
                // 虚妄诺言
            elseif GetUnitAbilityLevel(DETarget,'A3KN') == 1 then
                set reducedDamage = DEDamage
                //set DEDamage = 0
                // 折光 需要伤害 > 5 才减免
            elseif GetUnitAbilityLevel(DETarget,'A0RN') > 0 and DEDamage > 5 then
                set reducedDamage = DEDamage
                //set DEDamage = 0
            else
                // 回到过去
                if HaveBacktrack and GetUnitAbilityLevel(DETarget,'A0CZ') > 0 and not IsUnitBroken(DETarget) then
                    // 伤害值 <= 20 则完全随机数 可能是怕计算量过大?
                    if (DEDamage <= 20) then
                        if GetRandomInt(1, 100) < 5 + 5 *(GetUnitAbilityLevel(DETarget,'A0CZ')) then
                            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\WingedSerpentMissile\\WingedSerpentMissile.mdl", DETarget, "hand,left"))
                            set reducedDamage = DEDamage
                            //set DEDamage = 0
                            return reducedDamage
                        endif
                    elseif GetUnitPseudoRandom(DETarget,'A0CZ', 5 + 5 *(GetUnitAbilityLevel(DETarget,'A0CZ'))) then
                        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Weapons\\WingedSerpentMissile\\WingedSerpentMissile.mdl", DETarget, "hand,left"))
                        set reducedDamage = DEDamage
                        //set DEDamage = 0
                        return reducedDamage
                    endif
                endif
                // 不是完全减免的
                // 船油 0.5
                if GetUnitAbilityLevel(DETarget,'A12D') == 1 then
                    set reducedDamage = reducedDamage + DEDamage * .5
                    //set DEDamage = DEDamage - DEDamage * .5
                endif
                // 回光返照的A杖光环 0.5
                if GetUnitAbilityLevel(DETarget,'A3KG') == 1 then
                    set reducedDamage = reducedDamage + DEDamage * .5
                    call SetUnitToReduceDamage(LoadUnitHandle(HY, GetHandleId(DETarget),'A3KG'), DEDamage * .5)
                    //set DEDamage = DEDamage - DEDamage * .5
                endif
                // 折射 需要检查是否被破被动 而且还会根据模型主属性和谐减伤值
                if GetUnitAbilityLevel(DETarget,'A0NA') > 0 and not IsUnitBroken(DETarget) then
                    if not Mode__RearmCombos and GetHeroMainAttributesType(DETarget) == HERO_ATTRIBUTE_STR then
                        set reducedDamage = reducedDamage + DEDamage *(.06 + .02 * GetUnitAbilityLevel(DETarget,'A0NA'))
                        //set DEDamage = DEDamage - DEDamage *(.06 + .02 * GetUnitAbilityLevel(DETarget,'A0NA'))
                    else
                        set reducedDamage = reducedDamage + DEDamage *(.06 + .04 * GetUnitAbilityLevel(DETarget,'A0NA'))
                        //set DEDamage = DEDamage - DEDamage *(.06 + .04 * GetUnitAbilityLevel(DETarget,'A0NA'))
                    endif
                endif
                // 奔袭冲撞 0.6
                if GetUnitAbilityLevel(DETarget,'A2O5') == 1 then
                    set reducedDamage = reducedDamage + DEDamage * .6
                    //set DEDamage = DEDamage - DEDamage * .6
                endif
                // 冰龙大的减伤 被诅咒的单位被攻击时 0.7
                if LoadInteger(HY, GetHandleId(DESource), 4328) == 1 then
                    set reducedDamage = reducedDamage + DEDamage * .7
                    //set DEDamage = DEDamage - DEDamage * .7
                endif
                // 过载
                if LoadBoolean( ExtraHT, GetHandleId(DETarget), HTKEY_DAMAGE_OVERCHARGE ) then
                    set reducedDamage = reducedDamage + DEDamage *(.05 * GetUnitAbilityLevel(DETarget,'A1VM'))
                    // set DEDamage = DEDamage -DEDamage *(.05 * GetUnitAbilityLevel(DETarget,'A1VM'))
                endif
                //if GetUnitAbilityLevel(DETarget,'A1VM')> 0 then
                //	set reducedDamage = reducedDamage + DEDamage *(.05 * GetUnitAbilityLevel(DETarget,'A1VM'))
                //	set DEDamage = DEDamage -DEDamage *(.05 * GetUnitAbilityLevel(DETarget,'A1VM'))
                //endif
                // 大隐刀 造成的伤害减少40%
                if GetUnitAbilityLevel(DESource,'A39D') == 1 then
                    set reducedDamage = reducedDamage + DEDamage * .4
                    //set DEDamage = DEDamage - DEDamage * .4
                endif
            endif
            return RMinBJ( reducedDamage, DEDamage )
        endmethod

        // 设置助攻
        static method SetAssistList takes nothing returns nothing
            set AssistListTime[AssistListCurrentMaxNumber]= (GameTimer.GetElapsed())
            set AssistListSourcePlayerId[AssistListCurrentMaxNumber] = DamagedEventSourcePlayerId
            set AssistListTargetPlayerId[AssistListCurrentMaxNumber] = DamagedEventPlayerId
            set AssistListCurrentMaxNumber = AssistListCurrentMaxNumber + 1
            if AssistListCurrentMaxNumber == 8000 then
                set AssistListCurrentMaxNumber = 1
            endif
        endmethod

        static method AnyUnitDamagedEvent takes nothing returns boolean
            local integer hu = 0
            local real    extraDamage
            local real    reducedDamage
            local player  p = null
            if not FK then
                return false
            endif
            set reducedDamage = 0.

            set Event.INDEX = Event.INDEX + 1
            set DESource = MHDamageEvent_GetSource()
            set DETarget = MHEvent_GetUnit()
            set DEDamage = MHDamageEvent_GetDamage()
            set Event.IsAttack[Event.INDEX] = MHDamageEvent_IsPhysical()

            set extraDamage = .0
            // 捕捉马甲伤害
            if UE and GetUnitTypeId(DESource)=='e00E' then
                // 机器人的进军
                call MarchOfTheMachinesDamagedEvent()
                // 闪电风暴
                call LightningStormDamagedEvent()
                // 马蹄践踏
                call HoofStompDamagedEvent()
                // 自然之怒
                call WrathOfNatureDamagedEvent()
                // call FTA()
            endif
            // 
            set DamagedEventSourcePlayerId = GetPlayerId(GetOwningPlayer(DESource))
            set DamagedEventPlayerId = GetPlayerId(GetOwningPlayer(DETarget))
            // =======================================================================
            // call SetAssistList()
            // 设置助攻列表
            set AssistListTime[AssistListCurrentMaxNumber]= (GetGameTime())
            set AssistListSourcePlayerId[AssistListCurrentMaxNumber] = DamagedEventSourcePlayerId
            set AssistListTargetPlayerId[AssistListCurrentMaxNumber] = DamagedEventPlayerId
            set AssistListCurrentMaxNumber = AssistListCurrentMaxNumber + 1
            if AssistListCurrentMaxNumber == 8000 then
                set AssistListCurrentMaxNumber = 1
            endif
            // =======================================================================
            if DEDamage > 0 and DEDamage < 9000 then
                set hu = GetHandleId(DETarget)
                set YO[0]= GetUnitTypeId(DETarget)
                // 设置真正的伤害来源 排除掉马甲
                if (IsUnitDummy(DESource)) then
                    set DESource = PlayerHeroes[DamagedEventSourcePlayerId]
                endif
                if IsUnitType(DETarget, UNIT_TYPE_HERO) then
                    set reducedDamage = GerHeroReducedDamage()
                    //if IsUnitType(DESource, UNIT_TYPE_HERO) then
                        // debug call SingleDebug( "伤害值:" + R2S(DEDamage) +" 减免伤害值:"  + R2S(reducedDamage) + " 比例：" + R2S( ( reducedDamage / DEDamage ) * 100.0 ) )
                    //endif
                else
                    if GetUnitAbilityLevel(DESource,'A39D') == 1 then
                        set reducedDamage = reducedDamage + DEDamage * .4
                    endif
                    if IsUnitIllusion(DESource) and Event.IsAttackDamage() then
                        if IsUnitStructure(DETarget) then
                            set reducedDamage = reducedDamage + DEDamage * 0.6
                        elseif DETarget == Roshan then
                            set reducedDamage = reducedDamage + DEDamage * 0.8
                        endif
                    endif
                    if GetUnitAbilityLevel(DETarget,'A3KF') == 1 then
                        set MC = RMinBJ(GetLivingArmorBlock(), DEDamage)
                        if MC > 0 then
                            set reducedDamage = reducedDamage + MC
                        endif
                    endif
                endif
                if reducedDamage > 0 then
                    // 判断受伤者有没有资格减免伤害
                    // 墓碑 蝗虫 冰球 追踪导弹 一类的单位不接受伤害减免
                    // 傻卵减伤以后优化
                    if not(CMX(YO[0]) or RQX(YO[0]) or RTX(YO[0]) or RJX(YO[0]) or R3X(YO[0]) or IsBeetleUnitTypeId(YO[0]) or R1X(YO[0])) then
                        // 给受伤者减免伤害
                        call SetUnitToReduceDamage(DETarget, reducedDamage)
                    endif
                endif
                set DEDamage = DEDamage - reducedDamage
                //call MHDamageEvent_SetDamage(DEDamage)
                // 数值减少
                // 如果减伤减完了就直接返回
                if DEDamage <= 0 then
                    set Event.INDEX = Event.INDEX - 1
                    return false
                endif
                
                // 记录单位最后受伤事件
                //if IsUnitHeroLevel(whichUnit) then
                    set Table[GetHandleId(DETarget)].real[UNIT_LAST_DAMGED_TIME] = GameTimer.GetElapsed()
                //endif

                if IsPlayerValid(GetOwningPlayer(DESource)) then
                    call UpdateUnitKelenDaggerDamagedCooldown(DETarget)
                    call UpdateUnitHeartOfTarrasqueDamagedCooldown(DETarget)
                endif

                // 绿鞋
                call TranquilBootsOnDamaged()

                call AnyUnitEvent.ExecuteEvent(DETarget, ANY_UNIT_EVENT_DAMAGED)

                // 额外的伤害事件 关于镜头震动和伤害显示 要在额外伤害打出之前运行
                if IsSinglePlayerMode then
                    call OtherDamagedEvent(DETarget, DESource, DEDamage - reducedDamage)
                endif
                // 打断物品
                //if IsUnitType(DETarget, UNIT_TYPE_HERO) and ( DEDamage ) > 10 and (IsPlayerValid( GetOwningPlayer( DESource ) ) or  DESource == Roshan ) then
                //    // 这里计算了减伤再打断
                //    call SaveReal(HY, GetHandleId( DETarget ), 785, GetGameTime())
                //endif
                // 灵魂超度
                if HaveVisage and not M_V then
                    call SoulAssumptionDamagedEvent()
                endif
                // 玲珑心
                // 直接用Japi来判断是否是技能伤害
                if HasOctarineCore and not Event.IsAttackDamage() then
                    set p = GetOwningPlayer(DESource)
                    // 伤害来源是否是 非电脑 玩家的单位
                    if p != SentinelPlayers[0] and p != ScourgePlayers[0] and p != NeutralCreepPlayer then
                        if GetUnitAbilityLevel(DESource,'A39S') == 1 and IsUnitIllusion(DETarget) == false and GetWidgetLife(DESource)>= 1 then
                            call SpellLifesteal()
                        endif
                    endif
                endif
                // 伤害增加
                if LoadInteger(HY, GetHandleId(GetTriggeringTrigger()),'AMPL') == 0 then
                    set extraDamage = LoadReal(HY, hu,'AMPL')
                    if AX and(GetUnitAbilityLevel(DESource,'A460')> 0) and IsUnitEnemy(DESource, GetOwningPlayer(DETarget)) and IsAliveNotStrucNotWard(DETarget) then
                        // 致命创伤 再造成一次伤害
                        call DOR(DESource, DETarget)
                    endif
                    if IX then
                        if (IsUnitDummy(DESource) or IsUnitWard(DESource)) and not IsUnitType(DESource, UNIT_TYPE_HERO) then
                            set DESource = PlayerHeroes[DamagedEventSourcePlayerId]
                        else
                            set DESource = DESource
                        endif
                        if GetUnitAbilityLevel(DESource,'A44Y')> 0 or GetUnitAbilityLevel(DETarget,'A44Y')> 0 then
                            if GetUnitDistanceEx(DESource, DETarget)< 2200 then
                                if GetUnitAbilityLevel(DESource,'A44Y')> 0 then
                                    set extraDamage = extraDamage + LoadReal(HY, GetHandleId(DESource),'A2X9')
                                endif
                            else
                                if GetUnitAbilityLevel(DESource,'A44Y')> 0 then
                                    set extraDamage = extraDamage + LoadReal(HY, GetHandleId(DESource),'A2X9')/ 2
                                endif
                                if GetUnitAbilityLevel(DETarget,'A44Y')> 0 then
                                    set extraDamage = extraDamage - LoadReal(HY, hu,'A2X9')/ 2
                                endif
                            endif
                        endif
                    endif
                endif
                if extraDamage > 0 then
                    call SaveInteger(HY, GetHandleId(GetTriggeringTrigger()),'AMPL', LoadInteger(HY, GetHandleId(GetTriggeringTrigger()),'AMPL')+ 1)
                    call UnitDamageTargetEx(DESource, DETarget, 3, DEDamage * extraDamage)
                    call AQX("+" + I2S(R2I(DEDamage * extraDamage)), 4, DETarget, .028, 128, 255, 0, 0, 216)
                    call SaveInteger(HY, GetHandleId(GetTriggeringTrigger()),'AMPL', LoadInteger(HY, GetHandleId(GetTriggeringTrigger()),'AMPL')-1)
                endif
                if GetUnitAbilityLevel(DETarget,'A43C')> 0 and IsUnitEnemy(DESource, GetOwningPlayer(DETarget)) and WE == 0 then
                    call T4A(DESource, DETarget, DEDamage)
                endif
                //if AD < 1 then
                //endif
            endif
            if TEST_MODE then
                call AQX("+" + I2S(R2I(DEDamage)), 1, DETarget, .028, 64, 255, 0, 0, 216)
            endif
            set Event.INDEX = Event.INDEX - 1
            //set DETarget = null
            //set DESource = null
            //set DESource = null
            return false
        endmethod
    
        static method AnyUnitDamagingEvent takes nothing returns boolean
            

            return false
        endmethod

    endstruct

    function DamageSystem_Init takes nothing returns nothing
        set AnyUnitDamagedTrig = CreateTrigger()
        call TriggerAddCondition(AnyUnitDamagedTrig, Condition(function DamageEvent.AnyUnitDamagedEvent))
        call MHDamageEvent_Register(AnyUnitDamagedTrig)

        set AnyUnitDamagingTrig = CreateTrigger()
        call TriggerAddCondition(AnyUnitDamagingTrig, Condition(function DamageEvent.AnyUnitDamagingEvent))
        call MHDamagingEvent_Register(AnyUnitDamagingTrig)

    endfunction

endscope
