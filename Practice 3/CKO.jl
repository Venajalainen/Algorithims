function CKO(arr :: Vector{T}) where T
    sqb :: T, b :: T = zero(T), zero(T)
    n :: Int = length(arr)
    for i in eachindex(arr)
        sqb += arr[i]^2
        b += arr[i]
    end
    return sqrt((n*sqb -b^2) / (n^2))
end