include("fastpow.jl")

function fibonaci(n :: BigInt)

    return (fastpow([0 1; 1 1],n)*[0 ; 1])[1,1]

end