

"""
Exercise 1.2. A Dyck word is a sequence of +1’s and -1’s with the property
that the sum of any prefix of the sequence is never negative. For example,
+1,−1,+1,−1 is a Dyck word, but +1,−1,−1,+1 is not a Dyck word since the
prefix +1 − 1 − 1 < 0. Describe any relationship between Dyck words and Stack
push(x) and pop() operations.


Discussion: There is a one-to-one correspondance between every Dyck work and
every possible valid sequence of push/pop operations that may be performed on a
stack. To see this, we can replace every "+1" with push(x), and replace every
"-1" with pop(), and then evaluate/reduce the sequence of operations to resolve
the final representation of the stack. At the end of this process, we will see
that the height of the stack will be a non-negative number. 

Proof: let x1,...,xn be a Dyck word where each xi = "+1" or "-1" (note that by
definition x1 = "+1"). Map each xi to push(x) or pop(). Then the number of
push(x) operations will be greater than or equal to the number of pop()
operations, and hence the height of the stack will be non-negative. Moreover,
the sum of the entire Dyck word is equal to the height of the stack.
"""

# This program should always print "Success"

from random import choice

def generate_random_Dyck(length):
    word = []
    options = [-1, 1]
    running_sum = 0
    for _ in range(length):
        if running_sum == 0:
            word.append(1)
        else:
            word.append(choice(options))
        running_sum += word[-1]
    # print(sum(word))
    return word

def test_stack(dyck_word):
    stack = []
    for word in dyck_word:
        if word == 1:
            stack.append("x")
        else:
            stack.pop()
    return len(stack) == sum(dyck_word)

def test(num_tests=0):
    word_lens = [10, 100, 1000, 10000]
    for _ in range(num_tests):
        if not test_stack(generate_random_Dyck(choice(word_lens))):
            print("Failure")
            return
    print("Success")
    #return

test(100)
