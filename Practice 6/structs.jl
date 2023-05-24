import Base: +,-,*,cos,sin,angle,sign, display
import LinearAlgebra: norm, dot
include("../Practice 4/determinant.jl")
include("../Practice 4/rang.jl")

struct Vector2D{T<:Real}
    x :: T
    y :: T
end

+(a :: Vector2D{T}, b :: Vector2D{T}) where T = Vector2D{T}(a.x+b.x,a.y+b.y)
-(a :: Vector2D{T}, b :: Vector2D{T}) where T = Vector2D{T}(a.x-b.x,a.y-b.y)
*(a :: Vector2D{T}, b :: Vector2D{T}) where T = Vector2D{T}(a.x*b.x,a.y*b.y)
cos(a :: Vector2D{T}, b :: Vector2D{T}) where T = dot(a,b)/(norm(a)*norm(b))
sin(a :: Vector2D{T}, b :: Vector2D{T}) where T = xdot(a,b)/(norm(a)*norm(b))
norm(a :: Vector2D{T}) where T = norm((a.x,a.y))
dot(a :: Vector2D{T}, b :: Vector2D{T}) where T = a.x*b.x+a.y*b.y
xdot(a :: Vector2D{T}, b :: Vector2D{T}) where T = a.x*b.y-a.y*b.x
angle(a :: Vector2D{T}, b :: Vector2D{T}) where T = atan(sin(a,b)/cos(a,b))
sign(a :: Vector2D{T}, b :: Vector2D{T}) where T = sign(sin(a,b))
display(a :: Vector2D{T}) where T = display((a.x,a.y))
xdot(a :: Vector2D{T}, b :: Vector2D{T}, c :: Vector2D{T}) where T = (b.x-a.x)*(c.y-b.y)-(b.y-a.y)*(c.x-b.x)

struct Segment2D{T <: Real}
    p1 :: Vector2D{T}
    p2 :: Vector2D{T}
    Segment2D{T}(p1 :: NTuple{2,T}, p2 :: NTuple{2,T}) where T = new{T}(Vector2D(p1...),Vector2D(p2...))
    Segment2D{T}(p1 :: Vector2D{T}, p2 :: Vector2D{T}) where T = new{T}(p1,p2)
end

function angle(a :: Segment2D{T}, b :: Segment2D{T}) where T
    ang = atan(sin(a.p1-a.p2,b.p1-b.p2)/cos(a.p1-a.p2,b.p1-b.p2))
    ang>0 && return ang
    return pi+ang
end

to_origin(line :: Segment2D{T}) where T<:Real = line.p2-line.p1

function sameside(line :: Segment2D{Vector2D{T}}, p1 :: Vector2D{T}, p2 :: Vector2D{T}) :: Bool where T
    origin = to_origin(line)
    return sign(origin,p1) == sign(origin,p2) || sign(origin,p1)*sign(origin,p2)==0
end

function sameside(f :: Function, p1 :: Vector2D{T}, p2 :: Vector2D{T}) :: Bool where T
    return sign(f(p1.x,p1.y)) == sign(f(p2.x,p2.y)) || sign(f(p1.x,p1.y))*sign(f(p2.x,p2.y))==0
end

function intersection(line1 :: Segment2D{T}, line2 :: Segment2D{T}) where T<: Real
    𝚫x1 :: Float64,𝚫y1 :: Float64 = line1.p1.x-line1.p2.x, line1.p1.y-line1.p2.y
    𝚫x2 :: Float64,𝚫y2 :: Float64 = line2.p1.x-line2.p2.x, line2.p1.y-line2.p2.y
    M = [𝚫y1 -𝚫x1
         𝚫y2 -𝚫x2]
    B = [line1.p1.x*𝚫y1-line1.p1.y*𝚫x1
         line1.p2.x*𝚫y1-line1.p2.y*𝚫x1
        ]
    if det(M) == 0
        if rang(M) == rang([M B])
            @warn("линии сопадают")
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
    ind = sign((poly.points[i].y-p.y)*(poly.points[i+1].x-poly.points[i].x)-(p.x-poly.points[i].x)*(poly.points[i+1].y-poly.points[i].y))
    for i in 2:N-1
        a = (poly.points[i].y-p.y)*(poly.points[i+1].x-poly.points[i].x)-(p.x-poly.points[i].x)*(poly.points[i+1].y-poly.points[i].y)
        if sign(a) != ind
            return false
        end
    end
    return true
end

function convex(poly :: Polygon{T}) where T
    for i in 1:length(poly.sides)-1
        ang = angle(poly.sides[i],poly.sides[i+1])
        #println(ang)
        if ang>=pi
            return false
        end
    end
    #println(angle(poly.sides[end],poly.sides[begin]))
    return angle(poly.sides[end],poly.sides[begin])<=pi
end

function Jarvis(points :: AbstractVector{Vector2D{T}}) :: Polygon{T} where T<:Real
    pivot :: Vector2D = points[1];
    for point in points
        if point.x>pivot.x && point.y<pivot.y
            pivot = point
        end
    end
    polygon = Polygon{Real}([])
    
    return polygon
end
#points = [Vector2D{Real}(1,3),Vector2D{Real}(3,2),Vector2D{Real}(-1,-1)]
#points = [Vector2D{Real}(1,1),Vector2D{Real}(6,6),Vector2D{Real}(6,1), Vector2D{Real}(5,4)]
#arr = [Vector2D{Real}(rand(2)...) for i in 1:20]
#for point in arr
#display(point)
#end