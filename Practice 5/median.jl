function _order!(arr :: AbstractArray, index :: Int)
    @inline function _partitition(interval)
        pivot = rand(arr[interval[begin]:interval[end]])
        lesser :: Int = equal :: Int= interval[begin]-1
        greater = interval[end]
        while equal<greater
@inbounds   if arr[equal+1] == pivot
                equal+=1   
                continue
            end
@inbounds   if arr[equal+1]>pivot
@inbounds       arr[equal+1], arr[greater] = arr[greater], arr[equal+1]
                greater-=1
            else
                lesser+=1
                equal+=1
@inbounds       arr[equal], arr[lesser] = arr[lesser], arr[equal]
            end
        end
        return lesser, equal+1
    end

    interval = [firstindex(arr),lastindex(arr)]
    while true
        left, right = _partitition(interval)
        if index<=left
            interval[end] = left
        end
        if index>=right
            interval[begin] = right
        end
        left<index<right && return arr[index]
    end
end

function _median(arr :: AbstractArray)
    N :: Int = length(arr)
    index :: Int = N÷2 + mod(N,2)
    _arr = copy(arr)
    median :: Float64 = _order!(_arr,index)
    mod(N,2)==1 && return median
    return (median+_arr[index+1])/2
end