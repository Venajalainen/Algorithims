
function newton( ψ :: Function , xₖ :: T, maxiter :: Int = 15, ε :: Float64 = 0.0001) where T

    """
    ψ(x) = ϕ(x)/ϕ′(x)
    """
    xₖ₊₁ :: T, k :: Int = xₖ, 0

    while abs(ψ(xₖ₊₁)) > ε && k<maxiter
        xₖ₊₁, k = xₖ₊₁ - ψ(xₖ₊₁), k+1
    end

    abs(ψ(xₖ₊₁))>=ε && return 0

    return xₖ₊₁
end

#println(newton((x)->(cos(x)-x)/(-sin(x)-1), 1.))