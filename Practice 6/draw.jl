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
    for point in poly.points
        push!(x,point.x)
        push!(y,point.y)
    end
    push!(x,poly.points[begin].x)
    push!(y,poly.points[begin].y)
    r = plot!(x,y)
    return r
end