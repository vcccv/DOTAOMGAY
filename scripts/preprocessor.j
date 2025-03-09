#define YDNL <?='\n'?>

#define C2I(c) MHTool_CodeToInt(c)
#define I2C(i) MHTool_IntToCode(i)

// group

#define GroupPickRandomUnit(whichGroup) MHGroup_GetRandomUnit(whichGroup)

#define init_group_variable() <?l_init_group_variable()?>
#define start_groupEnum(x, y, area) <?l_start_groupEnum(#x, #y, #area)?>
#define end_group_enum() <?l_end_group_enum()?>

<?
function call_jass_wrap(s)
    ?>
        <?=s?>
    <?
end

function call_jass(s)
    ?>
        <?=s?><?
end
?>

<?
group_count = 0524

function l_init_group_variable()
    call_jass([[
    local group g
    local unit  first
    ]])
end
function l_start_groupEnum(x, y, area)
    group_count = group_count + 1
    call_jass(string.format([[
    set g = AllocationGroup(%s) 
    call GroupEnumUnitsInRange(g, %s, %s, %s + MAX_UNIT_COLLISION, null)

    loop
		set first = FirstOfGroup(g)
		exitwhen first == null
		call GroupRemoveUnit(g, first)
    ]], group_count, x, y, area))
end

function l_end_group_enum()
    call_jass([[
    endloop
    call DeallocateGroup(g)
    ]])
end
?>
