arr = [ [ [ [] ,10 ,8 ] ,[ [], 11, 7 ] ,[[],[],30], 6 ] ,[ [], [], 5 ],[[],[],20], 4 ]
#arr = [[[[],[],6], [], 2], [[[],[],4], [[],[],5], 3],1]
function convert!( arr :: Vector, tree :: Dict{Int,Vector})
    isempty(arr) && return

    list = []

    for subarr in arr[1:end-1]
        if isempty(subarr)
            push!(list,nothing)
            continue
        end
        if typeof(subarr) <: Int
            push!(list,subarr)
            continue
        end
        push!(list,subarr[end])
        convert!(subarr,tree)
    end

    tree[arr[end]] = list

    return tree
end

function convert!( tree :: Dict{Int,Vector}, root :: Union{Int,Nothing}) ::Union{Node,Nothing}

    isnothing(root) && return nothing
    !(root in keys(tree)) && return Node(root,[])
    node = Node(root,[])

    for sub_root in tree[root]
        push!(node.children, convert!(tree, sub_root))
    end

    return node
end

struct Node
    index :: Int
    children :: Vector{Union{Nothing,Node}}
end

#----------------------------------------------------------------------------------------------------------#

tree = Dict{Int,Vector}();
tree = convert!(arr, tree)

display(tree)

node = convert!(tree, 4)
node.index
node.children