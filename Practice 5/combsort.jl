function _CombSort(arr :: AbstractArray{T}) where T
    step :: Int = length(arr)-1
    swaps = true
    while step>0
        swaps = true
        for i in 1:length(arr)-1
            @inbounds if arr[i+1]<arr[i]
                @inbounds arr[i], arr[i+1] = arr[i+1], arr[i]
                swaps = false
            end
        end
        swaps && (step=floor(Int,step/1.247))
    end
    return arr
end