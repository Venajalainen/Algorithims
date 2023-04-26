include("to_step.jl")

function rang(M :: AbstractMatrix{T}) where T
    to_step!(M);
    i :: Int, j :: Int = 1, 1
    rangM :: Int = 0
    while i<size(M,2) && j<size(M,1)
        if !iszero(M[i,j])
            rangM+=1;
            j+=1;
        end
        i+=1;
    end
    return rangM;
end