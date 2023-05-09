function linearsort(arr :: AbstractArray{Int})
    interval = [0 for i in range(min(arr...),max(arr...))]
    for x in arr
        interval[x]+=1
    end

    j = 1
    _arr = similar(arr)
    for i in eachindex(interval)
        while interval[i]>0
            _arr[j] = i
            interval[i]-=1
            j+=1
        end
    end
    return _arr
end

