import Base: +, -, *, ^, display, zero, one, mod

include("invmod_.jl")
include("Polynom.jl")

struct Residue{T,M}
    a :: T
    Residue{T,M}(a :: Any) where {T,M} = new{T,M}(mod(T(a), M))
end

+(r1 :: Residue{T,M}, r2 :: Residue{T,M}) where {T,M} = Residue{T,M}(r1.a + r2.a)
+(r :: Residue{T,M}, a :: T) where {T,M} = Residue{T,M}(r.a + a)

-(r1 :: Residue{T,M}, r2 :: Residue{T,M}) where {T,M} = Residue{T,M}(r1.a-r2.a)
-(r :: Residue{T,M}, a :: T) where {T,M} = Residue{T,M}(r.a-a)

-(r :: Residue{T,M}) where {T,M} = Residue{T,M}(M - r.a)

*(r1 :: Residue{T,M}, r2 :: Residue{T,M}) where {T,M} = Residue{T,M}(r1.a*r2.a)
*(r :: Residue{T,M}, a :: T) where {T,M} = Residue{T,M}(r.a*a)

^(r1 :: Residue{T,M}, r2 :: Residue{T,M}) where {T,M} = Residue{T,M}(r1.a^r2.a)
^(r :: Residue{T,M}, a :: T) where {T,M} = Residue{T,M}(r.a^a)

inverse(r :: Residue{T,M}) where {T,M}=if invmod_(r.a, M) !== nothing Residue{T,M}(invmod_(r.a, M)) else zero(Residue) end
display( r :: Residue{T,M}) where {T,M} = display(r.a)

mod( r :: Residue{T,M}, a :: T) where {T,M} = Residue{T,M}(mod(r.a,a))

one(::Type{Residue{T,M}}) where {T,M} = Residue{T,M}(one(T))
zero(::Type{Residue{T,M}}) where {T,M} = Residue{T,M}(zero(T))