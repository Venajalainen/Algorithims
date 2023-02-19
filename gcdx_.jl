function gcdx_( a :: Type, b :: Type ) where Type

    u ,v = one(Type), zero(Type)
    u′, v′ = zero(Type),  one(Type)

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