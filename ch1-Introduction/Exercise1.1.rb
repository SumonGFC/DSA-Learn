# This exercise is designed to help familiarize the reader with choosing the
# right data structure for the right problem. If implemented, the parts of this
# exercise should be done by making use of an implementation of the relevant
# interface (Stack, Queue, Deque, USet, or SSet) provided by the . Solve the
# following problems by reading a text file one line at a time and performing
# operations on each line in the appropriate data structure(s). Your
# implementations should be fast enough that even files containing a million
# lines can be processed in a few seconds.

require "../basic_data_structures.rb"

include DataStructures

big_file = File.open("one_mil.txt")
small_file = File.open("one_hundred.txt")
# 1. Read the input one line at a time and then write the lines out in reverse
# order, so that the last input line is printed first, then the second last input
# line, and so on.


