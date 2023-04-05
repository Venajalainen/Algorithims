function silt( x :: Integer ) :: Vector{Integer}

    prime_numbers = trues(x)

    for i in 2:x
        if prime_numbers[i]
            j = i*i
            while j <= x
                prime_numbers[j] && (prime_numbers[j] = false)
                j+=i
            end
        end
    end

    return [i for i in 2:x if prime_numbers[i]]

end