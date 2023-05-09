include("owncode.jl")

function _ShellSort(arr :: AbstractArray{T}) where T
    step = length(arr)
    while step>=1
        _InsertionSort(@view arr[begin:step:end])
        step = floor(Int,step/1.2473309)
    end
    return arr
end