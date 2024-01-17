//----------------------------------------------------------------------MemHackAbilityAddressAPI----------------------------------------------------------------------//


//! nocjass
library MemoryHackAbilityAddressAPI
    // CAbility API
    function GetAbilityBaseDataByAddress takes integer pAbil returns integer
        if pAbil > 0 then
            return ReadRealMemory( pAbil + 0x54 )
        endif

        return 0
    endfunction

    function GetAddressAbilityTypeId takes integer pAbil returns integer
        if pAbil != 0 then
            return ReadRealMemory( pAbil + 0x34 )
        endif

        return 0
    endfunction
    
    function GetAddressAbilityBaseTypeId takes integer pAbil returns integer
        local integer base = 0

        if pAbil > 0 then
            set base = GetAbilityBaseDataByAddress( pAbil )

            if base > 0 then
                return ReadRealMemory( base + 0x34 )
            endif
        endif

        return 0
    endfunction
    
    function GetAddressAbilityBaseId takes integer pAbil returns integer
        local integer base = 0

        if pAbil > 0 then
            set base = GetAbilityBaseDataByAddress( pAbil )

            if base > 0 and ReadRealMemory( pAbil + 0x6C ) > 0 then
                return ReadRealMemory( base + 0x30 )
            endif
        endif

        return 0
    endfunction

    function GetAddressAbilityOrderId takes integer pAbil returns integer
        local integer pOffset2 = 0
        local integer base     = 0

        if pAbil > 0 then
            set base = GetAbilityBaseDataByAddress( pAbil )

            if base > 0 then
                set base = ReadRealMemory( base + 0x30 )

                if base > 0 then
                    if base == 'ANcl' then
                        return ReadRealMemory( pAbil + 0x124 )
                    else
                        return c_call_1( ReadRealMemory( ReadRealMemory( pAbil ) + 0x308 ), 0 )
                    endif
                endif
            endif
        endif

        return 0
    endfunction

    function IsAddressAbilityOnCooldown takes integer pAbil returns boolean
        if pAbil > 0 then
            return IsFlagBitSet( ReadRealMemory( pAbil + 0x20 ), 512 )
        endif

        return false
    endfunction

    function IsAddressAbilityUsable takes integer pAbil returns boolean // Always false for ANcl
        if pAbil > 0 then
            return this_call_1( ReadRealMemory( ReadRealMemory( pAbil ) + 0x1D8 ), pAbil ) == 1 or ( ReadRealMemory( pAbil + 0x6C ) != 0 and GetAddressAbilityBaseId( pAbil ) == 'ANcl' ) 
        endif

        return false
    endfunction

    function GetAddressAbilityCastTime takes integer pAbil returns real
        if pAbil > 0 then
            set pAbil = ReadRealMemory( pAbil + 0x84 )

            if pAbil > 0 then
                return GetRealFromMemory( ReadRealMemory( pAbil ) )
            endif
        endif

        return 0.
    endfunction

    function SetAddressAbilityCastTime takes integer pAbil, real r returns nothing
        if pAbil > 0 then
            set pAbil = ReadRealMemory( pAbil + 0x84 )

            if pAbil > 0 then
                call WriteRealMemory( pAbil, SetRealIntoMemory( r ) )
            endif
        endif
    endfunction
    
    function GetAddressAbilityCastpoint takes integer pAbil returns real
        if pAbil > 0 then
            return GetRealFromMemory( ReadRealMemory( pAbil + 0x8C ) )
        endif

        return 0.
    endfunction

    function SetAddressAbilityCastpoint takes integer pAbil, real dur returns nothing
        if pAbil > 0 then
            call WriteRealMemory( pAbil + 0x8C, SetRealIntoMemory( dur ) )
        endif
    endfunction

    function GetAddressAbilityBackswing takes integer pAbil returns real
        if pAbil > 0 then
            return GetRealFromMemory( ReadRealMemory( pAbil + 0x94 ) )
        endif

        return 0.
    endfunction

    function SetAddressAbilityBackswing takes integer pAbil, real dur returns nothing
        if pAbil > 0 then
            call WriteRealMemory( pAbil + 0x94, SetRealIntoMemory( dur ) )
        endif
    endfunction

    function GetAddressAbilityDefaultCooldown takes integer pAbil returns real
        if pAbil > 0 then
            return GetRealFromMemory( ReadRealMemory( pAbil + 0xB4 ) )
        endif

        return 0.
    endfunction

    function SetAddressAbilityDefaultCooldown takes integer pAbil, real dur returns nothing
        if pAbil > 0 then
            call WriteRealMemory( pAbil + 0xB4, SetRealIntoMemory( dur ) )
        endif
    endfunction
    
    function GetAddressAbilityManaCost takes integer pAbil, integer level returns integer
        if pAbil > 0 then
            set pAbil = GetAbilityBaseDataByAddress( pAbil )

            if pAbil > 0 then
                return ReadRealMemory( pAbil + level * 0x68 )
            endif
        endif

        return 0
    endfunction
    
    function SetAddressAbilityManaCost takes integer pAbil, integer level, integer mc returns nothing
        if pAbil > 0 then
            set pAbil = GetAbilityBaseDataByAddress( pAbil )

            if pAbil > 0 then
                call WriteRealMemory( pAbil + level * 0x68, mc )
            endif
        endif
    endfunction

    function GetAddressAbilityCooldownStamp takes integer pAbil returns real
        if pAbil > 0 then
            set pAbil = ReadRealMemory( pAbil + 0xDC )
            
            if pAbil > 0 then
                return GetRealFromMemory( ReadRealMemory( pAbil + 0x4 ) )
            endif
        endif

        return 0.
    endfunction
    
    function GetAddressAbilityCurrentCooldown takes integer pAbil returns real
        local real cd = 0.

        if pAbil > 0 then
            set pAbil = ReadRealMemory( pAbil + 0xDC )

            if pAbil > 0 then
                set cd    = GetRealFromMemory( ReadRealMemory( pAbil + 0x4 ) )
                set pAbil = ReadRealMemory( pAbil + 0xC )

                if pAbil > 0 then
                    set pAbil = ReadRealMemory( pAbil + 0x40 )
                    
                    if pAbil > 0 then
                        return cd - GetRealFromMemory( pAbil )
                    endif
                endif
            endif
        endif

        return .0
    endfunction
    
    function SetAddressAbilityCooldown takes integer pAbil,real seconds,string mode returns nothing         // Fixed By Asphodelus
        local real cd= 0.
        if pAbil != 0 then
            set pAbil=ReadRealMemory(pAbil + 0xDC)
 
            if pAbil > 0 then
                set cd = ReadRealFloat(pAbil + 0x4)
                if mode == "+" then
                    set seconds=cd + seconds
            elseif mode == "-" then
                    set seconds=cd - seconds
                endif
                call WriteRealFloat(pAbil + 0x4 , seconds)
            endif
        endif
    endfunction
    
    function StartAddressAbilityCooldown takes integer pAbil, real cd returns boolean
        local integer arg  = LoadInteger( MemHackTable, StringHash("PointerArray"), 0 )

        if pAbil != 0 and arg != 0 then
            call WriteRealFloat( arg + 0x0, cd )
            call this_call_2( pCAbilityStartCooldown, pAbil, arg + 0x0 )
            return IsAddressAbilityOnCooldown( pAbil )
        endif

        return false
    endfunction

    function SetAddressAbilityDisabled takes integer pAbil, integer count returns nothing
        if pAbil > 0 then
            call WriteRealMemory( pAbil + 0x3C, count )
        endif
    endfunction

    function GetAddressAbilityDisabled takes integer pAbil returns integer
        return ReadRealMemory( pAbil + 0x3C )
    endfunction

    function SetAddressAbilityHidden takes integer pAbil, integer count returns nothing
        if pAbil > 0 then
            call WriteRealMemory( pAbil + 0x40, count )
        endif
    endfunction

    function AddAddressAbilityHidden takes integer pAbil, integer d returns nothing
        call WriteRealMemory( pAbil + 0x40, ReadRealMemory( pAbil + 0x40 ) + d )
    endfunction

    function GetAddressAbilityDisabledEx takes integer pAbil returns integer
        if pAbil > 0 then
            return ReadRealMemory( pAbil + 0x44 ) 
        endif
        
        return 0
    endfunction

    function SetAddressAbilityDisabledEx takes integer pAbil, integer count returns nothing
        if pAbil > 0 then
            call WriteRealMemory( pAbil + 0x44, count )
        endif
    endfunction

    function ShowAddressAbility takes integer pAbil, boolean flag returns nothing
        if pAbil > 0 then
            if ReadRealMemory( pAbil ) > 0 then
                call WriteRealMemory( pAbil + 0x40, B2I( not flag ) )
            endif
        endif
    endfunction

    function SilenceAddressAbility takes integer pAbil returns nothing
        if pAbil != 0 then
            call this_call_3( pCAbilityDisable, pAbil, 0, 1 )
        endif
    endfunction

    function UnsilenceAddressAbility takes integer pAbil returns nothing
        if pAbil != 0 then
            call this_call_3( pCAbilityEnable, pAbil, 0, 1 )
        endif
    endfunction
    //===========================================

    // Buff API
    function GetAddressBuffLevel takes integer pBuff returns integer
        if pBuff > 0 then
            return ReadRealMemory( pBuff + 0xB0 ) + 1
        endif

        return -1 // Ensure we failed
    endfunction
    //===========================================
    globals
        integer pCAbilityStartCooldown
        integer pCAbilityDisable
        integer pCAbilityEnable
    endglobals

    function Init_MemHackAbilityAddressAPI takes nothing returns nothing
        set pCAbilityStartCooldown = pGameDLL + 0x418D20
        set pCAbilityDisable       = pGameDLL + 0x3E9FA0
        set pCAbilityEnable        = pGameDLL + 0x3EE3C0
    endfunction
endlibrary
//! endnocjass

//----------------------------------------------------------------------MemHackAbilityAddressAPI END----------------------------------------------------------------------//





//----------------------------------------------------------------------MemHackAbilityBaseAPI----------------------------------------------------------------------//

//! nocjass
library MemoryHackAbilityBaseAPI
    // Base Ability Data/UI Data by Id API
    function GetAbilityBaseDataById takes integer aid returns integer

        if aid != 0 then
           return this_call_1( pCAbilityBaseGetDataNodeAddr, aid )
        endif

        return 0
    endfunction

    function GetAbilityBaseDataByIdCaching takes integer aid returns integer
        // DEF_ADR_ABILITY_DATA = 0
        local integer pAbil = 0

        if HaveSavedInteger( htObjectDataPointers, 0, aid ) then 
            return LoadInteger( htObjectDataPointers, 0, aid )
        endif

        set pAbil = GetAbilityBaseDataById( aid )
        if pAbil != 0 then
            call SaveInteger( htObjectDataPointers, 0, aid, pAbil )
        endif

        return pAbil
    endfunction

    function GetAbilityBaseUIById takes integer aid returns integer

        if aid != 0 then
            return this_call_1( pCAbilityBaseGetUINodeAddr, aid )
        endif

        return 0
    endfunction

    function GetAbilityBaseUIByIdCaching takes integer aid returns integer
        // DEF_ADR_ABILITY_UI = 1
        local integer pAbil = 0

        if HaveSavedInteger( htObjectDataPointers, 1, aid ) then
            return LoadInteger( htObjectDataPointers, 1, aid )
        endif

        set pAbil = GetAbilityBaseUIById( aid )
        if pAbil != 0 then
            call SaveInteger( htObjectDataPointers, 1, aid, pAbil )
        endif

        return pAbil
    endfunction

    function GetAbilityBaseMaxLevelById takes integer aid returns integer
        local integer pAbil

        if aid != 0 then
            set pAbil = GetAbilityBaseDataByIdCaching( aid )

            if pAbil != 0 then
                return ReadRealMemory( pAbil + 0x50 )
            endif
        endif

        return 0
    endfunction
    //===========================================

    // Base Ability Parameters API
    function SetAbilityBaseHotkeyParam takes integer aid, integer off, integer newVal returns nothing
        local integer pAbil = GetAbilityBaseUIByIdCaching( aid )

        if pAbil > 0 then
            call WriteRealMemory( ReadRealMemory( pAbil + off ), newVal )
        endif
    endfunction

    function GetAbilityBaseHotkeyParam takes integer aid, integer off returns integer
        local integer pData = GetAbilityBaseUIByIdCaching( aid )

        if pData > 0 then
            set pData = ReadRealMemory( pData + off )

            if pData > 0 then
                return ReadRealMemory( pData )
            endif
        endif

        return 0
    endfunction

    function SetAbilityBaseUIIntegerParam takes integer aid, integer off, integer newVal returns nothing
        local integer pData = GetAbilityBaseUIByIdCaching( aid )

        if pData > 0 then
            call WriteRealMemory( pData + off, newVal )
        endif
    endfunction

    function GetAbilityBaseUIIntegerParam takes integer aid, integer off returns integer
        local integer pData = GetAbilityBaseUIByIdCaching( aid )

        if pData > 0 then
            return ReadRealMemory( pData + off )
        endif

        return 0
    endfunction

    function SetAbilityBaseUIRealParam takes integer aid, integer off, real newVal returns nothing
        local integer pData = GetAbilityBaseUIByIdCaching( aid )

        if pData > 0 then
            call WriteRealMemory( pData + off, SetRealIntoMemory( newVal ) )
        endif
    endfunction

    function GetAbilityBaseUIRealParam takes integer aid, integer off returns real
        local integer pData = GetAbilityBaseUIByIdCaching( aid )

        if pData > 0 then
            return ReadRealFloat( pData + off )
        endif

        return 0.
    endfunction

    function SetAbilityBaseUIBoolParam takes integer aid, integer off, boolean flag returns nothing
        local integer pData = GetAbilityBaseUIByIdCaching( aid )

        if pData > 0 then
            call WriteRealMemory( pData + off, B2I( flag ) )
        endif
    endfunction

    function GetAbilityBaseUIBoolParam takes integer aid, integer off returns boolean
        local integer pData = GetAbilityBaseUIByIdCaching( aid )

        if pData > 0 then
            return ReadRealMemory( pData + off ) > 0
        endif

        return false
    endfunction

    function GetAbilityBaseUIPStringParam takes integer aid, integer off returns string
        local integer pData = GetAbilityBaseUIByIdCaching( aid )

        if pData > 0 then
            set pData = ReadRealMemory( pData + off )

            if pData > 0 then
                return ToJString( ReadRealMemory( pData ) )
            endif
        endif

        return null
    endfunction

    function SetAbilityBaseUIPStringParam takes integer aid, integer off, string newVal returns nothing
        local integer pData = GetAbilityBaseUIByIdCaching( aid )

        if pData > 0 then
            set pData = ReadRealMemory( pData + off )

            if pData > 0 then
                call WriteRealMemory( pData, GetStringAddress( newVal ) )
            endif
        endif
    endfunction
    
    function GetAbilityBaseUIStringParam takes integer aid, integer off returns string
        local integer pData = GetAbilityBaseUIByIdCaching( aid )
        
        if pData > 0 then
            set pData = ReadRealMemory( pData + off )

            if pData > 0 then
                return ToJString( pData )
            endif
        endif

        return null
    endfunction

    function SetAbilityBaseUIStringParam takes integer aid, integer off, string newVal returns nothing
        local integer pData = GetAbilityBaseUIByIdCaching( aid )

        if pData > 0 then
            call WriteRealMemory( pData + off, GetStringAddress( newVal ) )
        endif
    endfunction

    function GetAbilityBaseUIStringParam2 takes integer aid, integer off, integer level returns string
        local integer pData = GetAbilityBaseUIByIdCaching( aid )

        if pData != 0 then
            set pData = ReadRealMemory( pData + off )
            set level = level - 1

            if level >= 0 and level < GetAbilityBaseMaxLevelById( aid ) then
                if pData != 0 then
                    set pData = ReadRealMemory( pData + level * 0x4 )

                    if pData != 0 then
                        return ToJString( pData )
                    endif
                endif
            endif
        endif

        return null
    endfunction

    function SetAbilityBaseUIStringParam2 takes integer aid, integer off, string newVal, integer level returns nothing
        local integer pData = GetAbilityBaseUIByIdCaching( aid )

        if pData != 0 then
            set pData = ReadRealMemory( pData + off )
            set level = level - 1

            if level >= 0 and level < GetAbilityBaseMaxLevelById( aid ) then
                if pData != 0 then
                    call WriteRealMemory( pData + level * 0x4, GetStringAddress( newVal ) )
                endif
            endif
        endif
    endfunction
    //===========================================
    
    // Ability Base Data API by Id
    
    //  CAbilityDef
	//	uint32_t	 unk_0;			// 0x0 | void**
	//	uint32_t	 unk_4;			// 0x4
	//	float		 nDuration;		// 0x8 | heroDuration
	//	float		 hDuration;		// 0xC | normalDuration
	//	int32_t		 manaCost;		// 0x10
	//	float		 cooldown;		// 0x14
	//	float		 aoe;			// 0x18
	//	float		 range;			// 0x1C
	//	float		 dataA;			// 0x20
	//	float		 dataB;			// 0x24
	//	float		 dataC;			// 0x28 | backswing
	//	float		 dataD;			// 0x2C | width
	//	float		 dataE;			// 0x30
	//	float		 dataF;			// 0x34
	//	uint32_t	 unk_38;		// 0x38
	//	uint32_t	 unk_3C;		// 0x3C
	//	uint32_t	 unk_40;		// 0x40
	//	uint32_t	 summonedUnit;	// 0x44
	//	VariousText	 buffIds;		// 0x48 - 0x50
	//	uint32_t	 unk_50;		// 0x50
	//	VariousText	 effectIds;		// 0x58 - 0x60
	//	uint32_t	 effectId;		// 0x64 | if effect id is sungular
    //  sizeof = 0x68
    
    function GetAbilityBaseDefData takes integer aid, integer level returns integer
        local integer pAbil = GetAbilityBaseDataByIdCaching( aid )

        if level > 0 then
            set level = level - 1
        endif

        if pAbil != 0 and level >= 0 and level < GetAbilityBaseMaxLevelById( aid ) then
            set pAbil = ReadRealMemory( pAbil + 0x54 )

            if pAbil != 0 then
                return pAbil + level * 0x68
            endif
        endif

        return 0
    endfunction

    function GetAbilityBaseNormalDurationById takes integer aid, integer level returns real
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            return ReadRealFloat( pAbil + 0x8 )
        endif

        return .0
    endfunction

    function SetAbilityBaseNormalDurationById takes integer aid, integer level, real duration returns nothing
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            call WriteRealFloat( pAbil + 0x8, duration )
        endif
    endfunction

    function GetAbilityBaseHeroDurationById takes integer aid, integer level returns real
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            return ReadRealFloat( pAbil + 0xC )
        endif

        return .0
    endfunction

    function SetAbilityBaseHeroDurationById takes integer aid, integer level, real duration returns nothing
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            call WriteRealFloat( pAbil + 0xC, duration )
        endif
    endfunction

    function GetAbilityBaseManaCostById takes integer aid, integer level returns integer
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            return ReadRealMemory( pAbil + 0x10 )
        endif

        return 0
    endfunction

    function SetAbilityBaseManaCostById takes integer aid, integer level, integer cost returns nothing
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            call WriteRealMemory( pAbil + 0x10, cost )
        endif
    endfunction

    function GetAbilityBaseCooldownById takes integer aid, integer level returns real
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            return ReadRealFloat( pAbil + 0x14 )
        endif

        return .0
    endfunction

    function SetAbilityBaseCooldownById takes integer aid, integer level, real cool returns nothing
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            call WriteRealFloat( pAbil + 0x14, cool )
        endif
    endfunction

    function GetAbilityBaseAoEById takes integer aid, integer level returns real
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            return ReadRealFloat( pAbil + 0x18 )
        endif

        return .0
    endfunction

    function SetAbilityBaseAoEById takes integer aid, integer level, real aoe returns nothing
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            call WriteRealFloat( pAbil + 0x18, aoe )
        endif
    endfunction

    function GetAbilityBaseRangeById takes integer aid, integer level returns real
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            return ReadRealFloat( pAbil + 0x1C )
        endif

        return .0
    endfunction

    function SetAbilityBaseRangeById takes integer aid, integer level, real range returns nothing
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            call WriteRealFloat( pAbil + 0x1C, range )
        endif
    endfunction

    function GetAbilityBaseDataAById takes integer aid, integer level returns real
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            return ReadRealFloat( pAbil + 0x20 )
        endif

        return .0
    endfunction

    function SetAbilityBaseDataAById takes integer aid, integer level, real dataA returns nothing
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            call WriteRealFloat( pAbil + 0x20, dataA )
        endif
    endfunction

    function GetAbilityBaseDataBById takes integer aid, integer level returns real
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            return ReadRealFloat( pAbil + 0x24 )
        endif

        return .0
    endfunction

    function SetAbilityBaseDataBById takes integer aid, integer level, real dataB returns nothing
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            call WriteRealFloat( pAbil + 0x24, dataB )
        endif
    endfunction

    function GetAbilityBaseDataCById takes integer aid, integer level returns real
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            return ReadRealFloat( pAbil + 0x28 )
        endif

        return .0
    endfunction

    function SetAbilityBaseDataCById takes integer aid, integer level, real dataC returns nothing
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            call WriteRealFloat( pAbil + 0x28, dataC )
        endif
    endfunction

    function GetAbilityBaseDataDById takes integer aid, integer level returns real
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            return ReadRealFloat( pAbil + 0x2C )
        endif

        return .0
    endfunction

    function SetAbilityBaseDataDById takes integer aid, integer level, real dataD returns nothing
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            call WriteRealFloat( pAbil + 0x2C, dataD )
        endif
    endfunction

    function GetAbilityBaseDataEById takes integer aid, integer level returns real
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            return ReadRealFloat( pAbil + 0x30 )
        endif

        return .0
    endfunction

    function SetAbilityBaseDataEById takes integer aid, integer level, real dataE returns nothing
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            call WriteRealFloat( pAbil + 0x30, dataE )
        endif
    endfunction

    function GetAbilityBaseDataFById takes integer aid, integer level returns real
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            return ReadRealFloat( pAbil + 0x34 )
        endif

        return .0
    endfunction

    function SetAbilityBaseDataFById takes integer aid, integer level, real dataF returns nothing
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            call WriteRealFloat( pAbil + 0x34, dataF )
        endif
    endfunction

    function GetAbilityBaseSummonedUnitById takes integer aid, integer level returns integer
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            return ReadRealMemory( pAbil + 0x44 )
        endif

        return 0
    endfunction

    function SetAbilityBaseSummonedUnitById takes integer aid, integer level, integer uid returns nothing
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            call WriteRealMemory( pAbil + 0x44, uid )
        endif
    endfunction

    function GetAbilityBaseEffectIdById takes integer aid, integer level returns integer
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            return ReadRealMemory( pAbil + 0x64 )
        endif

        return 0
    endfunction

    function SetAbilityBaseEffectIdById takes integer aid, integer level, integer eid returns nothing
        local integer pAbil = GetAbilityBaseDefData( aid, level )

        if pAbil != 0 then
            call WriteRealMemory( pAbil + 0x64, eid )
        endif
    endfunction
    //===========================================

    // Ability Base UI Data API by Id
    function GetAbilityBaseEffectSoundById takes integer aid returns string
        return GetAbilityBaseUIStringParam( aid, 0x30 )
    endfunction
    
    function SetAbilityBaseEffectSoundById takes integer aid, string s returns nothing
        call SetAbilityBaseUIStringParam( aid, 0x30, s )
    endfunction

    function GetAbilityBaseEffectSoundLoopedById takes integer aid returns string
        return GetAbilityBaseUIStringParam( aid, 0x34 )
    endfunction
    
    function SetAbilityBaseEffectSoundLoopedById takes integer aid, string s returns nothing
        call SetAbilityBaseUIStringParam( aid, 0x34, s )
    endfunction

    function GetAbilityBaseMissingIconById takes integer aid returns string
        return GetAbilityBaseUIStringParam( aid, 0x38 )
    endfunction
    
    function SetAbilityBaseMissingIconById takes integer aid, string s returns nothing
        call SetAbilityBaseUIStringParam( aid, 0x38, s )
    endfunction

    function GetAbilityBaseCurrentIconById takes integer aid returns string
        return GetAbilityBaseUIStringParam( aid, 0x3C )
    endfunction
    
    function SetAbilityBaseCurrentIconById takes integer aid, string s returns nothing
        call SetAbilityBaseUIStringParam( aid, 0x3C, s )
    endfunction

    function GetAbilityBaseCursorTextureById takes integer aid returns string
        return GetAbilityBaseUIStringParam( aid, 0x44 )
    endfunction
    
    function SetAbilityBaseCursorTextureById takes integer aid, string s returns nothing
        call SetAbilityBaseUIStringParam( aid, 0x44, s )
    endfunction

    function GetAbilityBaseGlobalMessageById takes integer aid returns string
        return GetAbilityBaseUIStringParam( aid, 0x48 )
    endfunction

    function SetAbilityBaseGlobalMessageById takes integer aid, string s returns nothing
        call SetAbilityBaseUIStringParam( aid, 0x48, s )
    endfunction
    
    function GetAbilityBaseGlobalSoundById takes integer aid returns string
        return GetAbilityBaseUIStringParam( aid, 0x4C )
    endfunction
    
    function SetAbilityBaseGlobalSoundById takes integer aid, string s returns nothing
        call SetAbilityBaseUIStringParam( aid, 0x4C, s )
    endfunction
    
    function GetAbilityBaseButtonXById takes integer aid returns integer
        return GetAbilityBaseUIIntegerParam( aid, 0x50 )
    endfunction
    
    function SetAbilityBaseButtonXById takes integer aid, integer newX returns nothing
        call SetAbilityBaseUIIntegerParam( aid, 0x50, newX )
    endfunction
    
    function GetAbilityBaseButtonYById takes integer aid returns integer
        return GetAbilityBaseUIIntegerParam( aid, 0x54 )
    endfunction
    
    function SetAbilityBaseButtonYById takes integer aid, integer newY returns nothing
        call SetAbilityBaseUIIntegerParam( aid, 0x54, newY )
    endfunction
    
    function GetAbilityBaseUnButtonXById takes integer aid returns integer
        return GetAbilityBaseUIIntegerParam( aid, 0x58 )
    endfunction
    
    function SetAbilityBaseUnButtonXById takes integer aid, integer newX returns nothing
        call SetAbilityBaseUIIntegerParam( aid, 0x58, newX )
    endfunction
    
    function GetAbilityBaseUnButtonYById takes integer aid returns integer
        return GetAbilityBaseUIIntegerParam( aid, 0x5C )
    endfunction
    
    function SetAbilityBaseUnButtonYById takes integer aid, integer newY returns nothing
        call SetAbilityBaseUIIntegerParam( aid, 0x5C, newY )
    endfunction
    
    function GetAbilityBaseResearchButtonXById takes integer aid returns integer
        return GetAbilityBaseUIIntegerParam( aid, 0x60 )
    endfunction
    
    function SetAbilityBaseResearchButtonXById takes integer aid, integer newX returns nothing
        call SetAbilityBaseUIIntegerParam( aid, 0x60, newX )
    endfunction
    
    function GetAbilityBaseResearchButtonYById takes integer aid returns integer
        return GetAbilityBaseUIIntegerParam( aid, 0x64 )
    endfunction
    
    function SetAbilityBaseResearchButtonYById takes integer aid, integer newY returns nothing
        call SetAbilityBaseUIIntegerParam( aid, 0x64, newY )
    endfunction
    
    function GetAbilityBaseMissileSpeedById takes integer aid returns real
        return GetAbilityBaseUIRealParam( aid, 0x68 )
    endfunction
    
    function SetAbilityBaseMissileSpeedById takes integer aid, real speed returns nothing
        call SetAbilityBaseUIRealParam( aid, 0x68, speed )
    endfunction
    
    function GetAbilityBaseMissileArcById takes integer aid returns real
        return GetAbilityBaseUIRealParam( aid, 0x6C )
    endfunction
    
    function SetAbilityBaseMissileArcById takes integer aid, real arc returns nothing
        call SetAbilityBaseUIRealParam( aid, 0x6C, arc )
    endfunction
    
    function IsAbilityMissileHomingById takes integer aid returns boolean
        return GetAbilityBaseUIBoolParam( aid, 0x70 )
    endfunction
    
    function SetAbilityBaseMissileHomingById takes integer aid, boolean homing returns nothing
        call SetAbilityBaseUIBoolParam( aid, 0x70, homing )
    endfunction
    
    function GetAbilityBaseSpellDetailsById takes integer aid returns integer
        return GetAbilityBaseUIIntegerParam( aid, 0x74 )
    endfunction
    
    function SetAbilityBaseSpellDetailsById takes integer aid, integer det returns nothing
        call SetAbilityBaseUIIntegerParam( aid, 0x74, det )
    endfunction
    
    function GetAbilityBaseHotkeyIdById takes integer aid returns integer
        return GetAbilityBaseHotkeyParam( aid, 0x84 )
    endfunction
    
    function SetAbilityBaseHotkeyIdById takes integer aid, integer newVal returns nothing
        call SetAbilityBaseHotkeyParam( aid, 0x84, newVal )
    endfunction
    
    function GetAbilityBaseUnHotkeyIdById takes integer aid returns integer
        return GetAbilityBaseHotkeyParam( aid, 0x90 )
    endfunction
    
    function SetAbilityBaseUnHotkeyIdById takes integer aid, integer newVal returns nothing
        call SetAbilityBaseHotkeyParam( aid, 0x90, newVal )
    endfunction
    
    function GetAbilityBaseResearchHotkeyIdById takes integer aid returns integer
        return GetAbilityBaseHotkeyParam( aid, 0x9C )
    endfunction
    
    function SetAbilityBaseResearchHotkeyIdById takes integer aid, integer newVal returns nothing
        call SetAbilityBaseHotkeyParam( aid, 0x9C, newVal )
    endfunction

    function GetAbilityBaseNameById takes integer aid returns string
        return GetAbilityBaseUIPStringParam( aid, 0xA8 )
    endfunction
    
    function SetAbilityBaseNameById takes integer aid, string s returns nothing
        call SetAbilityBaseUIPStringParam( aid, 0xA8, s )
    endfunction

    function GetAbilityBaseIconById takes integer aid returns string
        return GetAbilityBaseUIPStringParam( aid, 0xB4 )
    endfunction
    
    function SetAbilityBaseIconById takes integer aid, string s returns nothing
        call SetAbilityBaseUIPStringParam( aid, 0xB4, s )
    endfunction

    function GetAbilityBaseMissileArtById takes integer aid returns string
        return GetAbilityBaseUIPStringParam( aid, 0xF0 )
    endfunction
    
    function SetAbilityBaseMissileArtById takes integer aid, string s returns nothing
        call SetAbilityBaseUIPStringParam( aid, 0xF0, s )
    endfunction

    function GetAbilityBaseResearchTipById takes integer aid, integer lvl returns string
        return GetAbilityBaseUIStringParam2( aid, 0x12C, lvl )
    endfunction
    
    function SetAbilityBaseResearchTipById takes integer aid, string s, integer lvl returns nothing
        call SetAbilityBaseUIStringParam2( aid, 0x12C, s, lvl )
    endfunction

    function GetAbilityBaseTipById takes integer aid, integer lvl returns string
        return GetAbilityBaseUIStringParam2( aid, 0x138, lvl )
    endfunction
    
    function SetAbilityBaseTipById takes integer aid, integer lvl, string s returns nothing
        call SetAbilityBaseUIStringParam2( aid, 0x138, s, lvl )
    endfunction
    
    function GetAbilityBaseUnTipById takes integer aid, integer lvl returns string
        return GetAbilityBaseUIStringParam2( aid, 0x144, lvl )
    endfunction
    
    function SetAbilityBaseUnTipById takes integer aid, string s, integer lvl returns nothing
        call SetAbilityBaseUIStringParam2( aid, 0x144, s, lvl )
    endfunction
    
    function GetAbilityBaseResearchUberTipById takes integer aid, integer lvl returns string
        return GetAbilityBaseUIStringParam2( aid, 0x150, lvl )
    endfunction
    
    function SetAbilityBaseResearchUberTipById takes integer aid, string s, integer lvl returns nothing
        call SetAbilityBaseUIStringParam2( aid, 0x150, s, lvl )
    endfunction
    
    function GetAbilityBaseUbertipById takes integer aid, integer lvl returns string
        return GetAbilityBaseUIStringParam2( aid, 0x15C, lvl )
    endfunction
    
    function SetAbilityBaseUbertipById takes integer aid, integer lvl, string s returns nothing
        call SetAbilityBaseUIStringParam2( aid, 0x15C, s, lvl )
    endfunction

    function GetAbilityBaseResearchUnUberTipById takes integer aid, integer lvl returns string
        return GetAbilityBaseUIStringParam2( aid, 0x168, lvl )
    endfunction

    function SetAbilityBaseResearchUnUberTipById takes integer aid, string s, integer lvl returns nothing
        call SetAbilityBaseUIStringParam2( aid, 0x168, s, lvl )
    endfunction

    function SetAbilityBaseHotkeyCommonById takes integer aid, integer newVal returns nothing
        call SetAbilityBaseHotkeyIdById( aid, newVal )
        call SetAbilityBaseUnHotkeyIdById( aid, newVal )
        call SetAbilityBaseResearchHotkeyIdById( aid, newVal )
    endfunction

    //===========================================

    globals
        integer pCAbilityBaseGetDataNodeAddr
        integer pCAbilityBaseGetUINodeAddr
    endglobals
    
    function Init_MemHackAbilityBaseAPI takes nothing returns nothing
        set pCAbilityBaseGetDataNodeAddr = pGameDLL + 0x68EDF0
        set pCAbilityBaseGetUINodeAddr   = pGameDLL + 0x322C30
    endfunction
endlibrary
//! endnocjass

//----------------------------------------------------------------------MemHackAbilityBaseAPI END----------------------------------------------------------------------//





//----------------------------------------------------------------------MemHackAbilityNormalAPI END----------------------------------------------------------------------//

//! nocjass
library MemoryHackAbilityNormalAPI
    // jAbility API

    function Init_MemHackAbilityNormalAPI takes nothing returns nothing
        if PatchVersion != "" then
            if PatchVersion == "1.24e" then
        elseif PatchVersion == "1.26a" then
        elseif PatchVersion == "1.27a" then
        elseif PatchVersion == "1.27b" then
        elseif PatchVersion == "1.28f" then
            endif
        endif
    endfunction
endlibrary
//! endnocjass

//----------------------------------------------------------------------MemHackAbilityNormalAPI END----------------------------------------------------------------------//





//----------------------------------------------------------------------MemHackAbilityUnitAPI----------------------------------------------------------------------//

//! nocjass
library MemoryHackAbilityUnitAPI
    // CUnit Ability API
    function GetUnitAbilityReal takes integer pUnit, integer aid, integer unk1, integer unk2, integer unk3, integer unk4 returns integer

        if pUnit > 0 and aid > 0 then
            return this_call_6( pCAbilityUnitGetAbility, pUnit, aid, unk1, unk2, unk3, unk4 )
        endif

        return 0
    endfunction

    function CUnitAddAbility takes integer pUnit, integer aid returns boolean

        if pUnit != 0 and aid != 0 then
            return fast_call_5( pCAbilityUnitAddAbility, pUnit, aid, 0, 0, 0 ) > 0
        endif

        return false
    endfunction

    function CUnitRemoveAbility takes integer pUnit, integer pAbil returns boolean

        if pUnit != 0 and pAbil != 0 then
            call this_call_2( pCAbilityUnitRemoveAbility, pUnit, pAbil )
            return true
        endif

        return false
    endfunction

    function CUnitRemoveAbilityById takes integer pUnit, integer aid returns boolean
        local integer pAbil = 0

        if pUnit != 0 and aid != 0 then
            set pAbil = GetUnitAbilityReal( pUnit, aid, 0, 1, 1, 1 )

            if pAbil != 0 then
                return CUnitRemoveAbility( pUnit, pAbil )
            endif
        endif

        return false
    endfunction
    //===========================================
    
    // jUnit Ability API
    function GetUnitAbilityData takes unit u, integer aid, integer flag returns integer
        local integer pUnit

        if u != null and aid > 0 then
            set pUnit = ConvertHandle( u )

            if pUnit > 0 then
                return GetUnitAbilityReal( pUnit, aid, 0, flag, 1, 1 )
            endif
        endif

        return 0
    endfunction

    function GetUnitAbility takes unit u, integer aid returns integer
        if GetUnitAbilityLevel( u, aid ) > 0 then
            return GetUnitAbilityData( u, aid, 1 )
        endif

        return 0
    endfunction

    function GetUnitAbilityByIndex takes unit u, integer index returns ability
        local integer pData = ConvertHandle( u )
        local integer pAbil = 0
        local integer i = 0

        if pData != 0 then
            set pAbil = GetCAgentFromHashGroup( pData + 0x1DC )

            if pAbil != 0 then
                loop
                    exitwhen pAbil == 0 or i == index
                    set pAbil = GetCAgentFromHashGroup( pAbil + 0x24 )
                    set i = i + 1
                endloop

                if pAbil != 0 then
                    return ObjectToAbility( pAbil )
                endif
            endif
        endif

        return null
    endfunction

    function GetUnitJAbility takes unit u, integer aid returns ability
        return ObjectToAbility( GetUnitAbility( u, aid ) )
    endfunction

    function AddUnitAbility takes unit u, integer aid returns boolean
        return CUnitAddAbility( ConvertHandle( u ), aid )
    endfunction

    function RemoveUnitAbility takes unit u, integer aid, boolean removeduplicates returns nothing
        call CUnitRemoveAbility( ConvertHandle( u ), aid )
    endfunction

    function GetUnitAbilityBase takes unit u, integer aid returns integer
        return GetUnitAbilityData( u, aid, 0 )
    endfunction

    function GetUnitAbilityOrderId takes unit u, integer aid returns integer            // Fixed By Asphodelus
        local integer pAbil = GetUnitAbility( u, aid )
        return GetAddressAbilityOrderId(pAbil)
    endfunction

    function IsUnitAbilityOnCooldown takes unit u, integer aid returns boolean
        return IsAddressAbilityOnCooldown( GetUnitAbility( u, aid ) )
    endfunction

    function IsUnitAbilityUsable takes unit u, integer aid returns boolean
        return IsAddressAbilityUsable( GetUnitAbility( u, aid ) )
    endfunction

    function GetUnitAbilityCastpoint takes unit u, integer aid returns real
        return GetAddressAbilityCastpoint( GetUnitAbility( u, aid ) )
    endfunction

    function SetUnitAbilityCastpoint takes unit u, integer aid, real dur returns nothing
        call SetAddressAbilityCastpoint( GetUnitAbility( u, aid ), dur )
    endfunction

    function GetUnitAbilityBackswing takes unit u, integer aid returns real
        return GetAddressAbilityBackswing( GetUnitAbility( u, aid ) )
    endfunction

    function SetUnitAbilityBackswing takes unit u, integer aid, real dur returns nothing
        call SetAddressAbilityBackswing( GetUnitAbility( u, aid ), dur )
    endfunction

    function GetUnitAbilityManaCost takes unit u, integer aid, integer level returns integer
        return GetAddressAbilityManaCost( GetUnitAbility( u, aid ), level )
    endfunction

    function SetUnitAbilityManaCost takes unit u, integer aid, integer level, integer mc returns nothing
        call SetAddressAbilityManaCost( GetUnitAbility( u, aid ), level, mc )
    endfunction

    function GetUnitAbilityCooldownStamp takes unit u, integer aid returns real
        //This actually returns the timestamp, not the cooldown. To get the real cooldown you need to subtract this from the current game time.
        return GetAddressAbilityCooldownStamp( GetUnitAbility( u, aid ) )
    endfunction

    function GetUnitAbilityCurrentCooldown takes unit u, integer aid returns real
        //This value holds the base cooldown of the ability at the last time it was casted. It’s used to calculate the % of elapsed cooldown.
        //This is completely irrelevant for the gameplay, it’s used only to determine which frame of the cooldown model will be displayed.
        return GetAddressAbilityCurrentCooldown( GetUnitAbility( u, aid ) )
    endfunction

    function SetUnitAbilityCooldown takes unit u, integer aid, real seconds, string mode returns nothing
        call SetAddressAbilityCooldown( GetUnitAbility( u, aid ), seconds, mode )
    endfunction

    function AddUnitAbilityCooldown takes unit u, integer aid, real seconds returns nothing
        call SetUnitAbilityCooldown( u, aid, seconds, "+" )
    endfunction

    function ReduceUnitAbilityCooldown takes unit u, integer aid, real seconds returns nothing
        call SetUnitAbilityCooldown( u, aid, seconds, "-" )
    endfunction

    function ResetUnitAbilityCooldown takes unit u, integer aid returns nothing
        call SetUnitAbilityCooldown( u, aid, -1., "" )
    endfunction

    function StartUnitAbilityCooldown takes unit u, integer aid, real cd returns nothing
        call StartAddressAbilityCooldown( GetUnitAbility( u, aid ), cd )
    endfunction

    function GetUnitAbilityCastTime takes unit u, integer aid returns real
        return GetAddressAbilityCastTime( GetUnitAbility( u, aid ) )
    endfunction

    function SetUnitAbilityCastTime takes unit u, integer aid, real r returns nothing
        call SetAddressAbilityCastTime( GetUnitAbility( u, aid ), r )
    endfunction

    function SetUnitAbilityDisabled takes unit u, integer aid, integer count returns nothing
        // not safe unless used with PauseUnit. Button will be blacked, but current casts of that ability won’t be interrupted.
        call SetAddressAbilityDisabled( GetUnitAbility( u, aid ), count )
    endfunction

    function GetUnitAbilityDisabled takes unit u, integer aid returns integer
        return GetAddressAbilityDisabled( GetUnitAbility( u, aid ) )
    endfunction

    function SetUnitAbilityHidden takes unit u, integer aid, integer count returns nothing
        // This one is 100% safe. This hides the ability button, and order can’t be issued.
        call SetAddressAbilityHidden( GetUnitAbility( u, aid ), count ) // -1 = unhide | 1 = hide
    endfunction

    function AddUnitAbilityHidden takes unit u, integer aid, integer count returns nothing
        call AddAddressAbilityHidden( GetUnitAbility( u, aid ), count )
    endfunction

    function GetUnitAbilityDisabledEx takes unit u, integer aid returns integer
        // This one is used by Orb of Slow. Button is blacked, but cooldown is stil displayed.
        return GetAddressAbilityDisabledEx( GetUnitAbility( u, aid ) )
    endfunction

    function SetUnitAbilityDisabledEx takes unit u, integer aid, integer count returns nothing
        // This one is used by Orb of Slow. Button is blacked, but cooldown is stil displayed.
        call SetAddressAbilityDisabledEx( GetUnitAbility( u, aid ), count ) // -1 = unhide | 1 = hide
    endfunction

    function SilenceUnitAbility takes unit u, integer aid returns nothing
        call SilenceAddressAbility( GetUnitAbility( u, aid ) )
    endfunction

    function UnsilenceUnitAbility takes unit u, integer aid returns nothing
        call UnsilenceAddressAbility( GetUnitAbility( u, aid ) )
    endfunction

    function ShowUnitAbility takes unit u, integer aid, boolean flag returns nothing
        call ShowAddressAbility( GetUnitAbility( u, aid ), flag )
    endfunction
    //===========================================

    // Buff API
    function GetUnitBuffLevel takes unit u, integer bid returns integer         // Fixed By Asphodelus
        if GetUnitAbilityLevel(u, bid) > 0 then
            return GetAddressBuffLevel( GetUnitAbility( u, bid ) )
        endif
        return 0
    endfunction
    //===========================================
    globals
        integer pCAbilityUnitGetAbility
        integer pCAbilityUnitAddAbility
        integer pCAbilityUnitRemoveAbility
    endglobals
    
    function Init_MemHackAbilityUnitAPI takes nothing returns nothing
        set pCAbilityUnitGetAbility    = pGameDLL + 0x46F440
        set pCAbilityUnitAddAbility    = pGameDLL + 0x454EB0
        set pCAbilityUnitRemoveAbility = pGameDLL + 0x471160
    endfunction
endlibrary
//! endnocjass

//----------------------------------------------------------------------MemHackAbilityUnitAPI END----------------------------------------------------------------------//





//----------------------------------------------------------------------MemHackCastAbility----------------------------------------------------------------------//

//! nocjass
library MemoryHackCastAbility
    function CastAbilityBasic takes integer pAbil returns integer
        if pAbil != 0 then
            return this_call_1( pCAbilityCast, pAbil )
        endif

        return 0
    endfunction
    
    function CastAbilityPosition takes integer aid, unit source, real targX, real targY returns nothing
        // Fits for non-target spells, i.e. Was Stomp and such...
        local integer pData = ConvertHandle( source )

        if pData > 0 then
            set pData = GetUnitAbility( source, aid )

            if pData > 0 then
                call WriteRealMemory( pData + 0xF8, SetRealIntoMemory( targX ) )
                call WriteRealMemory( pData + 0x100, SetRealIntoMemory( targY ) )
                call WriteRealMemory( pData + 0x20, 0x9800 )
                set pData = CastAbilityBasic( pData )
            endif
        endif
    endfunction

    function CastAbilityTarget takes integer aid, unit source, widget target returns nothing
        // Due to memory issues requires std/this calls to use different memory allocation
        // else spells which deals damage immediately on cast will interference with damage-related functions
        // hence why we use separate memory addresses for each unique stdcall and such.
        local integer pData  = 0
        local integer unitHashA = 0
        local integer unitHashB = 0
        local integer flags  = 0

        if GetUnitAbilityLevel( source, aid ) > 0 and target != null then
            set pData = ConvertHandle( target )

            if pData > 0 then
                set unitHashA = ReadRealMemory( pData + 0x0C )
                set unitHashB = ReadRealMemory( pData + 0x10 )

                if unitHashA > 0 and unitHashB > 0 then
                    set pData = ConvertHandle( source )

                    if pData > 0 then
                        set pData = GetUnitAbility( source, aid )

                        if pData > 0 then
                            // Widget is saved via HashGroup, hence we grab our units HashA and HashB and save them to TargetHashGroup
                            call WriteRealMemory( pData + 0xE4, unitHashA )
                            call WriteRealMemory( pData + 0xE8, unitHashB )
                            set flags = ReadRealMemory( pData + 0x20 )

                            if not IsFlagBitSet( flags, 0x10000 ) then
                                // 0x19804 stands for "target", 0x1F020 stands for "target item", 0x9800 stands for point target
                                call WriteRealMemory( pData + 0x20, flags + 0x10000 )
                                set flags = flags + 0x10000
                                if not IsFlagBitSet( flags, 0x1 ) then
                                    call WriteRealMemory( pData + 0x20, flags + 0x1 )
                                endif
                            endif

                            set pData = CastAbilityBasic( pData ) // If value > 0 then cast has been successful.
                        endif
                    endif
                endif
            endif
        endif
    endfunction

    function CastAbilityTargetGround takes integer aid, unit source, integer lvl, real targX, real targY, boolean remove returns nothing
        call UnitAddAbility( source, aid )

        if lvl > 1 then
            call SetUnitAbilityLevel( source, aid, lvl )
        endif

        call CastAbilityPosition( aid, source, targX, targY )
        if remove then
            // Note: channeled abilities stop as soon as ability is removed!
            // This Applies to Chain Lightning and such.
            call UnitRemoveAbility( source, aid )
        endif
    endfunction

    function CastAbilityTargetWidget takes integer aid, unit source, widget target, integer lvl, boolean remove returns nothing
        call UnitAddAbility( source, aid )

        if lvl > 1 then
            call SetUnitAbilityLevel( source, aid, lvl )
        endif

        call CastAbilityTarget( aid, source, target )
        if remove then
            // Note: channeled abilities stop as soon as ability is removed!
            // This Applies to Chain Lightning and such.
            call UnitRemoveAbility( source, aid )
        endif
    endfunction

    function CastAbilityTargetSelf takes integer aid, unit source, integer lvl returns nothing
        call CastAbilityTargetWidget( aid, source, source, lvl, true )
    endfunction

    globals
        integer pCAbilityCast
    endglobals
    
    function Init_MemHackCastAbility takes nothing returns nothing
        set pCAbilityCast = pGameDLL + 0x3ECB70
    endfunction
endlibrary
//! endnocjass

//----------------------------------------------------------------------MemHackCastAbility END----------------------------------------------------------------------//
