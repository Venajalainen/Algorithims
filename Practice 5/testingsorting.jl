include("combsort.jl")
include("linearsort.jl")
include("median.jl")
include("mergesort.jl")
include("owncode.jl")
include("quicksort.jl")
include("shellsort.jl")

sorts = [_InsertionSort, _ShellSort, bubbleSort, _CombSort,_MergeSort,_QuickSort]

arr = randn(100000)
for sort in sorts
    _arr = @time _sort(arr,sort)
    println(issorted(_arr))
end