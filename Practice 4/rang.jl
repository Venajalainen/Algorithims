include("to_step.jl")

function rang(_M :: AbstractMatrix{T}) where T
    M = to_step(_M);
    i :: Int, j :: Int = 1, 1
    rangM :: Int = 0
    while i<=size(M,1) && j<=size(M,2)
        if !iszero(M[i,j])
            rangM+=1;
            j+=1;
        end
        i+=1;
    end
    return rangM;
end