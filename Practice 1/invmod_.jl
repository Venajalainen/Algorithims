include("gcd_.jl")
include("gcdx_.jl")

function invmod_( a :: T, M :: T) where T <: Integer

    if gcd_(a,M)!=one(T) return 0 end

    r, u ,v = gcdx_( a, M)

    if u<0 u+=M end

    return u;

end

function invmod_( a :: T, M :: T) where T

    if gcd_(a,M)!=one(T) return 0 end

    r, u ,v = gcdx_( a, M)

    return u;

end