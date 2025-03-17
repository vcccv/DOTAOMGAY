scope Rubick

    globals
        constant integer HERO_INDEX_RUBICK = 53
    endglobals

    //***************************************************************************
    //*
    //*  隔空取物
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_TELEKINESIS = GetHeroSKillIndexBySlot(HERO_INDEX_RUBICK, 1)
    endglobals
    
    function JHA takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local unit targetUnit = LoadUnitHandle(HY, h, 17)
        local real a = LoadReal(HY, h, 137)
        local real tx = LoadReal(HY, h, 47)
        local real ty = LoadReal(HY, h, 48)
        local real sx = LoadReal(HY, h, 189)
        local real sy = LoadReal(HY, h, 190)
        local group g
        local real d = GetDistanceBetween(sx, sy, tx, ty)/ 25
        local location l
        local integer count = GetTriggerEvalCount(t)
        local real x = sx + d * count * Cos(a)
        local real y = sy + d * count * Sin(a)
        if IsUnitType(targetUnit, UNIT_TYPE_HERO) then
            call SaveBoolean(OtherHashTable, GetHandleId(targetUnit), 99, true)
        endif
        call SetUnitX(targetUnit, CoordinateX50(x))
        call SetUnitY(targetUnit, CoordinateY50(y))
        if IsUnitModelFlying(targetUnit) == false then
            call SetUnitFlyHeight(targetUnit, 325  -13* count, 0)
        endif
        if count == 25 then
            call SetUnitPositionEx(targetUnit, CoordinateX50(tx), CoordinateY50(ty))
            
            set TempUnit = whichUnit
            set g = AllocationGroup(458)
            call GroupEnumUnitsInRange(g, GetUnitX(targetUnit), GetUnitY(targetUnit), 350, Condition(function DKX))
            call GroupRemoveUnit(g, targetUnit)
            set LI = LoadInteger(HY, h, 0)
            call ForGroup(g, function JGA)
            call DeallocateGroup(g)
            call KillTreeByCircle(GetUnitX(targetUnit), GetUnitY(targetUnit), 150)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(targetUnit), GetUnitY(targetUnit)))
            call DestroyEffect(LoadEffectHandle(HY, h, 32))
            call DestroyEffect(LoadEffectHandle(HY, h, 176))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            if IsUnitModelFlying(targetUnit) == false then
                call SetUnitFlyHeight(targetUnit, GetUnitDefaultFlyHeight(targetUnit), 0)
            endif
            call UnitDecNoPathingCount(targetUnit)

        endif
        set t = null
        set whichUnit = null
        set targetUnit = null
        set g = null
        return false
    endfunction
    function TelekinesisLand takes unit whichUnit, unit targetUnit, unit Target2, real JKA, real JLA, effect FX, effect JMA, integer level returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local real tx = JKA
        local real ty = JLA
        local real a = AngleBetweenXY(GetUnitX(targetUnit), GetUnitY(targetUnit), JKA, JLA)* bj_DEGTORAD
        if GetDistanceBetween(GetUnitX(targetUnit), GetUnitY(targetUnit), JKA, JLA)> 375 then
            set tx = GetUnitX(targetUnit) + 375 * Cos(a)
            set ty = GetUnitY(targetUnit) + 375 * Sin(a)
        endif
        call UnitIncNoPathingCount(targetUnit)

        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveUnitHandle(HY, h, 17, targetUnit)
        call SaveReal(HY, h, 137, a * 1.)
        call SaveReal(HY, h, 47, tx * 1.)
        call SaveReal(HY, h, 48, ty * 1.)
        call SaveReal(HY, h, 189, GetUnitX(targetUnit)* 1.)
        call SaveReal(HY, h, 190, GetUnitY(targetUnit)* 1.)
        call SaveEffectHandle(HY, h, 32, FX)
        call SaveEffectHandle(HY, h, 176, JMA)
        call SaveInteger(HY, h, 0, level)
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerAddCondition(t, Condition(function JHA))
        set t = null
    endfunction
    function TelekinesisUpdate takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local unit targetUnit = LoadUnitHandle(HY, h, 17)
        local integer count = LoadInteger(HY, h, 34)
        local integer KLR = LoadInteger(HY, h, 12)
        local real tx = LoadReal(HY, h, 47)
        local real ty = LoadReal(HY, h, 48)
        local integer JQA = LoadInteger(HY, h, 706)
        local real a
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or(GetTriggerEventId() != EVENT_UNIT_SPELL_EFFECT and C5X(targetUnit) == false) then
            // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A27F', true)
            // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A27X', false)
            call ToggleSkill.SetState(whichUnit, 'A27F', false)

            call TelekinesisLand(whichUnit, targetUnit, LoadUnitHandle(HY, h, 711), tx, ty, LoadEffectHandle(HY, h, 32), LoadEffectHandle(HY, h, 176), LoadInteger(HY, h, 0))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        elseif GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
            if GetSpellAbilityId()=='A27X' then
                call DestroyEffect((LoadEffectHandle(HY, h, 176)))
                set a = AngleBetweenXY(GetUnitX(targetUnit), GetUnitY(targetUnit), GetSpellTargetX(), GetSpellTargetY())* bj_DEGTORAD
                if GetDistanceBetween(GetUnitX(targetUnit), GetUnitY(targetUnit), GetSpellTargetX(), GetSpellTargetY())> 375 then
                    set tx = GetUnitX(targetUnit) + 375 * Cos(a)
                    set ty = GetUnitY(targetUnit) + 375 * Sin(a)
                else
                    set tx = GetSpellTargetX()
                    set ty = GetSpellTargetY()
                endif
                call SaveEffectHandle(HY, h, 176, AddSpecialEffect("Abilities\\Spells\\Other\\GeneralAuraTarget\\GeneralAuraTarget.mdl", tx, ty))
                call SaveReal(HY, h, 47, tx * 1.)
                call SaveReal(HY, h, 48, ty * 1.)
                call SaveUnitHandle(HY, h, 711, GetSpellTargetUnit())
                call SaveEffectHandle(HY, h, 176, AddSpecialEffectTarget("Abilities\\Spells\\Other\\GeneralAuraTarget\\GeneralAuraTarget.mdl", GetSpellTargetUnit(), "origin"))
            endif
        else
            set count = count + 1
            call SaveInteger(HY, h, 34, count)
            call SetUnitPathing(targetUnit, false)
            if (LoadInteger(HY, h, 707)) == 1 then
                set JQA = JQA + 3
            else
                set JQA = JQA -3
            endif
            call SaveInteger(HY, h, 706, JQA)
            if JQA == 30 then
                call SaveInteger(HY, h, 707,-1)
            elseif JQA ==-30 then
                call SaveInteger(HY, h, 707, 1)
            endif
            if IsUnitModelFlying(targetUnit) == false then
                if count < 15 then
                    call SetUnitFlyHeight(targetUnit, count * 20, 0)
                else
                    call SetUnitFlyHeight(targetUnit, 300 + JQA, 0)
                endif
            endif
            if count >(KLR -25) then
                if IsUnitModelFlying(targetUnit) == false then
                    call SetUnitFlyHeight(targetUnit, 300, 0)
                endif
                call UnitDecNoPathingCount(targetUnit)
                call ToggleSkill.SetState(whichUnit, 'A27F', false)

                call TelekinesisLand(whichUnit, targetUnit, LoadUnitHandle(HY, h, 711), tx, ty, LoadEffectHandle(HY, h, 32), LoadEffectHandle(HY, h, 176), LoadInteger(HY, h, 0))
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            endif
        endif
        set t = null
        set whichUnit = null
        set targetUnit = null
        return false
    endfunction
    function TelekinesisOnSpellEffectAS takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local unit targetUnit = GetSpellTargetUnit()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local integer level = GetUnitAbilityLevel(whichUnit,'A27F')
        local real TXR = 1.25 + .25 * level
        local unit dummyCaster = CreateUnit(GetOwningPlayer(targetUnit),'e00E', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
        set TXR = CommonUnitAddStun(targetUnit, TXR, false)
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A27F', false)
        // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A27X', true)
        // call UnitAddAbility(whichUnit,'A27X')
        call ToggleSkill.SetState(whichUnit, 'A27F', true)

        call UnitIncNoPathingCount(targetUnit)

        if IsUnitModelFlying(targetUnit) == false then
            call UnitAddPermanentAbility(targetUnit,'Amrf')
            call UnitRemoveAbility(targetUnit,'Amrf')
        endif
        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveUnitHandle(HY, h, 17, targetUnit)
        call SaveUnitHandle(HY, h, 711, targetUnit)
        call SaveInteger(HY, h, 12, R2I(TXR / .02))
        call SaveInteger(HY, h, 34, 0)
        call SaveInteger(HY, h, 0, level)
        call SaveInteger(HY, h, 706, 0)
        call SaveInteger(HY, h, 707, 1)
        call SaveReal(HY, h, 47, GetUnitX(targetUnit)* 1.)
        call SaveReal(HY, h, 48, GetUnitY(targetUnit)* 1.)
        call SaveEffectHandle(HY, h, 32, AddSpecialEffectTarget("war3mapImported\\AntiGravityTarget.mdx", targetUnit, "origin"))
        call SaveEffectHandle(HY, h, 176, AddSpecialEffect("Abilities\\Spells\\Other\\GeneralAuraTarget\\GeneralAuraTarget.mdl", GetUnitX(targetUnit), GetUnitY(targetUnit)))
        call TriggerRegisterTimerEvent(t, .02, true)
        call TriggerRegisterDeathEvent(t, targetUnit)
        call TriggerRegisterUnitEvent(t, whichUnit, EVENT_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(t, Condition(function TelekinesisUpdate))
        set whichUnit = null
        set targetUnit = null
        set t = null
        set dummyCaster = null
    endfunction
    function TelekinesisOnSpellEffect takes nothing returns nothing
        if not UnitHasSpellShield(GetSpellTargetUnit()) then
            call TelekinesisOnSpellEffectAS()
        endif
    endfunction

    //***************************************************************************
    //*
    //*  技能窃取
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_SPELL_STEAL = GetHeroSKillIndexBySlot(HERO_INDEX_RUBICK, 4)
    endglobals
    function J1A takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit u = (LoadUnitHandle(HY, h, 2))
        local integer id = (LoadInteger(HY, h, 704))
        local integer time = (LoadInteger(HY, h, 713))
        if id ==(LoadInteger(HY,(GetHandleId(u)), 704) ) then
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        elseif GetTriggerEvalCount(t)>(15 - time) and UnitAlive(u) then
            call UnitRemoveAbility(u, id)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
        set u = null
        return false
    endfunction
    // 开计时器 多少秒后删除技能
    function J4A takes unit u, integer id, real r returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        call TriggerRegisterTimerEvent(t, 1, true)
        call TriggerAddCondition(t, Condition(function J1A))
        call SaveUnitHandle(HY, h, 2,(u))
        call SaveInteger(HY, h, 704,(id))
        call SaveInteger(HY,(GetHandleId(u)), 704,(-1))
        call SaveInteger(HY, h, 713,(R2I(GetGameTime()-r)))
        set t = null
    endfunction
    function J5A takes nothing returns boolean
        local trigger t  = GetTriggeringTrigger()
        local integer h  = GetHandleId(t)
        local unit    u  = (LoadUnitHandle(HY, h, 2))
        local integer id = (LoadInteger(HY, h, 704))
        local integer c  = (LoadInteger(HY, h, 34))
        local real    r  = (LoadReal(HY, h, 411))
        if GetTriggerEventId() != EVENT_UNIT_SPELL_EFFECT and GetTriggerEventId() != EVENT_WIDGET_DEATH then
            // 警告
            if c == 0 then
                call SaveInteger(HY, h, 34, 1)
                call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10, "|c00ff0303" + GetObjectName('n0LW') + "|r")
            else
                //call BYR(u)
                call SetPlayerAbilityAvailableEx(GetOwningPlayer(u), id, false)
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
                call J4A(u, id, r)
            endif
        elseif GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT then
            // 施法窃取时
            if (GetSpellAbilityId()=='A27H' or GetSpellAbilityId()=='A30J') then
                if LoadInteger(HY,(GetHandleId(GetSpellTargetUnit())), 705) != id then
                    call SetPlayerAbilityAvailableEx(GetOwningPlayer(u), id, false)
                    call J4A(u, id, r)
                endif
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            elseif GetSpellAbilityId() == id then
            //if GetSpellAbilityId() == id then
                call SaveReal(HY, h, 411, GetGameTime()* 1.)
            endif
        elseif GetTriggerEventId() == EVENT_WIDGET_DEATH then
            //call BYR(u)
            call SetPlayerAbilityAvailableEx(GetOwningPlayer(u), id, false)
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
            call J4A(u, id, r)
        endif
        set t = null
        set u = null
        return false
    endfunction
    function J6A takes unit u, integer id, integer level returns nothing
        if id == 'A2O2' then
            set TempUnit = u
            call ExecuteFunc("PAI")
        endif
    endfunction
    function SpellStealMissileOnHit takes nothing returns nothing
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit    u        = (LoadUnitHandle(HY, h, 2))
        local unit    target   = (LoadUnitHandle(HY, h, 17))
        local integer targetId = (LoadInteger(HY, h, 704))
        local integer lv       = (LoadInteger(HY, h, 5))
        local real    duration = 60 *(2 + IMaxBJ(GetUnitAbilityLevel(u,'A27H'), GetUnitAbilityLevel(u,'A30J')))
        local integer id       = GetPlayerId(GetOwningPlayer(u))
        local boolean success  = (GetUnitAbilityLevel(u, targetId) == 0) or targetId == LoadInteger(HY,(GetHandleId(u)), 704)
        local integer i = 1
        call PlaySoundAtPosition(SpellStealTargetSound, GetUnitX(u), GetUnitY(u))
        // 如果自己已经有这个技能，则偷窃失败。
        // 另外，如果此技能是子技能，要根据子技能去溯源得到原始技能，如果自己选过原始技能，则同样会窃取失败
        loop
        exitwhen i > 4 + ExtraSkillsCount or success == false
            if HeroSkill_BaseId[PlayerSkillIndices[id * MAX_SKILL_SLOTS + i]] == targetId then
                set success = false
            endif
            if HeroSkill_SpecialId[PlayerSkillIndices[id * MAX_SKILL_SLOTS + i]] == targetId then
                set success = false
            endif
            set i = i + 1
        endloop
        if success then
            if (LoadInteger(HY,(GetHandleId(target)), 710)) > 0 then
                call SaveInteger(HY,(GetHandleId(u)), 710,((LoadInteger(HY,(GetHandleId(target)), 710))))
            endif

            call CommonTextTag(GetObjectName(targetId), 3.5, u, .024, 170, 0, 255, 216)
            call SaveInteger(HY,(GetHandleId(u)), 704,(targetId))
            // 启用技能
            call SetPlayerAbilityAvailableEx(GetOwningPlayer(u), targetId, true)
            call UnitAddPermanentAbility(u, targetId)
            call SetUnitAbilityLevel(u, targetId, lv)
            call J6A(u, targetId, lv)
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call SaveUnitHandle(HY, h, 2,(u))
            call SaveInteger(HY, h, 34, 0)
            call SaveInteger(HY, h, 704,(targetId))
            call TriggerRegisterUnitEvent(t, u, EVENT_UNIT_SPELL_EFFECT)
            call TriggerRegisterTimerEvent(t, duration, false)
            call TriggerRegisterDeathEvent(t, u)
            call TriggerRegisterTimerEvent(t, duration -20, false)
            call TriggerAddCondition(t, Condition(function J5A))
        else
            call CommonTextTag("窃取失败 ;(", 3.5, u, .024, 170, 0, 255, 216)
        endif
        set t = null
        set u = null
        set target = null
    endfunction
    function SpellStealMissileLaunch takes unit u, unit target, integer id, integer lv returns nothing
        local trigger t = LaunchMissileByUnitDummy(target, u,'h0DB', "SpellStealMissileOnHit", 900, false)
        local integer h = GetHandleId(t)
        call PlaySoundAtPosition(SpellStealMissileLaunchSound, GetUnitX(target), GetUnitY(target))
        call CommonTextTag(GetObjectName(id), 3.75, target, .024, 170, 0, 255, 216)
        call SaveUnitHandle(HY, h, 2,(u))
        call SaveUnitHandle(HY, h, 17,(target))
        call SaveInteger(HY, h, 704,(id))
        call SaveInteger(HY, h, 5,(lv))
        set t = null
    endfunction

    function SpellStealOnSpellEffectAS takes nothing returns nothing
        local unit u     = GetTriggerUnit()
        local unit t     = GetSpellTargetUnit()
        local integer id = LoadInteger(HY,(GetHandleId(t)), 705) // last_spell_ability_id
        local boolean b  = GetSpellAbilityId() =='A30J'
        local integer skillIndex = 0
        if id != 0 then
            // 根据施法者自身的神杖升级修正
            set skillIndex = GetSkillScepterUpgradeIndexById(id)
            if b then
                if skillIndex > 0 and ScepterUpgrade_UpgradedId[skillIndex] > 0 then
                    set id = ScepterUpgrade_UpgradedId[skillIndex]
                endif
            else
                if skillIndex > 0 and ScepterUpgrade_BaseId[skillIndex] > 0 then
                    set id = ScepterUpgrade_BaseId[skillIndex]
                endif
            endif
            call DestroyEffect(AddSpecialEffectTarget("war3mapImported\\Nebula.mdx", t, "origin"))
            call SpellStealMissileLaunch(u, t, id, LoadInteger(HY, GetHandleId(t), 712))
        endif
        set u = null
        set t = null
    endfunction
    function SpellStealOnSpellEffect takes nothing returns nothing
        if not UnitHasSpellShield(GetSpellTargetUnit()) then
            call SpellStealOnSpellEffectAS()
        endif
    endfunction
    
    function JZA takes integer id returns nothing
        set QAV[QNV] = id
        set QNV = QNV + 1
    endfunction
    function J_A takes integer id returns boolean
        local integer i = 0
        if IsNotItemAbility(id) == false then
            return true
        endif
        loop
        exitwhen i == QNV
            if id == QAV[i] then
                return true
            endif
            set i = i + 1
        endloop
        return false
    endfunction

    //lbk 不能偷的技能
    function KOA takes nothing returns nothing
        call JZA('QB0L')
        call JZA('A0A5')
        call JZA('A0AG')
        call JZA('A0BG')
        call JZA('A0DY')
        call JZA('A0ES')
        call JZA('A0FH')
        call JZA('A0GC')
        call JZA('A0NS')
        call JZA('A0Q5')
        call JZA('A0TE')
        call JZA('A0TK')
        call JZA('A0WP')
        call JZA('A0WQ')
        call JZA('A03G')
        call JZA('A03J')
        call JZA('A04J')
        call JZA('A04M')
        call JZA('A04N')
        call JZA('A073')
        call JZA('A1C0')
        call JZA('A1DA')
        call JZA('A1EA')
        call JZA('A1FQ')
        call JZA('A1MN')
        call JZA('A1NA')
        call JZA('A1NH')
        call JZA('A1RI')
        call JZA('A1S9')
        call JZA('A1T8')
        call JZA('A1TU')
        call JZA('A1TX')
        call JZA('A1VG')
        //call JZA('A1VH')
        call JZA('A1VU')
        call JZA('A1WF')
        call JZA('A1WO')
        call JZA('A1Z2')
        call JZA('A1Z3')
        call JZA('A2FX')
        call JZA('A2JL')
        call JZA('A2JO')
        call JZA('A2JP')
        call JZA('A2JQ')
        call JZA('A2JR')
        call JZA('A2K9')
        call JZA('A2KE')
        call JZA('A2KH')
        call JZA('A10R')
        //call JZA('A11N')
        call JZA('A11T')
        call JZA('A20N')
        call JZA('A21H')
        call JZA('A21J')
        call JZA('A24A')
        call JZA('A24B')
        call JZA('A24E')
        call JZA('A27F')
        call JZA('A27G')
        call JZA('A27H')
        call JZA('A27X')
        call JZA('A28F')
        call JZA('A28Q')
        call JZA('A30J')
        call JZA('A32D')
        call JZA('A43D')
        call JZA('A43P')
        call JZA('A121')
        call JZA('A205')
        call JZA('A229')
        call JZA('A418')
        call JZA('ANcr')
        call JZA('QB0K')
        call JZA('QB03')
        call JZA('QM00')
        call JZA('QM01')
        call JZA('QM02')
        call JZA('QM03')
        call JZA('QM04')
        call JZA('Z234')
    endfunction
    
    function J0A takes nothing returns boolean
        local unit u = GetTriggerUnit()
        local integer id = GetSpellAbilityId()
        local integer h
        if IsUnitType(u, UNIT_TYPE_HERO) and J_A(id) == false and not IsUnitWard(u) then
            set h = GetHandleId(u)
            call SaveInteger(HY, h, 705, id)
            call SaveInteger(HY, h, 712, GetUnitAbilityLevel(u, id))
        endif
        set u = null
        return false
    endfunction
    function P2X takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterAnyUnitEvent(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(t, Condition(function J0A))
        set t = null
        call KOA()
    endfunction

endscope
