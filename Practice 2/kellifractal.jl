include("newton.jl")
using Plots

function indexof( arr :: Vector{T}, value :: T) where T
    for i in eachindex(arr)
        arr[i]==value && return i;
    end
end
function kelli(;dim :: Int = 512, iters :: Int = 15, k :: Float64 = 1, ε :: Float64 = 1e-5)

    data :: Matrix{Int} = zeros(Float64,dim,dim)
    roots = [1 + 0*im,-1/2 + im*sqrt(3)/2, -1/2-im*sqrt(3)/2]

    for x in 1:dim
        for y in 1:dim
            z :: Complex{Float64} = k*(x-dim/2)/dim + k*(y-dim/2)*im/dim
            res :: Complex{Float64} = newton(z->(z^3-1),z->(3*z^2), z,iters, ε)
            if abs(res) === NaN data[y,x] = 0 else
                dist = [abs(res-root) for root in roots]
                data[y,x] = indexof( dist,min(dist...))
            end
        end
    end

    plot(heatmap(data))
end