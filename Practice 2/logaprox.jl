function aproxlog( a :: Float64, x :: Float64, ε :: Float64)
    #a^y*z^t=x

    less :: Bool = a<1
    if a<1 a=1.0/a end

    y :: Float64, z :: Float64, t :: Float64 = 0.0, x, 1.0
    
    while z > a || z < 1/a || abs(t)>=ε

        if z>=a
            z/=a
            y+=t
        elseif z<=1.0/a
            z*=a
            y-=t
        else
            z*=z
            t/=2.0
        end

    end

    return (-1)^less*y

end