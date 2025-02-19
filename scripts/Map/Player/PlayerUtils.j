
library PlayerUtils2
    
    function IsObserverPlayerEx takes player p returns boolean
        return GameHasObservers and(ObserverPlayer1 == p or ObserverPlayer2 == p)
    endfunction
    
endlibrary
