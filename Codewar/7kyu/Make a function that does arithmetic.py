#My version:

def arithmetic(a, b, operator):
    #your code here
    if operator == "add":
        return a + b
    if operator == "subtract":
        return a - b
    if operator == "multiply":
        return a * b
    else:
        return a / b

#Clever Version: 

def arithmetic(a, b, operator):
    return {
        'add': a + b,
        'subtract': a - b,
        'multiply': a * b,
        'divide': a / b,
    }[operator]