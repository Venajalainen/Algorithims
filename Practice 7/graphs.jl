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
end