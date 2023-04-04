import Base: one

function fastpow( a :: T, power :: Int) where T

    p :: T, t :: T, k :: Int = copy(a), one(T), power

    #ИНВ: a^power = p * t ^ k
    while !iszero(k)

        if iseven(k)
            p*= p
            k÷=2
        else
            t*=p
            k-=1
        end

    end

    return t

end

one(::Type{Matrix{T}}) where T = [1 0; 0 1]