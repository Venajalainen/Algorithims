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
    return x
end

function reverseGausstransposed(M :: AbstractMatrix{T}, B :: AbstractVector{T}) where T
    
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
        @inbounds @views x[N - i + 1] = (B[N-i+1]-sumprod( M[N-i+2:end,N-i+1],x[N-i+2:end])) / M[N-i+1,N-i+1]
    end
    return x
end
"""
arr = [rand(Float64) for i in 1:1000000]
M = reshape(arr,(1000,1000))
B = [rand(Float64) for i in 1:1000]

R =  [1. 2. 3.
    4. 5. 6.
    12. 13. 15.]
B = [1.
    2.
    3.]

    M = [
 1.0  1.0  4.0
 2.0  3.0  6.0
]

M = [ 2.0   0.0
3.0  -0.5
6.0   1.0]
"""
