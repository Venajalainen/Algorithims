include("newton.jl")
using Plots

function indexof( arr :: Vector{T}, value :: T) where T
    for i in eachindex(arr)
        arr[i]==value && return i;
    end
end
function kelli()
    dim :: Int = 2048
    data :: Matrix{Float64} = zeros(Float64,dim,dim)
    roots = [1 + 0*im,-1/2 + im*sqrt(3)/2, -1/2-im*sqrt(3)/2]

    for x in 1:dim
        for y in 1:dim
            z :: Complex{Float64} = (x-dim/2)/dim + (y-dim/2)*im/dim
            res :: Complex{Float64} = newton(z->(z^3-1)/(3*z^2), z,30)
            dist = [abs(res-root) for root in roots]
            data[y,x] = indexof( dist,min(dist...))
        end
    end

    plot(heatmap(data))
end