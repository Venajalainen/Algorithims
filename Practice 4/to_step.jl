function to_step(A :: AbstractMatrix{T}; eps = 1e-3) where T

    function swap!(B :: AbstractArray{T}, C :: AbstractArray{T})
        @inbounds for i in eachindex(B,C)
            B[i], C[i] = C[i], B[i]
        end
    end

    @inline function checkdif!(B :: AbstractVector{T}, C :: AbstractVector{T}, koeff :: T)
        @inbounds for i in eachindex(B)
            B[i] = (B[i] - koeff*C[i] > eps ? B[i] - koeff*C[i] : 0)
        end
    end

    @inbounds for row in 1:size(A, 1)
        maxval, rowindex = findmax(abs, @view(A[row:end,row]))
        swap!(@view(A[row,:]), @view(A[row + rowindex - 1,:]))
        for nextrow in row+1:size(A,1)
            println(A[row,row])
            @views checkdif!(A[nextrow,row:end],A[row,row:end],A[nextrow,row]/A[row,row])
        end
    end
    return A
end