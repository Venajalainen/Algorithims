import Base: +,-, display,zero,one,mod

mutable struct Polynom{T}

    coeffs :: Vector{T}

    Polynom{T}( a :: Vector{T}) where T = new{T}(a)
    Polynom{T}( a :: T) where T = new{T}([a])
    Polynom{T}() where T = new{T}([zero(T)])
    Polynom{T}(a :: Vector) where T = new{T}([T(x) for x in a])

end

function +(p1 :: Polynom{T}, p2 :: Polynom{T}) where T

    size :: Int = max(length(p1.coeffs), length(p2.coeffs))
    new_coeffs :: Vector{T} = zeros(T,size)

    for i in eachindex(new_coeffs)
        i<=length(p1.coeffs) && (new_coeffs[i]+=p1.coeffs[i])
        i<=length(p2.coeffs) && (new_coeffs[i]+=p2.coeffs[i])
    end

    return Polynom{T}(new_coeffs)

end

+(p :: Polynom{T}, x :: Any) where T = p+Polynom{T}(T(x))

function -(p1 :: Polynom{T}, p2 :: Polynom{T}) :: Nothing where T

    size :: Int = max(length(p1.coeffs), length(p2.coeffs))
    new_coeffs :: Vector{T} = zeros(T,size)

    for i in eachindex(new_coeffs)
        i<=length(p1.coeffs) && (new_coeffs[i]+=p1.coeffs[i])
        i<=length(p2.coeffs) && (new_coeffs[i]-=p2.coeffs[i])
    end

    return Polynom{T}(new_coeffs)

end

-(p1 :: Polynom{T}, x :: Any) where T = p1-Polynom{T}(T(x))

function display( p :: Polynom{T}) where T
    for i in eachindex(p.coeffs)
        print("t^",i-1,raw"    ")
    end
    println()
    for i in eachindex(p.coeffs)
        print(p.coeffs[i]); print(raw"    ")
    end
end

zero(:: Polynom{T}) where  T = Polynom{T}()
one(:: Polynom{T}) where T = Polynom{T}(one(T))

function mod(p :: Polynom{T}, x :: NTuple{M,T}) where {M,T}

    for i in 1:(lastindex(p.coeffs)-M+1)
        k = p.coeffs[i]/x[1]
        for j in 1:M
            p.coeffs[i+j-1]-=k*x[j]
        end
    end

    return p

end