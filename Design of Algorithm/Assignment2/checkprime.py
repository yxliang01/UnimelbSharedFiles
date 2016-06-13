import math


def is_prime(n):
    if n % 2 == 0 and n > 2:
        return False
    return all(n % i for i in range(3, int(math.sqrt(n)) + 1, 2))


for i in range(0, 99999 + 1):
    print("{},{}".format(i, int(is_prime(i))))
