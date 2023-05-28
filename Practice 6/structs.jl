import Base: +,-,*,cos,sin,angle,sign, display, acos, isless
import LinearAlgebra: norm, dot
using DataStructures
include("../Practice 4/determinant.jl")
include("../Practice 4/rang.jl")

struct Vector2D{T<:Real}
    x :: T
    y :: T
end

+(a :: Vector2D{T}, b :: Vector2D{T}) where T = Vector2D{T}(a.x+b.x,a.y+b.y)
-(a :: Vector2D{T}, b :: Vector2D{T}) where T = Vector2D{T}(a.x-b.x,a.y-b.y)
*(a :: Vector2D{T}, b :: Vector2D{T}) where T = Vector2D{T}(a.x*b.x,a.y*b.y)
cos(a :: Vector2D{T}, b :: Vector2D{T}) where T = sign(dot(a,b))*min(abs(dot(a,b)/(norm(a)*norm(b))),1)
sin(a :: Vector2D{T}, b :: Vector2D{T}) where T = xdot(a,b)/(norm(a)*norm(b))
norm(a :: Vector2D{T}) where T = norm((a.x,a.y))
dot(a :: Vector2D{T}, b :: Vector2D{T}) where T = a.x*b.x+a.y*b.y
xdot(a :: Vector2D{T}, b :: Vector2D{T}) where T = a.x*b.y-a.y*b.x
angle(a :: Vector2D{T}, b :: Vector2D{T}) where T = atan(sin(a,b)/cos(a,b))
sign(a :: Vector2D{T}, b :: Vector2D{T}) where T = sign(xdot(a,b))
display(a :: Vector2D{T}) where T = display((a.x,a.y))
acos(a :: Vector2D{T}, b :: Vector2D{T}) where T = acos(cos(a,b))
subangle(a :: Vector2D{T}, b :: Vector2D{T}, centre :: Vector2D{T}) where T = return acos(cos(a-centre,b-centre))

struct Segment2D{T <: Real}
    p1 :: Vector2D{T}
    p2 :: Vector2D{T}
    Segment2D{T}(p1 :: NTuple{2,T}, p2 :: NTuple{2,T}) where T<:Real = new{T}(Vector2D(p1...),Vector2D(p2...))
    Segment2D{T}(p1 :: Vector2D{T}, p2 :: Vector2D{T}) where T <:Real = new{T}(p1,p2)
end

function sameside(line :: Segment2D{T}, p1 :: Vector2D{T}, p2 :: Vector2D{T}) :: Bool where T
    origin = line.p1-line.p2
    return sign(origin,p1) == sign(origin,p2) || sign(origin,p1)*sign(p2,origin)==0
end

function sameside(f :: Function, p1 :: Vector2D{T}, p2 :: Vector2D{T}) :: Bool where T
    return sign(f(p1.x,p1.y)) == sign(f(p2.x,p2.y)) || sign(f(p1.x,p1.y))*sign(f(p2.x,p2.y))==0
end

function intersection(line1 :: Segment2D{T}, line2 :: Segment2D{T}) where T<: Real
    𝚫x1 :: Float64,𝚫y1 :: Float64 = line1.p2.x-line1.p1.x, line1.p2.y-line1.p1.y
    𝚫x2 :: Float64,𝚫y2 :: Float64 = line2.p2.x-line2.p1.x, line2.p2.y-line2.p1.y
    M = [𝚫y1 -𝚫x1
         𝚫y2 -𝚫x2]
    B = [line1.p1.x*𝚫y1-line1.p1.y*𝚫x1
         line2.p1.x*𝚫y2-line2.p1.y*𝚫x2
        ]
    if det(M) == 0
        if rang(M) == rang([M B])
            @warn("линии совпадают")
        end
        return nothing
    end
    return M\B
end

struct Polygon{T<:Real}
    points :: Vector{Vector2D{T}}
    Polygon{T}(points :: AbstractVector{Vector2D{T}}) where T<:Real = new{T}(points)
end

function insidepolygon(p :: Vector2D{T}, poly :: Polygon{T}) where T<:Real

    sum_angle :: T = zero(T)
    N = length(poly.points)

    for i in 1:N
        p1 = poly.points[max(mod(i+1,N+1),1)]
        p2 = poly.points[i]
        sum_angle+=sign(p1-p,p2-p)*subangle(p1, p2, p)
    end

    return abs(sum_angle)>pi
end

function convex(poly :: Polygon{T}) where T
    N = length(poly.points)
    p1 = poly.points[N] - poly.points[begin]
    p2 = poly.points[2] - poly.points[begin]
    ind = sign(p2,p1)
    for i in 1:N-1
        p1 = poly.points[i] - poly.points[i+1]
        p2 = poly.points[max(mod(i+2,N+1),1)] - poly.points[i+1]
        if sign(p2,p1)!=ind
            return false
        end
    end
    return true
end

function Jarvis(points :: AbstractVector{Vector2D{T}}) :: Polygon{T} where T<:Real
    pivot :: Vector2D = points[1];
    for point in points
        if point.x>pivot.x
            pivot = point
        end
    end
    polygon = Polygon{T}([pivot])
    orientation = Vector2D{Real}(1,0)
    function nextpoint(_pivot :: Vector2D{T}, _orientation :: Vector2D{Real}) where T
        minang = 2pi
        next = _pivot
        for point in points
            ang = acos(cos(_orientation,point-_pivot))
            if sign(xdot(_orientation,point-_pivot))<0 ang=2pi - ang end
            if ang-minang == 0 && point.x<next.x && point.y<next.y
                next = point
            end
            if ang<minang && point != _pivot
                minang = ang
                next = point
            end
        end
        return next, next - _pivot
    end
    pivot, orientation = nextpoint(pivot, orientation)
    while polygon.points[begin]!=pivot
        push!(polygon.points,pivot)
        pivot, orientation = nextpoint(pivot, orientation)
    end
    return polygon
end

function Grekhom(points :: AbstractVector{Vector2D{T}}) :: Polygon{T} where T<:Real
    pivot :: Vector2D = points[1];
    for point in points
        if point.y<pivot.y
            pivot = point
        end
    end
    orientation = Vector2D{Real}(1,0)
    sorted_points = [(0.,pivot)]
    for point in [p for p in points if p!=sorted_points[begin][2]]
        ang = acos(cos(orientation,point-pivot))
        if sign(xdot(orientation,point-pivot))<0 ang=2pi-ang end
        push!(sorted_points,(ang,point))
    end
    sort!(sorted_points, lt = lessangpoint )

    stack = Vector{Vector2D{Real}}()
    push!(stack,sorted_points[1][2])
    push!(stack,sorted_points[2][2])
    i = 3

    while i<=length(sorted_points)
        push!(stack,sorted_points[i][2])
        j = length(stack)
        while j>=3
            if sign(xdot(stack[j]-stack[j-1],stack[j-2]-stack[j-1]))<0
                stack[j], stack[j-1] = stack[j-1], stack[j]
                pop!(stack)
            end
            j-=1
        end
        i+=1
    end
    return Polygon{Real}(stack)
end

function lessangpoint(a, b, eps = 1e-8)
    a[1]-b[1]>eps && return false
    a[1]-b[1]<-eps && return true
    return a[2].x<b[2].x && a[2].y<b[2].y
end

function trapezoidarea(poly :: Polygon{T}) where T
    area :: Float64 = 0
    N = length(poly.points)
    for i in 1:N
        area+= (poly.points[max(mod(i+1,N+1),1)].x-poly.points[i].x)*(poly.points[max(mod(i+1,N+1),1)].y+poly.points[i].y)/2
    end
    return area
end

function trianglearea(poly :: Polygon{T}) where T
    area :: Float64 = 0
    N = length(poly.points)
    for i in 1:N
        #println(sign(poly.points[max(mod(i+1,N+1),1)],poly.points[i]))
        area+= xdot(poly.points[max(mod(i+1,N+1),1)],poly.points[i])/2
    end
    return area
end
#points = [Vector2D{Real}(1,3),Vector2D{Real}(3,2),Vector2D{Real}(-1,-1)]
#points = [Vector2D{Real}(1,1),Vector2D{Real}(6,6),Vector2D{Real}(6,1), Vector2D{Real}(5,4)]
#arr = [Vector2D{Real}(rand(2)...) for i in 1:20]
#for point in arr
#display(point)
#end
#[(1,1),(2,2),(3,3),(7,7),(-7,20)]
#[(1.4,3.58),(5.96,2.46),(4.64,1.04),(5,-2),(3.44,0.72),(1.1,-0.7),(4,2)]
# 6.89