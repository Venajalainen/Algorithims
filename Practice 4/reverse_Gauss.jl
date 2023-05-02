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

"""
arr = [rand(Float64) for i in 1:25]
M = AbstractMatrix(arr,(5,5)))
"""
