function _CombSort(arr :: AbstractArray{T}) where T
    step :: Int= length(arr)
    while step >= 1
        i :: Int = 1
        while i+step<=length(arr)
            if arr[i]>arr[i+step]
                arr[i], arr[i+step] = arr[i+step], arr[i]
            end
            i+=1
        end
        step = floor(Int,step/1.2)
    end
    return arr
end