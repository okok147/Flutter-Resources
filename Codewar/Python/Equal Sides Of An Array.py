#Equal Sides Of An Array

def find_even_index(arr):
    for i, x in enumerate(arr): 
        if sum(arr[0:i]) == sum(arr[i+1]): 
            return i 
        return -1 


find_even_index([1,2,3,4,3,2,1])




'*********************************'

def find_even_index(arr):
    for i in range(len(arr)):
        if sum(arr[:i]) == sum(arr[i+1:]):
            return i
    return -1



'*********************************'


