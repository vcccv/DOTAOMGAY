library NeutralSpawnboxes requires Base, PlayerSettingsLib
    
    globals
        private lightning array Lightnings
        private integer Count = 0
    endglobals
    function CreateNeutralSpawnbox takes rect r, boolean high returns nothing
        local integer h = 896
        if high then
            set h = 1024
        endif
        set Count = Count + 1
        set Lightnings[Count * 4 + 0] = AddLightningEx("BRDR", false, GetRectMinX(r), GetRectMinY(r), h, GetRectMaxX(r), GetRectMinY(r), h)
        set Lightnings[Count * 4 + 1] = AddLightningEx("BRDR", false, GetRectMinX(r), GetRectMaxY(r), h, GetRectMaxX(r), GetRectMaxY(r), h)
        set Lightnings[Count * 4 + 2] = AddLightningEx("BRDR", false, GetRectMinX(r), GetRectMinY(r), h, GetRectMinX(r), GetRectMaxY(r), h)
        set Lightnings[Count * 4 + 3] = AddLightningEx("BRDR", false, GetRectMaxX(r), GetRectMinY(r), h, GetRectMaxX(r), GetRectMaxY(r), h)
        
        call SetLightningColor(Lightnings[Count * 4 + 0], 0.211, 0.87, 0, 0.0)
        call SetLightningColor(Lightnings[Count * 4 + 1], 0.211, 0.87, 0, 0.0)
        call SetLightningColor(Lightnings[Count * 4 + 2], 0.211, 0.87, 0, 0.0)
        call SetLightningColor(Lightnings[Count * 4 + 3], 0.211, 0.87, 0, 0.0)
    endfunction

    globals
        private boolean prevAlt  = false
        private boolean prevShow = false
    endglobals

    function NeutralSpawnboxesUpdate takes nothing returns nothing
        local integer i
        local boolean showSetting = PlayerSettings(User.LocalId).IsHoldingALTShowsNeutralSpawnboxes()
        local boolean currentAlt  = MHMsg_IsKeyDown(OSKEY_ALT)
        local real    alpha       
        
        if showSetting != prevShow or (showSetting and currentAlt != prevAlt) then

            if showSetting and currentAlt then
                set alpha = 0.7
            else
                set alpha = 0.0
            endif

            set i = 1
            loop
                exitwhen i > Count
                call SetLightningColor(Lightnings[i * 4 + 0], 0.211, 0.87, 0, alpha)
                call SetLightningColor(Lightnings[i * 4 + 1], 0.211, 0.87, 0, alpha)
                call SetLightningColor(Lightnings[i * 4 + 2], 0.211, 0.87, 0, alpha)
                call SetLightningColor(Lightnings[i * 4 + 3], 0.211, 0.87, 0, alpha)
                set i = i + 1
            endloop
        endif
    endfunction
    

endlibrary

