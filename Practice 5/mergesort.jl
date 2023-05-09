@inline function _indexmerge!(arr :: AbstractArray{T}, begin1 :: T1 , end1 :: T1, begin2 :: T1, end2 :: T1) where {T,T1<:Int}
    interval = range(begin1,end2)
    cache = zeros(T, length(interval))
    i :: Int = 1
    @inbounds while begin1<=end1 || begin2<=end2
        if begin1>end1 || (begin2<=end2) && (arr[begin1]>=arr[begin2])
            cache[i] = arr[begin2]
            begin2+=1
            i+=1
            continue
        end
        if begin2>end2 || (begin1<=end1) && (arr[begin1]<=arr[begin2])
            cache[i] = arr[begin1]
            begin1+=1
            i+=1
            continue
        end
    end

    @inbounds for k in interval
        arr[k] = cache[k-interval[1]+1]
    end
end
function _MergeSort(arr :: AbstractArray{T}) where T
    step :: Int = 1
    while step<=length(arr)
        i :: Int = 1
        f = (k)->[k,k+step-1,k+step,k+2*(step-1)]
        while true
            interval = [i,i+step-1,i+step,min(i+2step-1,length(arr))]
            if interval[3]>length(arr) break end
            _indexmerge!(arr,interval[1],interval[2], interval[3], interval[4])
            i = i+2step
        end
        step*=2
    end
    return arr
end