@inline function _partitition(arr)
    pivot = rand(arr)
    lesser :: Int = equal :: Int = 0
    greater :: Int= length(arr)
    while equal<greater
@inbounds   if arr[equal+1] == pivot
            equal+=1
            continue
        end
@inbounds   if arr[equal+1]>pivot
@inbounds   arr[equal+1], arr[greater] = arr[greater], arr[equal+1]
            greater-=1
        else
            lesser+=1
            equal+=1
@inbounds   arr[lesser],arr[equal] = arr[equal], arr[lesser]
        end
    end
    return lesser, greater+1
end

function _QuickSort(_arr :: AbstractArray{T}) where T
    if length(_arr) > 1
        border1, border2 = _partitition(_arr)
        _QuickSort(@view(_arr[begin:border1]))
        _QuickSort(@view(_arr[border2:end]))
    end
end