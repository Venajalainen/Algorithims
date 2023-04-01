function isprime( x :: Integer )

    for i in 2:trunc(Int,sqrt(x))+1
        rem(x,i)==0 && return false
    end

    return true

end