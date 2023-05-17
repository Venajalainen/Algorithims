function _CombSort(arr :: AbstractArray{T}) where T
    step :: Int = length(arr)-1
    swaps :: Bool = true
    while step>1 || swaps
        i :: Int = 1
        swaps = false
        while i+step<=length(arr)
            @inbounds if arr[i+step]<arr[i]
                @inbounds arr[i], arr[i+step] = arr[i+step], arr[i]
                swaps = true
            end
            i+=1
        end
        if step>1
            step=floor(Int,step/1.24733)
        end
    end
    return arr
end

function bubbleSort(list)
	len = length(list)
	for i = 1:len-1
		for j = 2:len
			if list[j-1] > list[j]
				tmp = list[j-1]
				list[j-1] = list[j]
				list[j] = tmp
			end
		end
	end
    return list
end