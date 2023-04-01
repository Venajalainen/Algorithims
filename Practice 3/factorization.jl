function factorization( x :: Int) :: Vector{Int}
    divisors :: Set{Int} = Set([1,x])

    for i in 2:trunc(Int,sqrt(x))+1
        if rem(x,i) == 0
            push!(divisors,i)
            push!(divisors,div(x,i))
        end
    end

    return sort([divisors...])

end