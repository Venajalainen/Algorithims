function gcd_( a :: Type , b :: Type ) where Type

    while !iszero(b)

        a, b = b , rem(a,b)

    end

    return abs(a)

end