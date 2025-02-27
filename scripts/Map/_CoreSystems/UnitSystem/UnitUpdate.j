
library UnitUpdate requires UnitLimitation, UnitStateBonus, UnitWeapon
    
    // 通常在变身后更新
    function UnitUpdateData takes unit whichUnit returns nothing
        // 更新高度
        call SetUnitFlyHeight(whichUnit, GetUnitDefaultFlyHeight(whichUnit), 0)
        // 更新缩放
        call SetUnitCurrentScaleEx(whichUnit, GetUnitCurrentScale(whichUnit))
        // 更新移速
        call UnitUpdateNoLimitMoveSpeed(whichUnit)
        // 更新状态
        call UpdateUnitLimitation(whichUnit)
        // 更新单位属性奖励
        call UnitUpdateStateBonus(whichUnit)
        // 更新颜色
        call ResetUnitVertexColor(whichUnit)
    endfunction

endlibrary
