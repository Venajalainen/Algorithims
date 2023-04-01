
function newton( ψ :: Function , xₖ :: T, maxiter :: Int = 15, ε :: Float64 = 0.0001, delta :: Float64 = 1e-5) where T

    xₖ₊₁ :: T, k :: Int = xₖ, 0


    while abs(ψ(xₖ₊₁)) > ε && k<maxiter
        xₖ₊₁, k = xₖ₊₁ - ψ(xₖ₊₁)*delta/(ψ(xₖ₊₁+delta) - ψ(xₖ₊₁)), k+1
    end

    abs(ψ(xₖ₊₁))>=ε && begin @warn("Bad starting point or too little ε, bad approximation"); return 0 end

    return xₖ₊₁
end

function newton( ψ :: Function , ψ′ :: Function, xₖ :: T, maxiter :: Int = 15, ε :: Float64 = 0.0001) where T

    xₖ₊₁ :: T, k :: Int = xₖ, 0


    while abs(ψ(xₖ₊₁)) > ε && k<maxiter
        xₖ₊₁, k = xₖ₊₁ - ψ(xₖ₊₁)/ψ′(xₖ₊₁), k+1
    end

    abs(ψ(xₖ₊₁))>=ε && return NaN

    return xₖ₊₁
end