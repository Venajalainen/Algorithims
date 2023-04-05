import Base: +,-,*, display
import Base: zero,one, iszero
import Base: mod, rem, div
import Base: getindex, length, abs
include("gcd_.jl")

mutable struct Polynom{T}

    coeffs :: Vector{T}

    Polynom{T}( a :: Vector{T}) where T = new{T}(a)
    Polynom{T}( a :: T) where T = new{T}([a])
    Polynom{T}() where T = new{T}([zero(T)])
    Polynom{T}(a :: NTuple{N,T}) where {N,T} = new{T}([a...])

end

function +(p1 :: Polynom{T}, p2 :: Polynom{T}) where T

    size :: Int = max(length(p1), length(p2))
    new_coeffs :: Vector{T} = zeros(T,size)

    if length(p1)>length(p2)
        new_coeffs :: Vector{T} = copy(p1.coeffs)
    else
        new_coeffs :: Vector{T} = copy(p2.coeffs)
    end

    for i in eachindex(new_coeffs)
        i<=length(p1.coeffs) && (new_coeffs[i]+=p1[i])
        i<=length(p2.coeffs) && (new_coeffs[i]+=p2[i])
    end

    return Polynom{T}(new_coeffs)

end

+(p :: Polynom{T}, x :: T) where T = p+Polynom{T}(x)

function *(a :: T, p :: Polynom{T}) where T
    new_coeffs :: Vector{T} = copy(p.coeffs);
    @. new_coeffs*=a
    return Polynom{T}(new_coeffs)
end


function -(p1 :: Polynom{T}, p2 :: Polynom{T})  where T

    size :: Int = max(length(p1), length(p2))
    if length(p1)>length(p2)
        new_coeffs :: Vector{T} = copy(p1.coeffs)
    else
        new_coeffs :: Vector{T} = copy(p2.coeffs)
    end

    for i in eachindex(new_coeffs)
        i<=length(p1.coeffs) && (new_coeffs[i]+=p1[i])
        i<=length(p2.coeffs) && (new_coeffs[i]-=p2[i])
    end

    return Polynom{T}(new_coeffs)

end

-(p1 :: Polynom{T}, x :: T) where T = p1-Polynom{T}(x)

function display( p :: Polynom{T}) where T
    for i in eachindex(p.coeffs)
        print("t^",length(p)-i,raw"    ")
    end
    println()
    for i in eachindex(p.coeffs)
        print(p[i]); print(raw"    ")
    end
end

zero(:: Type{Polynom{T}}) where  T = Polynom{T}()
one(:: Type{Polynom{T}}) where T = Polynom{T}(one(T))
abs( p :: Polynom) = p

iszero(p :: Polynom{T}) where T = all([x==zero(T) for x in p.coeffs])

function *(a :: T, p :: Polynom{T}) where T
    new_coeffs :: Vector{T} = copy(p.coeffs)

    for i in eachindex(new_coeffs)
        new_ceoffs *= a
    end

    return Polynom{T}(new_coeffs)
end

function *(p1 :: Polynom{T}, p2 :: Polynom{T}) where T

    new_coeffs :: Vector{T} = zeros(T, length(p1) + length(p2) - 1)
    

    if length(p2)>length(p1) p1_coeffs = copy(p2.coeffs); p2_coeffs = copy(p1.coeffs)
    else p1_coeffs = copy(p1.coeffs); p2_coeffs = copy(p2.coeffs)
    end

    for i in 1:length(p1_coeffs)
        for j in 1:length(p2_coeffs)
            new_coeffs[i+j-1] += p1_coeffs[i]*p2_coeffs[j]
        end
    end

    return Polynom{T}(new_coeffs)


end

function mod(p :: Polynom{T}, x :: Union{Polynom{T},NTuple{M,T}}) where {M,T}

    p_coeffs :: Vector{T} = copy(p.coeffs)

    length(p)<length(x) && return Polynom{T}(new_coeffs)

    for i in 1:(length(p) - length(x) + 1)
        k = p_coeffs[i]/x[1]
        for j in 1:length(x)
            p_coeffs[i+j-1] = p_coeffs[i+j-1] - k*x[j]
        end
    end

    new_coeffs = p_coeffs[length(p) - length(x) + 2 : length(p)]

    return Polynom{T}(new_coeffs)

end

rem( p :: Polynom{T}, x :: Union{Polynom{T},NTuple{M,T}}) where {M,T} = mod(p,x)

function (p :: Polynom{T})(x :: T) where T
    res :: T = p.coeffs[1]

    for i in 2:length(p)
        res = res*x+p.coeffs[i]
    end

    return res

end

function div(p :: Polynom{T}, x :: Union{Polynom{T},NTuple{M,T}}) where {M,T}

    p_coeffs :: Vector{T} = copy(p.coeffs)
    new_coeffs :: Vector{T} = Vector{T}()

    length(p)<length(x) && return Polynom{T}(new_coeffs)

    for i in 1:(length(p) - length(x) + 1)

        push!(new_coeffs,p_coeffs[i]/x[1])
        
        for j in 1:length(x)
            p_coeffs[i+j-1] = p_coeffs[i+j-1] - new_coeffs[i]*x[j]
        end
    end

    return Polynom{T}(new_coeffs)

end

getindex(p :: Polynom, index :: Int) = p.coeffs[index]

length(p :: Polynom) = length(p.coeffs)

