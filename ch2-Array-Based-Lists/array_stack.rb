# frozen_string_literal: true

# rubocop:disable Metrics/MethodParameterName

require 'benchmark'

# ArrayStack implements the List interface with a fixed size backing array
class ArrayStack
  attr_reader :back_array, :num_elmts

  def initialize(size = 1)
    @arr = Array.new(size)
    @num_elmts = 0
  end

  # get ith element
  def [](i)
    # O(1)
    @arr[i] # returns nil if out-of-bounds
  end

  # set ith element to x; check bounds; return old element
  def []=(i, x)
    # O(1)
    validate_index(i)
    raise NoMemoryError if @arr.empty?

    y = @arr[i]
    @arr[i] = x
    y # normal assignment returns the newly assigned value
  end

  # append by default, return number of elements
  def insert(x, i = @num_elmts)
    # O(n - i + 1)
    raise IndexError, 'Index out of bounds' unless i.between?(0, @arr.size)

    resize if @num_elmts == @arr.size
    (@arr.size - 1).downto(i) { |j| @arr[j] = @arr[j - 1] }
    @arr[i] = x
    @num_elmts += 1
  end

  # remove element at index i if i is within bounds
  def remove(i)
    # O(n - i)
    validate_index(i)

    x = @arr.delete_at(i)
    @num_elmts -= 1
    resize if @arr.length >= 3 * @num_elmts
    x
  end

  private

  # resize backing array based on number of requested number of chunks
  def resize(chunks = 1)
    # O(n)
    tmp = if caller_locations[0].label.to_sym == :insert_all
            Array.new(@num_elmts.zero? ? 1 : (2**chunks) * @num_elmts)
          else
            Array.new(@num_elmts.zero? ? 1 : 2 * @num_elmts)
          end
    @arr.each_with_index { |x, i| tmp[i] = x }
    @arr = tmp
  end

  def validate_index(i)
    raise IndexError, 'Index out of bounds' unless i.between?(0, @arr.size - 1)
  end

  def to_s
    "num_elmts: #{@num_elmts}; " \
      "len: #{@arr.size}; " \
      "array: #{@arr.inspect};"
  end
end

# Exercise 2.1. The List method insert_all(i, c) inserts all elements of the
# collection c into the list at position i. (The insert(i,x) method is a
# special case where c = {x}.) Explain why, for the data structures in this
# chapter, it is not efficient to implement insert all(i, c) by repeated calls
# to insert(i,x). Design and implement a more efficient implementation.

# My immediate thought is: repeated calls to insert() will cause repeated calls
# to resize(). If there are enough elements in c to cause m calls to resize(),
# this will incur a running time cost of:
#
#       O( sum(i=0..m-1) { (2**i) * n } )    // each successive call doubles
#
# instead, if we pre-calculate the required amount of space needed for the new
# elements in c, we can achieve O(n) with just one call to resize.

=begin
if ARGV[0][0].downcase == 'e' # e for execute
  x = ArrayStack.new
  puts x
  x.insert(1)
  puts x
  x.insert(2)
  puts x
  x.insert(3)
  puts x
  x.insert(4)
  puts x
  x.insert(5)
  puts x
  x.insert(6)
  puts x
end
=end

# literally just a wrapper around Array class. After exploring the source code
# (i.e. array.c), it becomes clear that there really is no "better way" to
# implement an array in Ruby than just using default functionality.
class FastArrayStack
  def initialize
    @ary = []
  end

  def size
    @ary.size
  end

  def [](i)
    @ary[i]
  end

  def []=(i, x)
    @ary[i] = x
  end

  def insert(i, x)
    @ary.insert(i, x)
  end

  def remove(i)
    @ary.remove(i)
  end
end

# Looking at array.c again, you can find the default array size macro,
# ARY_DEFAULT_SIZE, to be 16. Assuming this is the number of elements in a ruby
# array, we can implement a "linked" array. Implements the list interface with
# multiple backing arrays, each of a size (2^n)*16. Each array will contain only
# 15 elements, the 16th being a pointer to the next linked array
# TODO: still have to implement this, although I'm not sure I will (got better
# things to do tbh -- my time is better spent elsewhere).
class LinkedArrayStack
  def initialize
    @ary0 = Array.new(16)
    @size = 16
  end

  def find_ary(i)
    # find n such that (2**n)*16 <= i < (2**(n+1))*16
    # hence n <= log2(i/16) < n + 1
    return 0 if i.between?(0, 15)

    Math.log2(i / 16.0 + 1).floor
  end

  def index(i); end

  def [](i)
    @ary[index(i)]
  end

  def []=(i, x)
    @ary[index(i)] = x
  end

  def insert(i, x); end

  def insert_all(i, x); end

  def remove(i); end

  def resize; end

  def alloc; end
end
