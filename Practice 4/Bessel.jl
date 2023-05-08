include("..//Practice 2/fastpow.jl")
#using Plots

function bessel(x :: Real , α :: Int)
    x = BigFloat(x)
    S :: BigFloat = a :: BigFloat = fastpow(x/2,α) / factorial(α)
    dif :: BigFloat = x*x/4
    m :: Int = 1
    while a + S != S
        a = -a*dif/(m*m+α*m)
        m+=1
        S+=a
    end
    return S
end
function integralbessel(x :: Real, a :: Int)
    interval = range(0,pi,1000)
    S = 0
    for i in 1:length(interval)-1
        delta = interval[i+1]-interval[i]
        eps = (interval[i+1]+interval[i])/2
        S+= cos(a*eps- x*sin(eps))*delta
    end
    return S/pi
end

"""
function build(border :: Int)
    x = range(0,border, length = 1000)
    ys = []
    for i in 0:2
        list = []
        for j in x
            push!(list, bessel(BigFloat(j),i))
        end
        push!(ys,list)
    end
    label = ["0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10"]
    plot(x,ys, label = label)
end
"""