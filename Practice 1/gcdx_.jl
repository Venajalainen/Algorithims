function gcdx_( a :: T, b :: T ) where T <: Integer

    u ,v = one(T), zero(T)
    u′, v′ = zero(T),  one(T)

    #ИНВ: a′*u + b′*v = a и a′*u′ + b′*v′ = b и НОД(a,b) = НОД(a′,b′)
    while !iszero(b)
        
        k  = div(a,b)
        a, b = b, a-k*b
        u′, v′, u, v = u-k*u′, v-k*v′, u′, v′

    end

    if a<0
        return -a,-u,-v
    end

    return a,u,v

end

function gcdx_( a :: T, b :: T ) where T

    u ,v = one(T), zero(T)
    u′, v′ = zero(T),  one(T)


    #ИНВ: a′*u + b′*v = a и a′*u′ + b′*v′ = b и НОД(a,b) = НОД(a′,b′)
    while !iszero(b)
        
        k  = div(a,b)
        a, b = b, a-k*b
        u′, v′, u, v = u-k*u′, v-k*v′, u′, v′

    end

    return a,u,v

end