def revrot(strng, sz):
    if not len(strng) or sz <= 0 or len(strng) < sz:
        return ''

    new_strng = ''
    for strng_list in map(None, *([iter(strng)] * sz)):
        if not None in strng_list:
            new_strng += reverse_or_rotate(''.join(strng_list), sz)

    return new_strng


def reverse_or_rotate(string, limit):
    sum = 0
    for index, value in enumerate(string):
        sum += pow(int(value), 2)

    if sum % 2 == 0:
        return string[::-1]

    return string[1:limit] + string[0]
