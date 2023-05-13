include("owncode.jl")

@inline function _ShellSort(arr :: AbstractArray{T}) where T
    step = length(arr)
    while step>=1
        for i in 2:length(arr)
            j :: Int = i
            @inbounds while j-step>0 && arr[j-step]>arr[j]
                @inbounds arr[j-step], arr[j] = arr[j], arr[j-step]
                j-=step
            end
        end
        step÷=2
    end
    return arr
end