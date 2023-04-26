using LinearAlgebra
function reverseGauss(M :: AbstractMatrix{T}, B :: AbstractVector{T}) where T
    
    @inline function sumprod(A :: AbstractArray{T}, C :: AbstractArray{T}) where T
        s :: T = zero(T)
        for i in eachindex(C)
            s = fma(A[i],C[i],s)
        end
        return s
    end

    x = similar(B)
    N = size(B,1)
    for i in 1:N
        @inbounds @views x[N - i + 1] = (B[N-i+1]-sumprod( M[N-i+1,N-i+2:end],x[N-i+2:end])) / M[N-i+1,N-i+1]
    end
    #println(x)
    return x
end

"""
M = [1. 2. 3.
    4. 5. 6.
    7. 8. 14.
]
"""
