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

function drawline(line :: Segment2D{T}) where T<:Real
    x = []
    y = []
    push!(x,line.p1.x)
    push!(y,line.p1.y)
    push!(x,line.p2.x)
    push!(y,line.p2.y)
    r = plot!(x,y)
    return r
end

function drawfunc(f :: Function,a :: Real, b :: Real)
    x = range(a,b,100)
    y = []
    for _x in x
        push!(y, f(_x))
    end
    r = plot!(x,y)
    return r

end