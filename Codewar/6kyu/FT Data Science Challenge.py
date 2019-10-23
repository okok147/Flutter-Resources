# BMI
# question 1
height = input("Height(cm):")
weight = input("Weight(kg):")

BMI = (float(weight)*10000) / ((float(height) * (float(height))))

if BMI < 18.5:
    category = "underweight"

elif BMI > 18.5 and BMI < 25:
    category = 'normal'

elif BMI > 25 and BMI < 30:
    category = 'overweight'
else:
    category = 'obese'

print("Your BMI category:", category)

# question 2

people = [(170, 55), (150, 70), (160, 40), (123, 33)]
for i, x in enumerate(people):
    currentTuple = str(x)
    currentWeight = currentTuple[6:8]
    currentHeight = currentTuple[1:4]
    current = int(float(currentWeight) * 10000 /
                  (float(currentHeight) * float(currentHeight)))
    if current < 18.5:
        currentCategory = "underweight"

    elif current > 18.5 and current < 25:
        currentCategory = 'normal'

    elif current > 25 and current < 30:
        currentCategory = 'overweight'

    else:
        currentCategory = 'obese'

    print('Person ' + str(i) + ' BMI is : ' +
          str(current) + ' and he/she is ' + currentCategory)

    # Sequencing

    # Question 1

# 1. Import the text.csv file
path = "text.csv"

file = open(path)
# 2. Complete function counter. The function should return the number of times the substring appears & their index


def counter(substring):
    timesOccur = 0
    for line in file:
        number = line.count(substring)
        timesOccur += number
        indexOfSub = line.find(substring)
        print(indexOfSub)
    print('Substring Occur:' + str(timesOccur))


# do not edit the code below
counter("TCA")
