function depth( arr :: Union{Vector,Int}, i :: Int = 1)
    length(arr)==0 && return i-1
    typeof(arr) <: Int && return i
    return max([depth(subarr,i+1) for subarr in arr[1:end-1]]...)
end

function leafs( arr :: Union{Vector,Int})
    length(arr)==0  && return 0
    typeof(arr) <: Int && return 1
    all(length(subarr)==0 for subarr in arr[1:end-1]) && return 1 
    s=0
    for subarr in arr[1:end-1]
        s+=leafs(subarr)
    end
    return s
end

function nodes( arr :: Union{Vector,Int})
    typeof(arr) <: Int && return 1
    s = 0
    for subarr in arr
        s += nodes(subarr)
    end
    return s
end

function treepower( arr :: Union{Vector,Int}, root :: Bool = true)
    length(arr)==0  && return 1
    typeof(arr) <: Int && return 1
    return max(1,Int(!root)+length(arr[1:end-1]),[treepower(subarr, false) for subarr in arr[1:end-1]]...)
end

function meantrail(_arr :: Union{Vector,Int})
    function recursive(arr; depth :: Int = 0)
        isempty(arr) && return 0,0
        typeof(arr) <: Int && return depth,1
        s,n = depth, 1
        for subarr in arr[1:end-1]
            _s, _n = recursive(subarr; depth = depth+1)
            s+=_s
            n+=_n
        end
        return s,n
    end
    paths,verts = recursive(_arr)
    #println(paths," ", verts)
    return paths/verts
end