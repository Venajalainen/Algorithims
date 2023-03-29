include("gcd_.jl")
include("gcdx_.jl")

function diaphant_solve( a :: T, b :: T, c :: T )  where T

    if rem(c,gcd_(a,b))!=zero(T) return 0 end

    r, u, v = gcdx_( a, b)

    return c*u,c*v

end