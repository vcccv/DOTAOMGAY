
library UnitModel
    
    function SaveHeroModelScale takes integer heroTypeId, real scaleData, integer unitTypeId returns nothing
        //set DJ = DJ + 1
        call SaveReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_SCALE, heroTypeId, scaleData )
        if unitTypeId != 0 and unitTypeId != heroTypeId then
            call SaveReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_SCALE, unitTypeId, scaleData )
        endif
        //set AJ[DJ]= XEX
        //set BJ[DJ]= XVX
        //set CJ[DJ]= XXX
    endfunction

    function GetUnitModelScale takes unit whichUnit returns real
        local integer unitTypeId = GetUnitTypeId(whichUnit)
        local real data = LoadReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_SCALE, unitTypeId )
        if data != 0 then
            return data
        else
            set data = EXGetUnitReal( unitTypeId, UNIT_REAL_MODEL_SCALE )
            call SaveReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_SCALE, unitTypeId, data )
            if data == 0 then
                //call BJDebugMsg("错误， " + GetUnitName(whichUnit) + " 没有被保存缩放")
                return 1.
            endif
            return data
        endif

        return 1.
    endfunction

    // 设置并保存单位当前缩放值
    function SetUnitCurrentScaleEx takes unit whichUnit, real unitScale returns real
        local real modelScale = GetUnitModelScale(whichUnit) * unitScale + LoadReal( ExtraHT, GetHandleId(whichUnit), HTKEY_UNIT_CURRENT_ADDSCALE )
        // debug call SingleDebug( R2S( modelScale )  + " unitScale" + R2S(unitScale))
        call SetUnitScale(whichUnit, modelScale, modelScale, modelScale)
        call SaveReal( ExtraHT, GetHandleId(whichUnit), HTKEY_UNIT_CURRENT_PERCENT_SCALE, unitScale )
        return modelScale
    endfunction

    // 获取单位当前缩放值
    function GetUnitCurrentScale takes unit whichUnit returns real
        local real data = LoadReal( ExtraHT, GetHandleId(whichUnit), HTKEY_UNIT_CURRENT_PERCENT_SCALE )
        if data == 0 then
            return 1.
        endif
        return data
    endfunction

    function JFX takes unit u returns nothing
        local integer unitTypeId = GetUnitTypeId(u)
        local integer a = 255
        if HaveSavedInteger(ObjectHashTable, GetHandleId(u),'ALPH') then
            set a = LoadInteger(ObjectHashTable, GetHandleId(u),'ALPH')
        endif
        call SetUnitVertexColor(u, 128, 192, 192, a)
        call SaveInteger(ObjectHashTable, GetHandleId(u), IC + 0, 128)
        call SaveInteger(ObjectHashTable, GetHandleId(u), IC + 1, 192)
        call SaveInteger(ObjectHashTable, GetHandleId(u), IC + 2, 192)
        call SaveInteger(ObjectHashTable, GetHandleId(u),'ALPH', a)
    endfunction
    // 恢复单位的RGB
    function ResetUnitVertexColor takes unit u returns nothing
        local integer unitTypeId = GetUnitTypeId(u)
        local integer r = 255
        local integer g = 255
        local integer b = 255
        local integer a = 255
        if HaveSavedInteger(UnitRGBHashTable, unitTypeId, 0) then
            set r = LoadInteger(UnitRGBHashTable, unitTypeId, 0)
        endif
        if HaveSavedInteger(UnitRGBHashTable, unitTypeId, 1) then
            set g = LoadInteger(UnitRGBHashTable, unitTypeId, 1)
        endif
        if HaveSavedInteger(UnitRGBHashTable, unitTypeId, 2) then
            set b = LoadInteger(UnitRGBHashTable, unitTypeId, 2)
        endif
        if HaveSavedInteger(ObjectHashTable, GetHandleId(u),'ALPH') then
            set a = LoadInteger(ObjectHashTable, GetHandleId(u),'ALPH')
        endif
        call SetUnitVertexColor(u, r, g, b, a)
        call SaveInteger(ObjectHashTable, GetHandleId(u), IC + 0, r)
        call SaveInteger(ObjectHashTable, GetHandleId(u), IC + 1, g)
        call SaveInteger(ObjectHashTable, GetHandleId(u), IC + 2, b)
        call SaveInteger(ObjectHashTable, GetHandleId(u),'ALPH', a)
    endfunction
    function SetUnitVertexColorEx takes unit u, integer r, integer g, integer b, integer a returns nothing
        local integer unitTypeId = GetUnitTypeId(u)
        local integer h = GetHandleId(u)
        if r ==-1 then
            if HaveSavedInteger(ObjectHashTable, h, IC + 0) then
                set r = LoadInteger(ObjectHashTable, h, IC + 0)
            elseif HaveSavedInteger(UnitRGBHashTable, unitTypeId, 0) then
                set r = LoadInteger(UnitRGBHashTable, unitTypeId, 0)
            else
                set r = 255
            endif
        endif
        if g ==-1 then
            if HaveSavedInteger(ObjectHashTable, h, IC + 1) then
                set g = LoadInteger(ObjectHashTable, h, IC + 1)
            elseif HaveSavedInteger(UnitRGBHashTable, unitTypeId, 1) then
                set g = LoadInteger(UnitRGBHashTable, unitTypeId, 1)
            else
                set g = 255
            endif
        endif
        if b ==-1 then
            if HaveSavedInteger(ObjectHashTable, h, IC + 2) then
                set b = LoadInteger(ObjectHashTable, h, IC + 2)
            elseif HaveSavedInteger(UnitRGBHashTable, unitTypeId, 2) then
                set b = LoadInteger(UnitRGBHashTable, unitTypeId, 2)
            else
                set b = 255
            endif
        endif
        if a ==-1 then
            if HaveSavedInteger(ObjectHashTable, h,'ALPH') then
                set a = LoadInteger(ObjectHashTable, h,'ALPH')
            else
                set a = 255
            endif
        endif
        call SetUnitVertexColor(u, r, g, b, a)
        call SaveInteger(ObjectHashTable, h, IC + 0, r)
        call SaveInteger(ObjectHashTable, h, IC + 1, g)
        call SaveInteger(ObjectHashTable, h, IC + 2, b)
        call SaveInteger(ObjectHashTable, h,'ALPH', a)
    endfunction

endlibrary
