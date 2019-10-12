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

def bouncingBall(start, p, height):
    '''
    start, height: positive int or float;
    p, postive ratio(0~ 1)
    '''
    if  p == 1:
        return -1

    curr_height = start
    times = 0
    while curr_height > height:
        if p*curr_height > height:
            times += 2
            curr_height *= p
        else:
            times += 1
            curr_height *= p
    return times


print [30 * (0.66)**i for i in range(10)]
print bouncingBall(3, 0.66, 1.5)

print bouncingBall(30, 0.66, 1.5)

print 30 * (0.66)**8