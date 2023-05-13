@inline function _merge!(arr, arr1, arr2)
    i1 :: Int = 1
    i2 :: Int = 1

    while i1+i2-1<=length(arr)
@inbounds   if i2>length(arr2) || i1<=length(arr1) && arr1[i1]<=arr2[i2]
@inbounds       arr[i1+i2-1] = arr1[i1]
                i1+=1
                continue
        end
@inbounds        if i1>length(arr1) || i2<=length(arr2) && arr1[i1]>=arr2[i2]
@inbounds            arr[i1+i2-1] = arr2[i2]
                    i2+=1
                    continue
        end
    end
    return arr
end
function _MergeSort(arr :: AbstractArray{T}) where T
    _arr = similar(arr)
    step :: Int = 1
    while step<=length(arr)
        i :: Int = 1
        while true
            border = min(i+2*step-1,length(arr))
            if i+step>border break end
  @inbounds @views _merge!(_arr[i:border],arr[i:i+step-1], arr[i+step:border])
  @inbounds arr[i:border] .= @view(_arr[i:border])
            if border == length(arr) break end
            i = i+2step
        end
        step*=2
    end
    return arr
end