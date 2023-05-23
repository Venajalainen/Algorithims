using Plots
include("structs.jl")

function drawpoints(arr :: Vector{Vector2D{T}}) where T<:Real
    x = []
    y = []
    for point in arr
        push!(x,point.x)
        push!(y,point.y)
    end
    r = scatter!(x,y)
    return r
end
function drawpolygon(poly :: Polygon{T}) where T<:Real
    x = []
    y = []
    for side in poly.sides
        push!(x,side.p1.x)
        push!(x,side.p2.x)
        push!(y,side.p1.y)
        push!(y,side.p2.y)
    end
    r = plot!(x,y)
    return r
end