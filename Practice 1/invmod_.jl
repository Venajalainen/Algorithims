include("gcd_.jl")
include("gcdx_.jl")

function invmod_( a :: Type, M :: Type) where Type

    if gcd_(a,M)!=one(Type) return nothing end

    r, u ,v = gcdx_( a, M)

    if u<0 u+=M end

    return u;

end