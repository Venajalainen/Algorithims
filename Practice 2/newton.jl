include("../Practice 1/Polynom.jl")

function newton( ψ :: Function , xₖ :: T, maxiter :: Int = 15, ε :: Float64 = 0.0001) where T

    xₖ₊₁ :: T, k :: Int = xₖ, 0

    """
    ψ(x) = ϕ(x)/ϕ′(x)
    """

    while abs(ψ(xₖ₊₁)) > ε && k<maxiter
        xₖ₊₁, k = xₖ₊₁ - ψ(x), k+1
    end

    abs(ψ(xₖ₊₁))>=ε && begin @warn("Bad aproximation"); return NaN end

    return xₖ₊₁
    
end