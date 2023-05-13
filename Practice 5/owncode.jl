@inline function _InsertionSort(arr :: AbstractArray{T}) where T
    sorted :: Int = 1
    for i in 2:length(arr)
        j :: Int = i
        @inbounds while j>1 && arr[j-1]>arr[j]
        @inbounds     arr[j], arr[j-1] = arr[j-1], arr[j]
            j-=1
        end
    end
    return arr
end

function _sort(arr :: AbstractArray, f :: Function = _InsertionSort)
    _arr = copy(arr)
    return _sort!(_arr,f)
end

function _sort!(arr :: AbstractArray, f :: Function = _InsertionSort)
    return f(arr)
end

function _sortperm(arr :: AbstractArray, f :: Function = _InsertionSort)
    _arr = copy(arr)
    return _sortperm!(_arr,f)
end

function _sortperm!(arr :: AbstractArray, f :: Function = _InsertionSort)
    _arr = [(arr[i], i) for i in eachindex(arr)]
    _sort!(_arr)
    rightindexes = similar(arr)
    for i in eachindex(arr)
        arr[i] = _arr[i][1]
        rightindexes[i] = _arr[i][2]
    end
    return rightindexes
end