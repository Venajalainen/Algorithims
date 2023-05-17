import Base: +,-,*,cos,sin,angle,sign
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


struct Segment2D{T <: Real}
    p1 :: Vector2D{T}
    p2 :: Vector2D{T}
    Segment2D{T}(p1 :: NTuple{2,T}, p2 :: NTuple{2,T}) where T = new{T}(Vector2D(p1...),Vector2D(p2...))
    Segment2D{T}(p1 :: Vector2D{T}, p2 :: Vector2D{T}) where T = new{T}(p1,p2)
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
    sides :: Vector{Segment2D{T}}
    function Polygon{T}(points :: AbstractVector{Vector2D{T}}) where T<:Real
        sides = Vector{Segment2D{T}}([])
        for i in 1:length(points)-1
            push!(sides,Segment2D{T}(points[i],points[i+1]))
        end
        push!(sides,Segment2D{T}(points[end],points[begin]))
        return new{T}(sides)
    end
end

function insidepolygon(p :: Vector2D{T}, poly :: Polygon{T}) where T<:Real
    sum_angle :: T = zero(T)
    @assert length(poly.sides)>2
    for side in poly.sides
        a = angle(side.p2-p,side.p1-p)
        (p == side.p2 || p == side.p1) && return true
        if a<0 a+=pi end
        sum_angle+=a
    end
    return sum_angle>=pi
end

function ispuff(poly :: Polygon{T}) where T
    puff :: Bool = true
    for i in 1:length(poly.sides)
        c :: Int = 0
        for j in i+1:length(poly.sides)
            if intersection(poly.sides[i],poly.sides[j]) !== nothing
                c+=1
            end
        end
        if c>2
            return false
        end
    end
    return puff
end
#points = [Vector2D{Real}(1,3),Vector2D{Real}(3,2),Vector2D{Real}(-1,-1)]
#points = [Vector2D{Real}(1,1),Vector2D{Real}(6,6),Vector2D{Real}(6,1), Vector2D{Real}(5,4)]