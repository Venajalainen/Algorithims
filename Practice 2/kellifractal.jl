include("newton.jl")
using GLMakie
using Plots
using Images

function build(;x :: Int = 1000, y :: Int = 1000, maxiter :: Int = 15, ε :: Float64= 0.3)

    colors :: NTuple = (RGB(1,0,0),RGB(0,1,0),RGB(0,0,1))
    _x ::Float64, _y :: Float64 = Float64(x), Float64(y)

    function kelli(x ,y)
    
        x, y = Float64(x), Float64(y)
    
        roots :: Vector{Complex{Float64}} = [1, -1/2 + sqrt(3)*im/2, -1/2 - sqrt(3)*im/2]
        res = newton(x + y*im; maxiter = maxiter) do z
            return (z^3-1)/(3z^2)
        end
                
        res === NaN && return RGB(0,0,0)

        difs = [abs(root-res) for root in roots]

        #min(difs...)>=ε && return RGB(0,0,0)

        return colors[findfirst(difs) do x
            return x==min(difs...)
        end
        ]
    
    end

    image = Matrix{RGB}(undef, x, y)

    for i in 1:x
        for j in 1:y
            image[j,i] = kelli((i-x/2)/x,(j-y/2)/y)
        end
    end

    Images.save("kelli.png", image)
end
