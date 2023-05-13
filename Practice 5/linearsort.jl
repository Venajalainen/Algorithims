function _LinearSort(arr :: AbstractArray{Int})
    dif = min(arr...)
    interval = zeros(max(arr...)-min(arr...)+1)
    for x in arr
        interval[x-dif+1] +=1
    end

    j = 1
    _arr = similar(arr)
    for i in eachindex(interval)
        while interval[i]>0
            _arr[j] = i + dif -1
            interval[i]-=1
            j+=1
        end
    end
    return _arr
end

