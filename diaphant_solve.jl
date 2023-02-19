include("gcd_.jl")
include("gcdx_.jl")

function diaphant_solve( a :: Type, b :: Type, c :: Type )  where Type

    if rem(c,gcd(a,b))!=zero(Type) return nothing end

    r, u, v = gcdx_( a, b)

    return c*u,c*v

end