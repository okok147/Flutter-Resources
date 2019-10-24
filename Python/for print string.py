input = raw_input('Please input your choice:')
current_index = 0
for i in input:
  if input == "cool":
    print "it is cool!"

  else:
    input = raw_input('Try to type cool maybe?')
    if input == 'cool':
      for i in input:
        print 'it is cool'
    else:
      print 'okay after %s times,finally we have to print :' % (len(input) + current_index), input
      current_index += 1
    print input
