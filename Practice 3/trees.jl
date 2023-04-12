import Base: display

struct ArrayTree
    n :: Int
    size :: Int
    #arr :: Vector

    ArrayTree(n :: Int) = new(n,0,[])
    function ArrayTree(n :: Int, x :: Vector) 
        size = length(x)
        n = n
        function recursive(n :: Int, x :: Vector)
            println(x)
            if length(x) > n
                return [[recursive(n,x[i*n : i*(n+1)]) for i in 1:n-1],x[1]]
            else
                return [x]
            end
        end

        arr = recursive(n,x)
    end

    #display(tree :: ArrayTree )  = display(tree.arr)
    
end

ArrayTree(2,[3,4,5,6])
# 1 2 3 4
# 3 4 5 6

# 1 2 3 4 5 6 7 8
# 3 5 6 7 8 9 9 9
# Binary Tree