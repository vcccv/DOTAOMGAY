//----------------------------------------------------------------------MemHackUnitBaseAPI----------------------------------------------------------------------//

//! nocjass
library MemoryHackUnitBaseAPI
    // Unit API Engine
    function GetUnitBaseDataById takes integer uid returns integer
        local integer addr = LoadInteger( MemHackTable, StringHash("CUnitBase"), StringHash("DataNode") )

        if addr != 0 and uid != 0 then
            return GetAgileDataNodeById( addr, uid )
        endif

        return 0
    endfunction

    function GetUnitBaseData takes unit u returns integer
        return GetUnitBaseDataById( GetUnitTypeId( u ) )
    endfunction

    function GetUnitBaseDataByIdCaching takes integer uid returns integer
        // DEF_ADR_UNIT_DATA = 2
        local integer pUnit = 0

        if uid > 0 then
            if HaveSavedInteger( htObjectDataPointers, 2, uid ) then 
                return LoadInteger( htObjectDataPointers, 2, uid )
            endif

            set pUnit = GetUnitBaseDataById( uid )

            if pUnit > 0 then
                call SaveInteger( htObjectDataPointers, 2, uid, pUnit )
            endif

            return pUnit
        endif

        return 0
    endfunction

    function GetUnitBaseDataCaching takes unit u returns integer
        return GetUnitBaseDataByIdCaching( GetUnitTypeId( u ) )
    endfunction

    function GetUnitBaseUIDataById takes integer uid returns integer
        local integer addr = LoadInteger( MemHackTable, StringHash("CUnitBase"), StringHash("UINode") )

        if addr != 0 and uid != 0 then
            return GetWidgetUIDefById( uid )
        endif

        return 0
    endfunction

    function GetUnitBaseUIData takes unit u returns integer
        return GetUnitBaseUIDataById( GetUnitTypeId( u ) )
    endfunction

    function GetUnitBaseUIDataByIdCaching takes integer uid returns integer
        // DEF_ADR_UNIT_UI = 3
        local integer pUnit = 0

        if uid > 0 then
            if HaveSavedInteger( htObjectDataPointers, 3, uid ) then 
                return LoadInteger( htObjectDataPointers, 3, uid )
            endif

            set pUnit = GetUnitBaseUIDataById( uid )
            if pUnit > 0 then
                call SaveInteger( htObjectDataPointers, 3, uid, pUnit )
            endif

            return pUnit
        endif

        return 0
    endfunction

    function GetUnitBaseUIDataCaching takes unit u returns integer
        return GetUnitBaseUIDataByIdCaching( GetUnitTypeId( u ) )
    endfunction
    //===========================================

    // Unit Base UI Data Engine
    function GetUnitBaseUIIntegerParam takes integer uid, integer pointerlevel, integer offset returns integer
        return GetWidgetBaseUIIntegerParamById( uid, pointerlevel, offset )
    endfunction

    function SetUnitBaseUIIntegerParam takes integer uid, integer pointerlevel, integer offset, integer val returns nothing
        call SetWidgetBaseUIIntegerParamById( uid, pointerlevel, offset, val )
    endfunction

    function GetUnitBaseUIStringParam takes integer uid, integer pointerlevel, integer offset returns string
        return GetWidgetBaseUIStringParamById( uid, pointerlevel, offset )
    endfunction

    function SetUnitBaseUIStringParam takes integer uid, integer pointerlevel, integer offset, string val returns nothing
        call SetWidgetBaseUIStringParamById( uid, pointerlevel, offset, val )
    endfunction
    //===========================================
    
    // Unit Base UI Data API by Id
    function GetUnitBasePortraitById takes integer uid returns string
        local integer pData = 0

        if uid > 0 then
            set pData = GetUnitBaseUIDataByIdCaching( uid )

            if pData > 0 then
                set pData = ReadRealMemory( pData + 0x38 )

                if pData > 0 then
                    return ToJString( pData )
                endif
            endif
        endif

        return null
    endfunction

    function SetUnitBasePortraitById takes integer uid, string model returns nothing
        local integer pData = 0

        if uid > 0 then
            set pData = GetUnitBaseUIDataByIdCaching( uid )

            if pData > 0 then
                call WriteRealMemory( pData + 0x38, GetStringAddress( model ) )
            endif
        endif
    endfunction

    function GetUnitBaseMissileArtById takes integer uid, integer index returns string
        local integer pData = 0

        if uid > 0 then
            if index == 0 or index == 1 then
                set pData = GetUnitBaseUIDataByIdCaching( uid )
        
                if pData > 0 then
                    set pData = ReadRealMemory( pData + 0x44 )

                    if pData > 0 then
                        return ToJString( ReadRealMemory( pData + index * 4 ) )
                    endif
                endif
            endif
        endif

        return null
    endfunction

    function SetUnitBaseMissileArtById takes integer uid, string model, integer index returns nothing
        local integer pData = 0
    
        if uid > 0 then
            if index == 0 or index == 1 then
                set pData = GetUnitBaseUIDataByIdCaching( uid )

                if pData > 0 then
                    set pData = ReadRealMemory( pData + 0x44 )
        
                    if pData > 0 then
                        call WriteRealMemory( pData + index * 4, GetStringAddress( model ) )
                    endif
                endif
            endif
        endif
    endfunction

    function GetUnitBaseMissileSpeedById takes integer uid, integer index returns real
        local integer pData = 0

        if uid > 0 then
            if index == 0 or index == 1 then
                set pData = GetUnitBaseUIDataByIdCaching( uid )
    
                if pData > 0 then
                    set pData = ReadRealMemory( pData + 0x64 )
    
                    if pData > 0 then
                        return ReadRealFloat( pData + index * 4 )
                    endif
                endif
            endif
        endif

        return -1.
    endfunction

    function SetUnitBaseMissileSpeedById takes integer uid, integer index, real speed returns nothing
        local integer pData = 0

        if uid > 0 then
            if index == 0 or index == 1 then
                set pData = GetUnitBaseUIDataByIdCaching( uid )
    
                if pData > 0 then
                    set pData = ReadRealMemory( pData + 0x64 )
    
                    if pData > 0 then
                        call WriteRealMemory( pData + index * 4, SetRealIntoMemory( speed ) )
                    endif
                endif
            endif
        endif
    endfunction

    function GetUnitBaseMissileArcById takes integer uid, integer index returns real
        local integer pData = 0

        if uid > 0 then
            if index == 0 or index == 1 then
                set pData = GetUnitBaseUIDataByIdCaching( uid )
    
                if pData > 0 then
                    set pData = ReadRealMemory( pData + 0x70 )
    
                    if pData > 0 then
                        return ReadRealFloat( pData + index * 4 )
                    endif
                endif
            endif
        endif

        return -1.
    endfunction

    function SetUnitBaseMissileArcById takes integer uid, integer index, real arc returns nothing
        local integer pData = 0

        if uid > 0 then
            if index == 0 or index == 1 then
                set pData = GetUnitBaseUIDataByIdCaching( uid )
    
                if pData > 0 then
                    set pData = ReadRealMemory( pData + 0x70 )
    
                    if pData > 0 then
                        call WriteRealMemory( pData + index * 4, SetRealIntoMemory( arc ) )
                    endif
                endif
            endif
        endif
    endfunction
    
    function GetUnitBaseColorById takes integer uid returns integer
        local integer pData = 0
    
        if uid > 0 then
            set pData = GetUnitBaseUIDataByIdCaching( uid )
    
            if pData > 0 then
                return ReadRealMemory( pData + 0xAC )
            endif
        endif
    
        return 0
    endfunction

    function GetUnitBaseModelById takes integer uid returns string
        local integer pData = 0

        if uid > 0 then
            set pData = GetUnitBaseUIDataByIdCaching( uid )

            if pData > 0 then
                set pData = ReadRealMemory( pData + 0x34 )
    
                if pData > 0 then
                    return ToJString( pData )
                endif
            endif
        endif

        return ""
    endfunction

    function SetUnitBaseModelById takes integer uid, string model returns nothing
        local integer pData = 0
    
        if uid > 0 then
            set pData = GetUnitBaseUIDataByIdCaching( uid )
    
            if pData > 0 then
                call WriteRealMemory( pData + 0x34, GetStringAddress( model ) )
                //call WriteNullTerminatedString( model, pData + 0x34 )
            endif
        endif
    endfunction
    
    function GetUnitBaseIconPathById takes integer uid returns string
        return GetUnitBaseUIStringParam( uid, 1, 0x24C )
    endfunction

    function SetUnitBaseIconPathById takes integer uid, string iconpath returns nothing
        call SetUnitBaseUIStringParam( uid, 1, 0x24C, iconpath )
    endfunction
    
    function GetUnitBaseTipById takes integer uid returns string
        return GetUnitBaseUIStringParam( uid, 1, 0x260 )
    endfunction

    function SetUnitBaseTipById takes integer uid, string text returns nothing
        call SetUnitBaseUIStringParam( uid, 1, 0x260, text )
    endfunction

    function GetUnitBaseUbertipById takes integer uid returns string
        return GetUnitBaseUIStringParam( uid, 1, 0x26C )
    endfunction

    function SetUnitBaseUbertipById takes integer uid, string text returns nothing
        call SetUnitBaseUIStringParam( uid, 1, 0x26C, text )
    endfunction

    function GetUnitBaseHotkeyById takes integer uid returns integer
        if uid > 0 then
            if GetUnitBaseUIIntegerParam( uid, 0, 0x270 ) > 0 or GetUnitBaseUIIntegerParam( uid, 0, 0x274 ) > 0 then
                return GetUnitBaseUIIntegerParam( uid, 1, 0x278 )
            endif
        endif
    
        return 0
    endfunction

    function SetUnitBaseHotkeyById takes integer uid, integer key returns nothing
        if uid > 0 then
            call SetUnitBaseUIIntegerParam( uid, 0, 0x270,   1 )
            call SetUnitBaseUIIntegerParam( uid, 0, 0x274, key )
            call SetUnitBaseUIIntegerParam( uid, 1, 0x278, key )
        endif
    endfunction
    
    //===========================================

    // Unit Base Data API by Id
    function GetUnitGoldCostById takes integer uid returns integer
        local integer pData = GetUnitBaseDataById( uid )

        if pData > 0 then
            return ReadRealMemory( pData + 0x20 )
        endif

        return -1
    endfunction
    
    function SetUnitGoldCostById takes integer uid, integer value returns nothing
        local integer pData = GetUnitBaseDataById( uid )

        if pData > 0 and value >= 0 then
            call WriteRealMemory( pData + 0x20, value )
        endif
    endfunction

    function GetUnitLumberCostById takes integer uid returns integer
        local integer pData = GetUnitBaseDataById( uid )

        if pData > 0 then
            return ReadRealMemory( pData + 0x24 )
        endif

        return -1
    endfunction
    
    function SetUnitLumberCostById takes integer uid, integer value returns nothing
        local integer pData = GetUnitBaseDataById( uid )

        if pData > 0 and value >= 0 then
            call WriteRealMemory( pData + 0x24, value )
        endif
    endfunction
    
    function GetUnitFoodCostById takes integer uid returns integer
        local integer pData = GetUnitBaseDataById( uid )

        if pData > 0 then
            return ReadRealMemory( pData + 0x5C )
        endif

        return -1
    endfunction
    
    function SetUnitFoodCostById takes integer uid, integer value returns nothing
        local integer pData = GetUnitBaseDataById( uid )

        if pData > 0 and value >= 0 then
            call WriteRealMemory( pData + 0x5C, value )
        endif
    endfunction
    
    function GetHeroBasePrimaryAttributeById takes integer uid returns integer
        local integer pData = GetUnitBaseDataById( uid )

        if pData > 0 then
            return ReadRealMemory( pData + 0x17C )
        endif

        return -1
    endfunction

    function SetHeroBasePrimaryAttributeById takes integer uid, integer index returns nothing
        local integer pData = GetUnitBaseDataById( uid )

        if pData > 0 then
            if index >= 0 and index <= 2 then
                call WriteRealMemory( pData + 0x17C, index )
            endif
        endif
    endfunction

    function GetUnitCollisionSizeById takes integer uid returns real
        local integer pData = GetUnitBaseDataById( uid )

        if pData > 0 then
            return GetRealFromMemory( ReadRealMemory( pData + 0x19C ) )
        endif

        return -1.234 // to ensure we failed
    endfunction

    //===========================================

    function Init_MemHackUnitBaseAPI takes nothing returns nothing
        if PatchVersion != "" then
            if PatchVersion == "1.24e" then
                call SaveInteger( MemHackTable, StringHash("CUnitBase"), StringHash("DataNode"),      pGameDLL + 0xACB2B4 )
                call SaveInteger( MemHackTable, StringHash("CUnitBase"), StringHash("UINode"),        pGameDLL + 0xACC72C )
                call SaveInteger( MemHackTable, StringHash("CUnitBase"), StringHash("GetUnitUIData"), pGameDLL + 0x32D3C0 )
        elseif PatchVersion == "1.26a" then
                call SaveInteger( MemHackTable, StringHash("CUnitBase"), StringHash("DataNode"),      pGameDLL + 0xAB445C )
                call SaveInteger( MemHackTable, StringHash("CUnitBase"), StringHash("UINode"),        pGameDLL + 0xAB58D4 )
                call SaveInteger( MemHackTable, StringHash("CUnitBase"), StringHash("GetUnitUIData"), pGameDLL + 0x32C880 )
        elseif PatchVersion == "1.27a" then
                call SaveInteger( MemHackTable, StringHash("CUnitBase"), StringHash("DataNode"),      pGameDLL + 0xBEC470 )
                call SaveInteger( MemHackTable, StringHash("CUnitBase"), StringHash("UINode"),        pGameDLL + 0xBE6114 )
                call SaveInteger( MemHackTable, StringHash("CUnitBase"), StringHash("GetUnitUIData"), pGameDLL + 0x327020 )
        elseif PatchVersion == "1.27b" then
                call SaveInteger( MemHackTable, StringHash("CUnitBase"), StringHash("DataNode"),      pGameDLL + 0xD709D8 )
                call SaveInteger( MemHackTable, StringHash("CUnitBase"), StringHash("UINode"),        pGameDLL + 0xBE6114 )
                call SaveInteger( MemHackTable, StringHash("CUnitBase"), StringHash("GetUnitUIData"), pGameDLL + 0x344760 )
        elseif PatchVersion == "1.28f" then
                call SaveInteger( MemHackTable, StringHash("CUnitBase"), StringHash("DataNode"),      pGameDLL + 0xD38810 )
                call SaveInteger( MemHackTable, StringHash("CUnitBase"), StringHash("UINode"),        pGameDLL + 0xD324B4 )
                call SaveInteger( MemHackTable, StringHash("CUnitBase"), StringHash("GetUnitUIData"), pGameDLL + 0x378720 )
            endif
        endif
    endfunction
    //===========================================
endlibrary
//! endnocjass

//----------------------------------------------------------------------MemHackUnitBaseAPI END----------------------------------------------------------------------//





//----------------------------------------------------------------------MemHackUnitNormalAPI----------------------------------------------------------------------//

//! nocjass
library MemoryHackUnitNormalAPI
    function CUnitApplyUpgrades takes integer pUnit returns nothing
        if pUnit != 0 then
            call this_call_1( pCUnitApplyUpgradesAddr, pUnit )
        endif
    endfunction

    function CUnitUnapplyUpgrades takes integer pUnit returns nothing
        local integer addr = LoadInteger( MemHackTable, StringHash("CUnit"), StringHash("UnapplyUpgrades") )

        if addr != 0 and pUnit != 0 then
            call this_call_1( addr, pUnit )
        endif
    endfunction

    function CUnitUpdateInfoBar takes integer pUnit returns nothing
        if pUnit != 0 then
            call this_call_1( pCUnitUpdateInfoBarAddr, pUnit )
        endif
    endfunction

    function CUnitUpdateHeroBar takes integer pUnit, integer unk1 returns nothing
        if pUnit != 0 then
            call this_call_2( pCUnitUpdateHeroBarAddr, pUnit, unk1 )
        endif
    endfunction
    
    function CUnitRefreshPortraitOnSelect takes integer pUnit, integer unk1 returns nothing
        local integer addr = LoadInteger( MemHackTable, StringHash("CUnit"), StringHash("RefreshPortraitOnSelect") )

        if addr != 0 and pUnit != 0 then
            call this_call_2( addr, pUnit, unk1 )
        endif
    endfunction
    
    function CUnitRefreshInfoBarOnSelect takes integer pUnit returns integer
        local integer addr = LoadInteger( MemHackTable, StringHash("CUnit"), StringHash("RefreshInforBarOnSelect") )

        if addr != 0 and pUnit != 0 then
            return this_call_1( addr, pUnit )
        endif

        return 0
    endfunction

    function CUnitAddAbilityEx takes integer pUnit, integer aid, boolean checkduplicate returns nothing
        local boolean flag = false

        if pUnit != 0 and aid != 0 then
            if not ( checkduplicate and GetUnitAbilityReal( pUnit, aid, 0, 1, 1, 1 ) != 0 ) then
                call CUnitUnapplyUpgrades( pUnit )
                set flag = CUnitAddAbility( pUnit, aid )
                call CUnitApplyUpgrades( pUnit )
                
                if flag then
                    call CUnitUpdateInfoBar( pUnit )
                endif
            endif
        endif
    endfunction

    function CUnitRemoveAbilityEx takes integer pUnit, integer aid, boolean removeduplicates returns nothing
        local integer pAbil = 0
        local boolean flag = false

        if pUnit != 0 and aid != 0 then
            loop
                set pAbil = GetUnitAbilityReal( pUnit, aid, 0, 1, 1, 1 )

                if pAbil != 0 then
                    set flag = CUnitRemoveAbility( pUnit, pAbil )

                    if not removeduplicates then
                        set pAbil = 0
                    endif
                endif

                exitwhen pAbil == 0
            endloop

            if flag then
                call CUnitUpdateInfoBar( pUnit )
            endif
        endif
    endfunction

    function CUnitMorphToTypeIdEx takes integer pUnit, integer id, integer unk1, integer unk2, integer unk3, integer unk4, integer unk5, integer unk6, integer unk7, integer unk8, integer unk9 returns boolean
        // This function imitates spells like Metamorphosis etc, but without additional leaks.

        if pUnit != 0 then
            if ReadRealMemory( pUnit + 0x30 ) != id then
                return this_call_11( pCUnitMorphToTypeIdAddr, pUnit, id, unk1, unk2, unk3, unk4, unk5, unk6, unk7, unk8, unk9 ) != 0
            endif
        endif

        return false
    endfunction
    
    function CUnitMorphToTypeId takes integer pUnit, integer id returns boolean
        return CUnitMorphToTypeIdEx( pUnit, id, 1282, 0, 0, 2, 2, 1, 0, 0, 0 )
    endfunction
    //===========================================
    
    // jUnit API
    function GetUnitTypeIdReal takes unit u returns integer
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            return ReadRealMemory( pData + 0x30 )
        endif

        return 0
    endfunction

    function SetUnitTypeId takes unit u, integer i returns nothing
        // Note: This is simply change for portrait and some cosmetic stuff!
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            call WriteRealMemory( pData + 0x30, i )
        endif
    endfunction

    function MorphUnitToTypeId takes unit u, integer id returns boolean
        return CUnitMorphToTypeId( ConvertHandle( u ), id )
    endfunction
    
    function UpdateHeroBar takes unit u returns nothing
        call CUnitUpdateHeroBar( ConvertHandle( u ), 0 )
    endfunction
    
    function RefreshUnitPortraitOnSelect takes unit u returns nothing
        call CUnitRefreshPortraitOnSelect( ConvertHandle( u ), 1 )
    endfunction

    function RefreshUnitInfoBarOnSelect takes unit u returns nothing
        call CUnitRefreshInfoBarOnSelect( ConvertHandle( u ) )
    endfunction
    
    function MorphUnitToTypeIdEx takes unit u, integer id returns integer
        // This function imitates spells like Metamorphosis etc, but without additional leaks.
        local integer pUnit = ConvertHandle( u )

        if pUnit > 0 then
            if ReadRealMemory( pUnit + 0x30 ) != id then
                call CUnitMorphToTypeId( pUnit, id )
                call CUnitUpdateHeroBar( pUnit, 0 )
                call CUnitRefreshPortraitOnSelect( pUnit, 1 )
                return CUnitRefreshInfoBarOnSelect( pUnit )
            endif
        endif

        return 0
    endfunction

    function ApplyUnitUpgrades takes unit u returns nothing
        call CUnitApplyUpgrades( ConvertHandle( u ) )
    endfunction
    
    function UnapplyUnitUpgrades takes unit u returns nothing
        call CUnitUnapplyUpgrades( ConvertHandle( u ) )
    endfunction
    
    function UpdateUnitInfoBar takes unit u returns nothing
        call CUnitUpdateInfoBar( ConvertHandle( u ) )
    endfunction
    
    function AddUnitAbilityEx takes unit u, integer aid, boolean checkduplicate returns nothing
        call CUnitAddAbilityEx( ConvertHandle( u ), aid, checkduplicate )
    endfunction
    
    function RemoveUnitAbilityEx takes unit u, integer aid, boolean removeduplicates returns nothing
        call CUnitRemoveAbilityEx( ConvertHandle( u ), aid, removeduplicates )
    endfunction

    function GetUnitVertexColour takes unit u returns integer
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            return ReadRealMemory( pData + 0x2D4 )
        endif

        return 0
    endfunction

    function GetUnitVertexColourA takes unit u returns integer
        return GetByteFromInteger( GetUnitVertexColour( u ), 1 )
    endfunction

    function GetUnitVertexColourR takes unit u returns integer
        return GetByteFromInteger( GetUnitVertexColour( u ), 2 )
    endfunction

    function GetUnitVertexColourG takes unit u returns integer
        return GetByteFromInteger( GetUnitVertexColour( u ), 3 )
    endfunction

    function GetUnitVertexColourB takes unit u returns integer
        return GetByteFromInteger( GetUnitVertexColour( u ), 4 )
    endfunction

    //function SetUnitModel takes unit u, string model, boolean flag returns nothing
    //    call SetObjectModel( ConvertHandle( u ), model, flag )
    //endfunction

    function RedrawUnit takes unit u returns nothing
        local integer pData = ConvertHandle( u )

        if pData != 0 then
            call this_call_1( pCUnitRedrawAddr, pData )
        endif
    endfunction

    function IsAttackDisabled takes unit u returns boolean
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = ReadRealMemory( pData + 0x1E8 )

            if pData > 0 then
                return ReadRealMemory( pData + 0x40 ) > 0
            endif
        endif

        return false
    endfunction

    function UnitDisableAttack takes unit u returns nothing
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = ReadRealMemory( pData + 0x1E8 )

            if pData > 0 then
                call WriteRealMemory( pData + 0x40, 1 )
            endif
        endif
    endfunction
    
    function UnitEnableAttack takes unit u returns nothing
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = ReadRealMemory( pData + 0x1E8 )

            if pData > 0 then
                call WriteRealMemory( pData + 0x40, 0 )
            endif
        endif
    endfunction

    function GetUnitCritterFlag takes unit u returns integer
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            // 0 - normal | 1 - critter
            return ReadRealMemory( pData + 0x60 )
        endif

        return -1
    endfunction

    function SetUnitCritterFlag takes unit u, integer id returns nothing
        // Acts similar to 'Amec', meaning if unit has flag equal to 1
        // then he is considered a creep and will be ignored by autoattacks.
        // However, an attack may still be forced with 'A' key or rightclick
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            if id >= 0 and id <= 1 then
                call WriteRealMemory( pData + 0x60, id )
            endif
        endif
    endfunction

    function SetUnitPhased takes unit u returns nothing
        // Must be used with a slight delay AFTER cast, the minimum is one frame after successful cast!
        local integer data  = GetUnitBaseDataById( GetUnitTypeId( u ) ) + 0x1AC
        local integer p1    = ReadRealMemory( data )
        local integer p2    = ReadRealMemory( data + 0x4 )

        call WriteRealMemory( data, 0x8 )
        call WriteRealMemory( data + 0x4, 0x10 )
        call SetUnitPathing( u, true )
        call WriteRealMemory( data, p1 )
        call WriteRealMemory( data + 0x4, p2 )
    endfunction

    function UnitApplySilence takes unit u, boolean flag returns nothing
        local integer pUnit = ConvertHandle( u )
        if pUnit != 0 then
            call this_call_2( pCUnitSilenceAddr, pUnit, B2I( flag ) )
        endif
    endfunction

    function UnitDisableAbilities takes unit u, boolean disable, boolean use_show returns nothing
        // arg1 = use_show; arg2 = disable; arg3 ?; arg4 ?
        local integer pUnit = ConvertHandle( u )
        if pUnit != 0 then
            call this_call_5(pCUnitDisablAllAbilitysAddr, pUnit, B2I( use_show ), B2I( disable ), 0, 0 )
        endif
    endfunction

    function IsUnitStunned takes unit u returns boolean
        local integer pHandle = ConvertHandle( u )
        
        if pHandle > 0 then
            return ReadRealMemory( pHandle + 0x198 ) > 0
        endif

        return false
    endfunction

    function IsUnitMovementDisabled takes unit u returns boolean
        local integer pdata = GetHandleId( u )

        if pdata > 0 then
            set pdata = ConvertHandle( u )

            if pdata > 0 then
                set pdata = ReadRealMemory( pdata + 0x1EC )

                if pdata > 0 then
                    return ReadRealMemory( pdata + 0x7C ) > 0
                endif
            endif
        endif

        return false
    endfunction

    function SetUnitControl takes unit u, integer flagval, integer moveval, integer atackval, integer invval returns nothing
        local boolean isFlag = false
        local integer pUnit = ConvertHandle( u )
        local integer flags = 0
        local integer Amov  = 0
        local integer Aatk  = 0
        local integer AInv  = 0

        if pUnit > 0 then
            set flags  = ReadRealMemory( pUnit + 0x248 )
            set Aatk   = ReadRealMemory( pUnit + 0x1E8 )
            set Amov   = ReadRealMemory( pUnit + 0x1EC )
            set AInv   = ReadRealMemory( pUnit + 0x1F8 )
            set isFlag = not IsFlagBitSet( flags, absI( flagval ) ) // 512
            
            if flagval < 0 then
                set isFlag = not isFlag
            endif

            if isFlag then
                call WriteRealMemory( pUnit + 0x248, flags + flagval )
            endif
            
            if Amov > 0 then
                call WriteRealMemory( Amov + 0x40, ReadRealMemory( Amov + 0x40 ) + moveval )
            endif

            if Aatk > 0 then
                call WriteRealMemory( Aatk + 0x40, ReadRealMemory( Aatk + 0x40 ) + atackval )
            endif

            if AInv > 0 then
                call WriteRealMemory( AInv + 0x3C, ReadRealMemory( AInv + 0x3C ) + invval )
            endif
        endif
    endfunction

    function UnitDisableControl takes unit u returns nothing
        //Hides all command buttons and sets the Ward flag. Unit will keep its current order, and player can’t give new orders
        //Notice the the unit can’t be ordered with triggers as well. To issue an order you need to temporarily reenable control
        call SetUnitControl( u, 512, 1, 1, 1 )
    endfunction

    function UnitEnableControl takes unit u returns nothing
        //Removes the Ward flag and reenables Amov and Aatk
        call SetUnitControl( u, -512, -1, -1, -1 )
    endfunction

    function UnitRemoveMovementDisables takes unit u returns nothing
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = ReadRealMemory( pData + 0x1EC )

            if pData > 0 then
                call WriteRealMemory( ReadRealMemory( pData + 0x1EC ) + 0x7C, 0 )
            endif
        endif
    endfunction

    function SetUnitMovement takes integer pData, boolean flag returns nothing
        if pData > 0 then
            set pData = ReadRealMemory( pData + 0x1EC )

            if pData > 0 then
                call WriteRealMemory( pData + 0x7C, B2I( not flag ) ) //  ReadRealMemory( pdata ) + d
            endif
        endif
    endfunction

    function UnitEnableMovement takes unit u returns nothing
        if u == null then
            return
        endif

        call SetUnitMovement( ConvertHandle( u ), false )
    endfunction

    function UnitDisableMovement takes unit u returns nothing
        if u == null then
            return
        endif

        call SetUnitMovement( ConvertHandle( u ), true )
    endfunction

    function UnitDisableMovementEx takes unit u, boolean disable returns nothing
        local integer i = 2
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            if not disable then
                set i = 1
            endif

            call PauseUnit( u, true )
            set pData = ReadRealMemory( pData + 0x1EC )
            
            if pData > 0 then
                call SetAddressAbilityDisabled( pData, i ) //pointer to 'Amov' is located at offset 123 of unit object, Aatk is at offset 122, and AInv is offset 124
            endif

            call PauseUnit( u, false )
        endif
    endfunction

    function IsUnitInventoryDisabled takes unit u returns boolean
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = ReadRealMemory( pData + 0x1F8 )

            if pData > 0 then
                return I2B( ReadRealMemory( pData + 0x3C ) )
            endif
        endif
    
        return false
    endfunction
    
    function UnitEnableInventory takes unit u, boolean flag returns nothing
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = ReadRealMemory( pData + 0x1F8 )

            if pData > 0 then
                set pData = pData + 0x3C
                call WriteRealMemory( pData, B2I( not flag ) )
            endif
        endif
    endfunction

    function GetAddressLocustFlags takes integer pHash1, integer pHash2 returns integer
        local integer pObj = GetCObjectFromHash( pHash1, pHash2 )

        if pObj > 0 then
            return ReadRealMemory( pObj + 0x94 )
        endif

        return 0
    endfunction

    function SetLocustFlags takes unit u, integer i returns nothing //These flags can make unit immune to truesight
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = pData + 0x16C
            set pData = GetAddressLocustFlags( ReadRealMemory( pData ), ReadRealMemory( pData + 4 ) )

            if pData > 0 then
                call WriteRealMemory( pData + 0x34, i )
            endif
        endif
    endfunction

    function UnitEnableTruesightImmunity takes unit u returns nothing
        call SetLocustFlags( u, 0x08000000 ) //I don’t really know what other side effects may be caused by this, at least GroupEnum is not affected
    endfunction

    function UnitDisableTruesightImmunity takes unit u returns nothing
        call SetLocustFlags( u, 0 )
    endfunction

    function GetUnitVisibilityClass takes unit u returns integer
        local integer a = ConvertHandle( u )
        local integer res = 0

        if a > 0 then
            set res = ReadRealMemory( a + 0x130 )

            if res > 0 then
                set res = GetCAgentFromHash( res, ReadRealMemory( a + 0x134 ) )
            endif
        endif

        return res
    endfunction

    function SetUnitVisibleByPlayer takes unit u, player p, integer c returns nothing
        local integer a = GetUnitVisibilityClass( u )
        call BJDebugMsg(I2S(a))
        if a > 0 then
            call WriteRealMemory( a + 0x2C + 4 * GetPlayerId( p ), c )
            if c > 0 and not IsFlagBitSet( ReadRealMemory( a + 0x24 ), Player2Flag( p ) ) then
                call WriteRealMemory( a + 0x24, ReadRealMemory( a + 0x24 ) + Player2Flag( p ) )
            elseif c==0 and IsFlagBitSet( ReadRealMemory( a + 0x24 ), Player2Flag( p ) ) then
                call WriteRealMemory( a + 0x24, ReadRealMemory( a + 0x24 ) - Player2Flag( p ) )
            endif
        endif
    endfunction

    function IsUnitInvulnerable takes unit u returns boolean
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            return IsFlagBitSet( ReadRealMemory( pData + 0x20 ), 8 )
        endif

        return false
    endfunction

    function SetUnitFacingEx takes unit u, real facing, boolean isinstant returns nothing
        local integer pObject   = ConvertHandle( u )
        local integer vtable    = 0
        local integer pSmartPos = 0
        local integer pPosPos   = 0
        local integer arg       = LoadInteger( MemHackTable, StringHash("PointerArray"), 0 )

        if pObject != 0 and arg != 0 then
            set vtable = ReadRealMemory( pObject )

            if vtable != 0 then
                set pSmartPos = this_call_1( ReadRealMemory( vtable + 0xB8 ), pObject )

                if pSmartPos != 0 then
                    set pPosPos = GetCObjectFromHashGroup( pSmartPos + 0x08 )
                    
                    if pPosPos != 0 then
                        set vtable = ReadRealMemory( pPosPos )
                        
                        if vtable != 0 then
                            set facing = Deg2Rad( facing )
                            call WriteRealFloat( arg + 0x0, facing )
                            call this_call_2( ReadRealMemory( vtable + 0x4C ), pPosPos, arg + 0x0 )

                            if isinstant then
                                call this_call_1( ReadRealMemory( vtable + 0x58 ), pPosPos )
                            endif
                        endif
                    endif
                endif
            endif
        endif
    endfunction

    function SetUnitFacingInstantOld takes unit u, real angle returns nothing
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = GetCObjectFromHashGroup( pData + 0xA0 )

            if pData > 0 then
                set pData = ReadRealMemory( pData + 0x28 )

                if pData > 0 then
                    call SetUnitFacing( u, angle )
                    call WriteRealFloat( pData + 0xA4, Deg2Rad( angle ) )
                endif
            endif
        endif
    endfunction

    function GetUnitMoveType takes unit u returns integer
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = GetCObjectFromHashGroup( pData + 0x16C )

            if pData > 0 then
                set pData = ReadRealMemory( pData + 0xA8 )

                if pData > 0 then
                    return ReadRealMemory( pData + 0x9C )
                endif
            endif
        endif

        return 0
    endfunction

    function SetUnitMoveType takes unit u, integer from_other, integer to_other returns nothing
        local integer pData = ConvertHandle( u )
        local integer addr
        if pData > 0 then
            set addr = ReadRealMemory( ReadRealMemory( pData ) + 0x15C )
            if addr > 0 then
                call this_call_4(addr, pData, from_other, to_other)
            endif
        endif
    endfunction

    function GetHeroPrimaryAttribute takes unit u returns integer //1 = str, 2 = int, 3 = agi
        local integer a = ConvertHandle( u )

        if a > 0 then
            set a = ReadRealMemory( a + 0x1F0 )

            if a > 0 then
                return ReadRealMemory( a + 0xCC )
            endif
        endif

        return 0
    endfunction

    function SetHeroPrimaryAttribute takes unit u, integer i returns nothing
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            if IsUnitIdType( GetUnitTypeId( u ), UNIT_TYPE_HERO ) then
                set pData = ReadRealMemory( pData + 0x1F0 )

                if pData > 0 then
                    call WriteRealMemory( pData + 0xCC, i )
                endif
            endif
        endif
    endfunction

    function GetUnitAttackAbility takes unit u returns integer
        local integer pData = ConvertHandle( u )
        
        if pData > 0 then
            return ReadRealMemory( pData + 0x1E8 )
        endif
        
        return 0
    endfunction

    function SetUnitAttackAbility takes unit u, integer pAddr returns nothing
        local integer pData = ConvertHandle( u )
        
        if pData > 0 then
            call WriteRealMemory( pData + 0x1E8, pAddr )
        endif
    endfunction
    
    function GetUnitAttackOffsetValue takes unit u, integer pOff returns integer
        local integer pData = GetUnitAttackAbility( u )

        if pData > 0 then
            return ReadRealMemory( pData + pOff )
        endif

        return 0
    endfunction

    function GetUnitNextAttackTimestamp takes unit u returns real
        local integer pData = GetUnitAttackAbility( u )

        if pData > 0 then
            set pData = ReadRealMemory( pData + 0x1E4 )

            if pData > 0 then
                return ReadRealFloat( pData + 0x4 )
            endif
        endif

        return -1.
    endfunction

    function UnitResetAttackCooldown takes unit u returns boolean
        local integer pData = GetUnitAttackAbility( u )

        if pData > 0 then
            set pData = ReadRealMemory( pData + 0x1E4 )

            if pData > 0 then
                call WriteRealMemory( pData + 0x1E4, 0 )
                return true
            endif
        endif

        return false
    endfunction

    function UnitNullifyCurrentAttack takes unit u returns string
        local integer pData = GetUnitAttackAbility( u )

        if pData > 0 then
            set pData = ReadRealMemory( pData + 0x1F4 )

            if pData > 0 then
                call WriteRealMemory( pData + 0x1F4, 0 )
                return "nulled"
            else
                return "already empty"
            endif
        else
            return "cannot attack"
        endif

        return "no attack has been found"
    endfunction

    function AddUnitExtraAttack takes unit u returns boolean
        local integer pData = GetUnitAttackAbility( u )
        local real attackdelay

        if pData > 0 then
            set pData = ReadRealMemory( pData + 0x1E4 )

            if pData > 0 then
                set attackdelay = ReadRealFloat( pData + 0x8 )

                if attackdelay > 0 then
                    call WriteRealFloat( pData + 0x4, GetUnitNextAttackTimestamp( u ) - attackdelay )
                    return true
                endif
            endif
        endif

        return false
    endfunction

    function GetUnitAttackTypeByIndex takes unit u, integer index returns integer
        if index == 0 or index == 1 then
            return GetUnitAttackOffsetValue( u, 0xF4 + 4 * index )
        endif

        return -1
    endfunction

    function SetUnitAttackOffsetValue takes unit u, integer offset, integer val returns nothing
        local integer pData = GetUnitAttackAbility( u )

        if pData > 0 then
            call WriteRealMemory( pData + offset, val )
        endif
    endfunction

    function GetUnitBaseDamage takes unit u returns integer
        return GetUnitAttackOffsetValue( u, 0xA0 )
    endfunction

    function SetUnitBaseDamage takes unit u, integer i returns nothing
        call SetUnitAttackOffsetValue( u, 0xA0, i )
    endfunction

    function AddUnitBaseDamage takes unit u, integer bonus returns nothing
        call SetUnitBaseDamage( u, GetUnitBaseDamage( u ) + bonus )
    endfunction

    function GetUnitBonusDamage takes unit u returns integer
        return GetUnitAttackOffsetValue( u, 0xAC )
    endfunction

    function SetUnitBonusDamage takes unit u, integer i returns nothing
        //setting green bonus automatically adjusts base damage to fit
        call SetUnitAttackOffsetValue( u, 0xAC, i )
    endfunction

    function AddUnitBonusDamage takes unit u, integer i returns nothing
        call SetUnitBonusDamage( u, GetUnitBonusDamage( u ) + i )
    endfunction

    function GetUnitTotalDamage takes unit u returns integer
        return GetUnitBaseDamage( u ) + GetUnitBonusDamage( u )
    endfunction

    function GetUnitBaseAttributeDamage takes unit u returns integer
        return GetUnitAttackOffsetValue( u, 0xA4 )
    endfunction

    function SetUnitBaseAttributeDamage takes unit u, integer i returns nothing
        call SetUnitAttackOffsetValue( u, 0xA4, i )
    endfunction

    function GetUnitDamageDicesSideCount takes unit u returns integer
        return GetUnitAttackOffsetValue( u, 0x94 )
    endfunction

    function SetUnitDamageDicesSideCount takes unit u, integer i returns nothing
        call SetUnitAttackOffsetValue( u, 0x94, i )
    endfunction

    function GetUnitDamageDicesCount takes unit u returns integer
        return GetUnitAttackOffsetValue( u, 0x88 )
    endfunction
    
    function SetUnitDamageDicesCount takes unit u, integer i returns nothing
        call SetUnitAttackOffsetValue( u, 0x88, i )
    endfunction

    function GetUnitAttackDamage takes unit u returns real
        local integer dmg = GetUnitDamageDicesCount( u )
        local integer spread = GetRandomInt( dmg, dmg * GetUnitDamageDicesSideCount( u ) )

        return I2R( GetUnitBaseDamage( u ) + GetUnitBonusDamage( u ) + spread )
    endfunction
    
    function GetUnitArmourType takes unit u returns integer
        //armor types: 0 - Light; 1 - Medium; 2 - Heavy; 3 - Fortified; 4 - Normal; 5 - Hero; 6 - Divine; 7 - unarmored; | rest seems to have Light properties
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            return ReadRealMemory( pData + 0xE4 )
        endif

        return 0
    endfunction

    function SetUnitArmourType takes unit u, integer id returns nothing
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            call WriteRealMemory( pData + 0xE4, id )
        endif
    endfunction

    function GetUnitArmour takes unit u returns real
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            return ReadRealFloat( pData + 0xE0 )
        endif
        
        return 0.
    endfunction

    function GetUnitBaseMoveSpeed takes unit u returns real
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = ReadRealMemory( pData + 0x1EC ) //Amov
            
            if pData > 0 then
                return ReadRealFloat( pData + 0x70 )
            endif
        endif

        return 0.
    endfunction

    function GetUnitBonusMoveSpeed takes unit u returns real
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = ReadRealMemory( pData + 0x1EC ) //Amov
            
            if pData > 0 then
                return ReadRealFloat( pData + 0x78 )
            endif
        endif

        return -1000. // To ensure we failed to get Bonus MoveSpeed.
    endfunction

    function SetUnitBonusMoveSpeed takes unit u, real bonusms returns boolean
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = ReadRealMemory( pData + 0x1EC ) //Amov
            
            if pData > 0 then
                call WriteRealFloat( pData + 0x78, bonusms )
                call SetUnitMoveSpeed( u, ReadRealFloat( pData + 0x70 ) ) //required to update ms instantly
                return true
            endif
        endif

        return false
    endfunction

    function AddUnitBonusMovespeed takes unit u, real bonusms returns nothing
        call SetUnitBonusMoveSpeed( u, GetUnitBonusMoveSpeed( u ) + bonusms )
    endfunction
    
    function GetUnitMagicResistEx takes unit u, integer resistType returns real
        local integer pData = ConvertHandle( u )
        local integer pAbil = 0
        local integer pDefData = 0
        local integer baseid = 0
        local real r_temp = 0.
        local real runic_resist = 0.
        local real elune_resist = 0.
        local real total_resist = 0.

        if pData != 0 then
            set pAbil = GetCAgentFromHashGroup( pData + 0x1DC )

            if pAbil != 0 then
                loop
                    exitwhen pAbil == 0

                    if pAbil != 0 then
                        set pData = ReadRealMemory( pAbil + 0x54 )
                        
                        if pData != 0 then
                            set baseid = ReadRealMemory( pData + 0x30 )

                            if baseid == 'AIdd' or baseid == 'AIsr' then
                                set pDefData = GetAbilityBaseDefData( ReadRealMemory( pAbil + 0x34 ), ReadRealMemory( pAbil + 0x50 ) )
                                
                                if baseid == 'AIdd' then
                                    if elune_resist == 0. then
                                        set elune_resist = ReadRealFloat( pDefData + 0x30 )
                                    else
                                        set elune_resist = elune_resist * ReadRealFloat( pDefData + 0x30 )
                                    endif
                            elseif baseid == 'AIsr' then
                                    set r_temp = ReadRealFloat( pDefData + 0x24 )

                                    if r_temp > runic_resist then
                                        set runic_resist = r_temp
                                    endif
                                endif
                            endif
                        endif
                    endif

                    set pAbil = GetCAgentFromHashGroup( pAbil + 0x24 )
                endloop
            endif
        endif
        
        if elune_resist > 0. then
            if runic_resist > 0. then
                set total_resist = 1. - ( elune_resist ) * ( 1. - runic_resist )
            else
                set total_resist = 1. - elune_resist
            endif
        else
            if runic_resist > 0 then
                set total_resist = runic_resist
            endif
        endif

        if resistType == 1 then
            return runic_resist
    elseif resistType == 2 then
            return 1. - elune_resist
        endif

        return total_resist
    endfunction
    
    function GetUnitMagicResist takes unit u returns real
        return GetUnitMagicResistEx( u, 0 )
    endfunction
    //===========================================

    globals
        integer pCUnitVTableAddr
        integer pCUnitRedrawAddr 
        integer pCUnitSilenceAddr
        integer pCUnitDisablAllAbilitysAddr
        integer pCUnitUpdateInfoBarAddr
        integer pCUnitMorphToTypeIdAddr

        integer pCUnitUpdateHeroBarAddr  
        integer pCUnitApplyUpgradesAddr  
        integer pCUnitUnapplyUpgradesAddr
        integer pCUnitRefreshPortraitOnSelectAddr
        integer pCUnitRefreshInforBarOnSelectAddr
    endglobals

    function Init_MemHackUnitNormalAPI takes nothing returns nothing
        set pCUnitVTableAddr                  = pGameDLL + 0xA4A704
        set pCUnitRedrawAddr                  = pGameDLL + 0x67FB00
        set pCUnitSilenceAddr                 = pGameDLL + 0x471C40
        set pCUnitDisablAllAbilitysAddr       = pGameDLL + 0x46F180
        set pCUnitUpdateInfoBarAddr           = pGameDLL + 0x3598C0
        set pCUnitMorphToTypeIdAddr           = pGameDLL + 0x653220
        set pCUnitUpdateHeroBarAddr           = pGameDLL + 0x67FA80
        set pCUnitApplyUpgradesAddr           = pGameDLL + 0x6AA8E0
        set pCUnitUnapplyUpgradesAddr         = pGameDLL + 0x6AD4E0
        set pCUnitRefreshPortraitOnSelectAddr = pGameDLL + 0x676610
        set pCUnitRefreshInforBarOnSelectAddr = pGameDLL + 0x676600
    endfunction
    
endlibrary
//! endnocjass

//----------------------------------------------------------------------MemHackUnitNormalAPI END----------------------------------------------------------------------//
