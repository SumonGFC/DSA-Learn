# This exercise is designed to help familiarize the reader with choosing the
# right data structure for the right problem. If implemented, the parts of this
# exercise should be done by making use of an implementation of the relevant
# interface (Stack, Queue, Deque, USet, or SSet). Solve the following problems
# by reading a text file one line at a time and performing operations on each
# line in the appropriate data structure(s). Your implementations should be
# fast enough that even files containing a million lines can be processed in a
# few seconds.

require 'benchmark'
require_relative '../basic_data_structures.rb'

include DataStructures

big_file = File.open("input.txt")
small_file = File.open("small_input.txt")

test_file = big_file.readlines()

# 1. Read the input one line at a time and then write the lines out in reverse
# order, so that the last input line is printed first, then the second last
# input line, and so on.

def _part_1(file)
  stack = LIFOQueue.new(file.length)
  file.readlines().each { |line| stack.add(line) }
  stack.size.times { puts stack.remove }
end

# time = Benchmark.measure do 
#   _part_1(big_file)
# end
# puts time.real


# Part 2: Read the first 50 lines of input and then write them out in reverse
# order. Repeat this for every line in the file. Your code should never have to
# store more than 50 lines at any given time.


def _part_2(file_lines, buffer_size)
  time = Benchmark.measure do
    stack = LIFOQueue.new(buffer_size)
    while file_lines.length > 0
      buffer_size.times do
        tmp = file_lines.shift
        stack.add(tmp) if (!tmp.nil?)
      end
      stack.size.times { puts stack.remove }
    end
  end
  puts time.real
end

# _part_2(test_file, 13)



# Read the input one line at a time. At any point after reading the
# first 42 lines, if some line is blank (i.e., a string of length 0), then
# output the line that occured 42 lines prior to that one. For example,
# if Line 242 is blank, then your program should output line 200.
# This program should be implemented so that it never stores more
# than 43 lines of the input at any given time.

def _part_3(file_lines, buffer_size)
  time = Benchmark.measure do
    queue = FIFOQueue.new(buffer_size)
    file_lines.each do |line|
      if queue.add(line).nil?
        tmp = queue.remove()
        queue.add(line)
      end
      puts "Queue tail: #{tmp}" if queue.peak == "\n"
    end
  end
  puts time.real
end

# Part 4: Read the input one line at a time and write each line to the output
# if it is not a duplicate of some previous input line. Take special care so
# that a file with a lot of duplicate lines does not use more memory than what
# is required for the number of unique lines.

def _part_4(file_lines)
  dict = {}
  file_lines.each do |line|
    if dict[line].nil?
      puts line
      dict.store(line, "$") 
    end
  end
end

# Part 5 is basically the same as part 4 so I'm not gonna do it cuz i don't
# wanna

# Part 6: Read the entire input one line at a time. Then output all lines
# sorted by length, with the shortest lines first. In the case where two lines
# have the same length, resolve their order using the usual “sorted order.”
# Duplicate lines should be printed only once.

def _part_6(file_lines)

end





small_file.close()
big_file.close()

#def count_dups(file_lines)
#  x = 0
#  file_lines.each do |line|
#    if line.include?("dup")
#      x = x + 1
#    end
#  end
#  puts x
#end
