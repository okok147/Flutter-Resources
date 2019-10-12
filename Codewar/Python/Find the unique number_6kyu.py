def find_uniq(arr):
    arr.sort()
    if(arr[0] < arr[len(arr)-1] and arr[0] < arr[len(arr)-2]):
        n = arr[0]
    else:
        n = arr[len(arr)-1]
    return n 



'*******************'

     # For example: arr[0,0,1] 
     # if 0 < 1 (To determine it is different) and 0 < 0 (2nd ): 
     #  return 0
     # else:
     #  return 1 (arr[len(arr)-1])



'*******************'

# Therefore my version:

def find_uniq(arr):
    arr.sort()
    if(arr[0] < arr[len(arr)-1] and arr[0] < arr[len(arr)-2]):
        return arr[0]
    else:
        return arr[len(arr)-1]

# As n is not necessary,but it would be nice for large database
        
#Clever version: 

def find_uniq(arr):
    a, b = set(arr)
    return a if arr.count(a) == 1 else b

# https://www.codewars.com/kata/find-the-unique-number-1/train/python

     


    
    
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                              
                           

  