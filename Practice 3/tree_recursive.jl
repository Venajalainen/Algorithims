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

function roots( arr :: Union{Vector,Int})
    length(arr)==0 || typeof(arr) <: Int && return 0
    s = Int(any(length(subarr)!=0 for subarr in arr[1:end-1]))
    for subarr in arr[1:end-1]
        s += roots(subarr)
    end
    return s
end

function treepower( arr :: Union{Vector,Int}, root :: Bool = true)
    length(arr)==0  && return 1
    typeof(arr) <: Int && return 1
    return max(1,Int(!root)+length(arr[1:end-1]),[treepower(subarr, false) for subarr in arr[1:end-1]]...)
end

function meantrail(_arr :: Union{Vector,Int})
    function recursion(arr :: Union{Vector,Int})
        length(arr) == 0 && begin println("OK"); return (1,0) end
        typeof(arr)<:Int &&  return (1,1)
        N = S = length(arr[1:end-1])
        println(arr," ",N, " ", S)
        for subarr in arr[1:end-1]
            s, n = recursion(subarr)
            S+=s
            N+=n
        end
        return S,N
    end
    S,N = recursion(_arr)
    println(S," ",N)
    return S/N
end

  