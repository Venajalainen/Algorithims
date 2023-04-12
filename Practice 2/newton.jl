import LinearAlgebra
import Base: abs

function newton( ψ :: Function , xₖ :: T; maxiter :: Int = 15, ε :: Float64 = 0.0001) where T

    xₖ₊₁ :: T, k :: Int = xₖ, 0

    """
    ψ(x) = ϕ(x)/ϕ′(x)
    """

    while abs(ψ(xₖ₊₁)) > ε && k<maxiter
        xₖ₊₁, k = xₖ₊₁ - ψ(xₖ₊₁), k+1

    end

    abs(ψ(xₖ₊₁))>=ε && begin @warn("Bad aproximation"); return NaN end

    return xₖ₊₁

end

#testing for Polynoms

include("../Practice 1/Polynom.jl")

function test()

    p = Polynom{Float64}([-3.,8.,-2.,-2.])

    res = newton(2.) do x

        res, der = 0, 0
        for i in 1:length(p)
            res = res*x + p[i]
            der = der*x + p[i]*max(0,length(p) - i)
        end

        return res*x/der
    end

    println(res)

    res = newton(0.5) do x
        return (cos(x) - x)/(-sin(x)-1)
    end

    println(res)

    res = newton([1.,0]) do (x,y)
        Jacobi = [2x     2y 
                  3y*x^2 x^3]
        return inv(Jacobi) * [x^2+y^2-2,y*x^3-1]
        
    end

    println(res)
end

function abs( x :: Vector{T}) where T
    return max(abs.(x)...)
end