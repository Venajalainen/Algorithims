include("to_step.jl")

function det(_M :: AbstractMatrix{T} ; eps = 1e-5) where T
    @assert size(_M,1) == size(_M,2)
    M = to_step(_M)
    detM :: T = one(T)
    for i in 1:size(M,1)
        detM*=M[i,i]
    end
    return detM
end