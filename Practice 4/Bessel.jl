include("..//Practice 2/fastpow.jl")
using Plots

function bessel(x :: Real , α :: Int)
    x = BigFloat(x)
    S :: BigFloat = a :: BigFloat = fastpow(x/2,α) / factorial(α)
    dif :: BigFloat = x*x/4
    m :: Int = 1
    while a + S != S
        a = (-1)*a*dif/(m*m+α*m)
        m+=1
        S+=a
    end
    return S
end

function build(border :: Int)
    x = range(0,border, length = 1000)
    ys = []
    for i in 0:10
        list = []
        for j in x
            push!(list, bessel(BigFloat(j),i))
        end
        push!(ys,list)
    end
    label = ["0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10"]
    plot(x,ys, label = label)
end