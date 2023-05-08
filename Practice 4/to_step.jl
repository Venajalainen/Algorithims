function to_step!(A :: AbstractMatrix{T}; eps = 1e-3) where T

    function swap!(B :: AbstractArray{T}, C :: AbstractArray{T})
        @inbounds for i in eachindex(B,C)
            B[i], C[i] = C[i], B[i]
        end
    end

    @inline function checkdif!(B :: AbstractVector{T}, C :: AbstractVector{T}, koeff :: T)
        @inbounds for i in eachindex(B)
            B[i] = (abs(B[i] - koeff*C[i]) > eps ? B[i] - koeff*C[i] : 0)
        end
    end

    @inbounds for row in 1:size(A, 1)
        maxval, rowindex = findmax(abs, @view(A[row:end,row]))
        swap!(@view(A[row,:]), @view(A[row + rowindex - 1,:]))
        for nextrow in row+1:size(A,1)
            #println(A[row,row])
            @views checkdif!(A[nextrow,row:end],A[row,row:end],A[nextrow,row]/A[row,row])
        end
    end
    return A
end

function to_step(_A :: AbstractMatrix{T}; eps = 1e-3) where T

    function swap!(B :: AbstractArray{T}, C :: AbstractArray{T})
        @inbounds for i in eachindex(B,C)
            B[i], C[i] = C[i], B[i]
        end
    end

    @inline function checkdif!(B :: AbstractVector{T}, C :: AbstractVector{T}, koeff :: T)
        @inbounds for i in eachindex(B)
            B[i] = (abs(B[i] - koeff*C[i]) > eps ? B[i] - koeff*C[i] : 0)
        end
    end

    A :: AbstractMatrix{T} = copy(_A)

    @inbounds for row in 1:size(A, 1)
        maxval, rowindex = findmax(abs, @view(A[row:end,row]))
        swap!(@view(A[row,:]), @view(A[row + rowindex - 1,:]))
        for nextrow in row+1:size(A,1)
            @views checkdif!(A[nextrow,row:end],A[row,row:end],A[nextrow,row]/A[row,row])
        end
    end
    return A
end

function to_step_transposed!(A :: AbstractMatrix{T}; eps = 1e-3) where T

    function swap!(B :: AbstractArray{T}, C :: AbstractArray{T})
        @inbounds for i in eachindex(B,C)
            B[i], C[i] = C[i], B[i]
        end
    end

    @inline function checkdif!(B :: AbstractVector{T}, C :: AbstractVector{T}, koeff :: T)
        @inbounds for i in eachindex(B)
            B[i] = (abs(B[i] - koeff*C[i]) > eps ? B[i] - koeff*C[i] : 0)
        end
    end

    @inbounds for col in 1:size(A, 2)
        maxval, colindex = findmax(abs, @view(A[col,col:end]))
        swap!(@view(A[:,col]), @view(A[:,col + colindex - 1]))
        for nextcol in col+1:size(A,2)
            @views checkdif!(A[col:end,nextcol],A[col:end, col],A[col,nextcol]/A[col,col])
        end
    end
    return A
end