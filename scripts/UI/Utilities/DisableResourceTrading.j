
library DisableResourceTrading
    
    function DisableResourceTradingFrame takes nothing returns nothing
        local integer i = 0
        loop
            exitwhen i > 11
            call DzFrameShow(DzFrameFindByName("GoldBackdrop", i)  , false)
            call DzFrameShow(DzFrameFindByName("LumberBackdrop", i), false)
            set i = i + 1
        endloop
        call DzFrameShow(DzFrameFindByName("ResourceTradingTitle", 0), false)
        call DzFrameShow(DzFrameFindByName("GoldHeader"          , 0), false)
        call DzFrameShow(DzFrameFindByName("LumberHeader"        , 0), false)
    endfunction

endlibrary


