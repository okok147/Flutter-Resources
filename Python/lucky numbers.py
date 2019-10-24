from random import randint

# Generates a number from 1 through 10 inclusive
random_number = randint(1, 10)
print "Answers:", random_number

guesses_left = 3
# Start your game!

while guesses_left > 0:
  guess = int(raw_input('Your guess: '))
  if guess == random_number:
    print "You win!"
    break
  guesses_left -= 1
  print 'You have :', guesses_left, 'times left'
else:
  print "You lose."

#print("\n") means to print a blank line.
