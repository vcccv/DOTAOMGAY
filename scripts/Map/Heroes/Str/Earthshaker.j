
scope Earthshaker

    function FissureOnSpellEffect takes nothing returns nothing
        local unit trigUnit = GetTriggerUnit()
        local unit targetUnit = GetSpellTargetUnit()
        local real sx = GetUnitX(trigUnit)
        local real sy = GetUnitY(trigUnit)
        local real tx
        local real ty
        local real x
        local real y
        local real radin
        local group enumGroup = AllocationGroup(191)
        local group targGroup = AllocationGroup(192)
        local player p = GetOwningPlayer(trigUnit)
        local unit first
        local real range = 225.
        local real damage = GetUnitAbilityLevel(trigUnit, 'A0SK') * 50. + 60.
        local real duration = GetUnitAbilityLevel(trigUnit, 'A0SK') * .25 + .75
        local real maxDistance = 1320. + GetUnitCastRangeBonus(trigUnit)
        local real distance = 0.
    
        if targetUnit == null then
            set tx = GetSpellTargetX()
            set ty = GetSpellTargetY()
        else
            set tx = GetUnitX(targetUnit)
            set ty = GetUnitY(targetUnit)
        endif
    
        set radin = bj_DEGTORAD * AngleBetweenXY(sx, sy, tx, ty)
        loop
            exitwhen(maxDistance - distance) <= 0. //i > 22 60*22=1320
    
            set distance = distance + 60.
            set x = CoordinateX50(sx + distance * Cos(radin))
            set y = CoordinateY50(sy + distance * Sin(radin))
            call GroupEnumUnitsInRange(enumGroup, x, y, range + MAX_UNIT_COLLISION, null)
    
            loop
                set first = FirstOfGroup(enumGroup)
                exitwhen first == null
                call GroupRemoveUnit(enumGroup, first)
    
                if IsUnitInRangeXY(first, x, y, range) and IsUnitEnemy(first, p) and IsAliveNotStrucNotWard(first) and IsNotAncientOrBear(first) then
                    call GroupAddUnit(targGroup, first)
                endif
    
            endloop
    
            call RemoveDestructableToTimed(CreateDestructable('B000', x, y, GetRandomReal(0, 360), .5, GetRandomInt(0, 2)), 8)
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl", x, y))
        endloop
        
        loop
            set first = FirstOfGroup(targGroup)
            exitwhen first == null
            call GroupRemoveUnit(targGroup, first)
    
            if UnitAlive(first) then
                call UnitDamageTargetEx(trigUnit, first, 1, damage)
                call CommonUnitAddStun(first, duration, false)
            endif
    
        endloop
    
        call DeallocateGroup(enumGroup)
        call DeallocateGroup(targGroup)
    
        set targetUnit = null
        set trigUnit = null
    endfunction

endscope
