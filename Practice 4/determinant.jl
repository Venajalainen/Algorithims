include("to_step.jl")

function det(M :: AbstractMatrix{T} ; eps = 1e-5) where T
    @assert size(M,1) == size(M,2)
    to_step!(M)
    detM :: T = one(T)
    for i in 1:size(M,1)
        detM*=M[i,i]
    end
    return detM
end