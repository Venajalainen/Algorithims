using LinearAlgebra
include("reverse_Gauss.jl")
include("to_step.jl")

function solveSLAU(A :: AbstractMatrix{T}, B :: AbstractArray{T}) where T
    M = to_step([A B]; eps = 1e-7)
    if cond(M)>10000 @warn("плохо обусловленная матрица") end
    @views return reverseGauss(M[:,1:end-1], M[:,end]);
end

function fastersolverSLAU(A :: AbstractMatrix{T}, B :: AbstractArray{T}) where T
    M = transpose([A B])
    to_step_transposed!(M; eps = 1e-7)
    if cond(M)>10000 @warn("плохо обусловленная матрица") end
    @views return reverseGausstransposed(M[1:end-1,1:end], M[end,1:end]);
end