include("..//Practice 2//fastpow.jl")

function euler_sums(x :: Float64, n :: Int, eps :: Float64 = 1e-7)
    S :: Float64 = 1.
    a :: Float64 = x
    k :: Int = 2
    while k-2<n && S+a!=S && abs(a)>eps
        S+=a
        a = a*x/k
        k+=1
    end
    return S
end

function euler(x :: Float64)
    S :: Float64 = 1
    if abs(x)>1
        S = fastpow(euler(1.), Int(trunc(abs(x))))
        x -= trunc(x)
    end

    S1 :: Float64 = 1
    a :: Float64 = abs(x)
    k :: Int = 2
    while S1+a!=S1
        S1+=a
        a = a*abs(x)/k
        k+=1
    end
    
    x<0 && return 1/(S*S1)
    return S*S1

end