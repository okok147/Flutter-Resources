def bouncingBall(h,bounce,window): 
    if not 0 < bounce < 1: return -1
    count = 0
    while h > window: 
        count += 1
        h *= bounce
        if h > window: count += 1
    return count or -1 

    print(count)









    "***************************************************"

