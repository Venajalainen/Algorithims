function newton( ψ :: Function , xₖ :: T, maxiter :: Int = 15, ε :: Float64 = 0.0001) where T

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

p = Polynom{Float64}([1.,0,-1.])

newton(-2.) do x

    res, der = p[1], p[1]*(length(p)-1)
    for i in 2:length(p)
        res = res*x + p[i]
        if length(p)>1 der = der*x + p[i]*(length(p)-i) end
    end

    println(der," ", 2*x)

    return res/der
end

newton(-2.) do x

    return (x^2-1)/(2x)

end