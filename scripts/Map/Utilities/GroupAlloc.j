
library GroupAlloc requires Table

    globals
        private constant key KEY
        private constant integer MAX = 240
        private group   array Group
        private integer array List
        private integer array Id
        private integer Count   = 0
        private integer Counter = 0
        private integer Index   = 0

        group   array GroupsList
        boolean array GroupsIsAllocated
        integer       FirstGroupHandleId
        integer       GroupsAllocationTop = 0
    endglobals

    private function RecycleIndex takes integer i returns nothing
        if i > 0 and i <= Counter then
            set List[i]   = Index // 将上一个索引记录在这次索引里以方便在下次分配回收的索引后将Index设置为上一项
            set Index     = i     // Index更新
            // Decrement unit count
            set Count = Count - 1
        endif
    endfunction

    function DeallocateGroup takes group g returns nothing
        local integer index = Table[KEY][GetHandleId(g)]
        if index == 0 then
            call DestroyGroup(g)
            return
        endif

        call GroupClear(g)
        call RecycleIndex(index)
    endfunction
    function AllocationGroup takes integer id returns group
        local integer t = Index

        // Allocate index
        if (Index != 0) then
            set Index = List[t] 
            // 本质上是 Index=List[Index] 意味着如果Index不是0 则直接使用Index
            // 将Index设置为自身的上一项
            // 意味着如果还有回收过的索引，就不再分配新索引而是直到回收过的索引全部被重新分配完毕
        else // Counter是已经给出的最大分配量(不会因为释放而降低)
            set Counter = Counter + 1
            set t = Counter
            if Counter > MAX then
                call ThrowWarning(true, "GroupAlloc", "AllocationGroup", null, 0, "Counter > MAX")
                return CreateGroup()
            endif
        endif

        set Id[t] = id
        set List[t] = -1      // 已使用
        set Count = Count + 1 // 已存在索引的计数

        return Group[t]
    endfunction

    function GroupAlloc_Init takes nothing returns nothing
        local integer i = 1
        loop
        exitwhen i > MAX
            set Group[i] = CreateGroup()
            set Table[KEY][GetHandleId(Group[i])] = i
            set i = i + 1
        endloop
    endfunction

endlibrary

