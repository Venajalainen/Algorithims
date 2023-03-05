import Base: one

function fastpow( value :: T, power :: Int) where T

    p :: T, t :: T = copy(value), one(T)

    while !iszero(power)

        if iseven(power)
            p*= p
            power÷=2
        else
            t*=p
            power-=1
        end

    end

    return t

end

one(::Type{Matrix{T}}) where T = [1 0; 0 1]