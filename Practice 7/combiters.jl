import Base: iterate, get

abstract type CombinatoryIterator end

get( iterator :: CombinatoryIterator ) = iterator.arr
iterate(iterator :: CombinatoryIterator) = (get(iterator), nothing)
function iterate(iterator :: CombinatoryIterator, state)
    if isnothing(next(iterator))
        return nothing
    end
    return (get(iterator), nothing)
end


struct AllocationGenerator{N, K} <: CombinatoryIterator
    arr :: Vector{Integer}
    AllocationGenerator{N,K}() where {N,K} = new{N,K}(ones(Integer, K))
end

function next(iterator :: AllocationGenerator{N, K}) where {N,K}
    #println(iterator.arr)
    i :: Union{Int,Nothing} = findlast(iterator.arr) do x
        return x<N
    end

    isnothing(i) && return nothing

    iterator.arr[i]+=1
    iterator.arr[i+1:end].=1

    return iterator
end


struct PermutationGenerator{N} <: CombinatoryIterator
    arr :: Vector{Integer}
    PermutationGenerator{N}() where N = new{N}(collect(Integer,1:N))
end

function next(iterator :: PermutationGenerator{N}) where N
    i :: Int = N

    while i>1 && iterator.arr[i-1]>iterator.arr[i] i-=1 end

    i-=1

    iszero(i) && return nothing

    mini :: Int = min(i+1,N)
    minarr :: Int = N

    for j in i+1:N
        if iterator.arr[j]<minarr && iterator.arr[i]<iterator.arr[j]
            minarr = iterator.arr[j]
            mini = j
        end
    end


    iterator.arr[i], iterator.arr[mini] = iterator.arr[mini], iterator.arr[i]
    reverse!(@view(iterator.arr[i+1:end]))

    return iterator
end

struct SubsetGenerator{N} <: CombinatoryIterator
    arr :: Vector{Integer}
    SubsetGenerator{N}() where N = new{N}(zeros(Integer,N))
end

function next(iterator :: SubsetGenerator{N}) where N
    i :: Union{Int,Nothing} = findlast(iterator.arr) do x
        return iszero(x)
    end
    isnothing(i) && return nothing
    iterator.arr[i] = 1
    iterator.arr[i+1:end].= 0

    return iterator
end

struct SubSubsetGenerator{N, K} <: CombinatoryIterator
    arr :: Vector{Integer}
    function SubSubsetGenerator{N, K}() where {N,K}
        arr = zeros(Integer,N)
        arr[end-K+1:end].=1
        new{N, K}(arr)
    end
end

function next(iterator :: SubSubsetGenerator{N, K}) where {N,K}

    i :: Int = length(iterator.arr)
    number_of_ones :: Int = 0
    while i>1
        if iterator.arr[i]==1 && iterator.arr[i-1] == 0 break end
        number_of_ones+=iterator.arr[i]
        i-= 1 
    end

    isone(i) && return nothing

    iterator.arr[i-1], iterator.arr[i] = iterator.arr[i], iterator.arr[i-1]
    iterator.arr[i:end].=0
    iterator.arr[end-number_of_ones+1:end].=1

    return iterator
end

struct NumberDividorGenerator{N} <: CombinatoryIterator
    arr :: Vector{Integer}
    NumberDividorGenerator{N}() where N = new{N}(ones(Integer,N))
end

function next(iterator :: NumberDividorGenerator{N}) where N

    i :: Int = findlast(iterator.arr) do x
          return !iszero(x)
    end

    while i>1 && iterator.arr[i]!=iterator.arr[i-1] i-=1 end

    i = max(i,2)
    iszero(iterator.arr[i]) && return nothing
    #println(i)

    iterator.arr[i-1]+=1; iterator.arr[i]-=1

    if iszero(iterator.arr[i]) && i<N
      iterator.arr[i], iterator.arr[i+1] = iterator.arr[i+1], iterator.arr[i]
    end

    j :: Int = i-1
    while j>1 && iterator.arr[j]>iterator.arr[j-1]
        iterator.arr[j], iterator.arr[j-1] = iterator.arr[j-1],iterator.arr[j]
        j-=1
    end

    return iterator

end

function test(iterator :: CombinatoryIterator)
    for alloc in iterator
        println(alloc)
    end
end