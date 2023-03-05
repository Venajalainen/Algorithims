function aproxf( f :: Function, a :: T, b :: T, ε :: T) where T <: Float64
    @assert a<b
    @assert f(a)*f(b)<0

    while b-a > ε

        t :: T = (a+b)/2

        if f(t)==0
            return t
        end

        if f(t)*f(a)<0
            b = t
        else
            a = t
        end

    end

    return (a + b)/2

end