import Base: +, -, *, ^, display

include("invmod_.jl")

struct Residue{T,M}
    a :: T
    Residue{T,M}(a) where{T,M} = new{T,M}(mod(a, M))
end

+(r1 :: Residue{T,M}, r2 :: Residue{T,M}) where {T,M} = return rem(r1.a + r2.a, M)
+(r :: Residue{T,M}, a :: T) where {T,M} = return rem(r.a + a, M)

-(r1 :: Residue{T,M}, r2 :: Residue{T,M}) where {T,M} = return rem(M + r1.a-r2.a, M)
-(r :: Residue{T,M}, a :: T) where {T,M} = return rem(M + r.a-a, M)

-(r :: Residue{T,M}) where {T,M} = M - r.a

*(r1 :: Residue{T,M}, r2 :: Residue{T,M}) where {T,M} = rem(r1.a*r2.a,M)
*(r :: Residue{T,M}, a :: T) where {T,M} = rem(r.a*a,M)

^(r1 :: Residue{T,M}, r2 :: Residue{T,M}) where {T,M} = rem(r1.a^r2.a, M)
^(r :: Residue{T,M}, a :: T) where {T,M} = rem(r.a^a, M)

inverse(r :: Residue{T,M}) where {T,M}=if invmod_(r.a, M) !== nothing invmod_(r.a, M) end