using DataStructures

function dfs(graph :: Dict{T,Vector{T}}, start :: T) where T<:Integer
    stack = [start]
    visited = falses(length(graph))
    visited[start] = true
    while !isempty(stack)
        v = pop!(stack)
        for v′ in graph[v]
            !visited[v′] && begin push!(stack,v′); visited[v′] = true end
        end
    end
    return visited
end

function bfs(graph :: Dict{T,Vector{T}}, start :: T) where T<:Integer
    queue = Queue{T}()
    enqueue!(queue, start)
    visited = falses(length(graph))
    visited[start] = true
    while !isempty(queue)
        v = dequeue!(queue)
        for v′ in graph[v]
            !visited[v′] && begin enqueue!(queue, v′); visited[v′] = true end
        end
    end
    return visited
end

# связный ли граф?
function connected(graph :: Dict{T, Vector{T}}) where T<:Integer
    visited = bfs(graph,1)
    for v in visited
        !v && return false
    end
    return true
end
# сколько компонент связности?
function components(graph :: Dict{T, Vector{T}}) where T<:Integer
    i :: Union{Int, Nothing} = 1
    count :: Int = 0
    visited :: Vector{Bool} = falses(length(graph))
    while !isnothing(i)
        count+=1
        _visited = bfs(graph, i)
        visited.= visited.||_visited
        i = findfirst(visited) do x
            return iszero(x)
        end
    end
    return count
end
# является ли граф двудольным?
function dual(graph :: Dict{T, Vector{T}}) where T
    start :: Int = 1
    mark = 1
    paint = zeros(Int,length(graph))
    queue = Queue{T}()
    enqueue!(queue, start)
    paint[start] = mark
    while !isempty(queue)
        v = dequeue!(queue)
        mark = max(mod(mark+1,3),1)
        for v′ in graph[v]
            if iszero(paint[v′])
                enqueue!(queue, v′)
                paint[v′] = mark 
            else
                paint[v'] != mark && return false
            end
        end
    end
    return true
end

# testree = Dict{Int,Vector{Int}}()
# testree[1] = [2,3]
# testree[2] = [4]
# testree[4] = [2]
# testree[3] = []

# testree = Dict{Int,Vector{Int}}()
# testree[1] = [2,3]
# testree[2] = [1,3]
# testree[3] = [1,2]
# testree[4] = [5,7]
# testree[5] = [4,6]
# testree[6] = [5,7]
# testree[7] = [4,6]