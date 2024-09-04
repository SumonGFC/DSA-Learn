# frozen_string_literal: true

# rubocop:disable Metrics/IndentationWidth
# rubocop:disable Metrics/MethodParameterName

# ArrayStack implements the List interface with a fixed size backing array:
# n = num of elements, i = index, x = arbitrary element
# get(i) and set(i, x) are O(1)
# add(i, x) and remove(i) are O(1 + n - i)
# resize() is O(n)
class ArrayStack
        attr_reader :back_array, :num_elmts

        def initialize
                @back_array = Array.new(1)
                @num_elmts = 0
        end

        def get(i)
                # O(1)
                @back_array[i] # returns nil if out-of-bounds...
        end

        def set(i, x)
                # O(1)
                y = @back_array[i]
                @back_array[i] = x
                y # normal assignment returns the newly assigned value
        end

        # append by default, return number of elements
        def add(x, i = @num_elmts + 1)
                # O(n - i + 1)
                return unless in_bounds?(i)

                if @num_elmts.zero?
                        set(0, x)
                else
                        resize if @num_elmts == @back_array.length
                        @back_array.insert(i, x)
                end

                @num_elmts += 1
        end

        def remove(i)
                # O(n - i)
                return unless in_bounds?(i)

                x = @back_array.delete_at(i)
                @num_elmts -= 1
                resize if @back_array.length >= 3 * @num_elmts
                x
        end

        private

        def resize
                # O(n)
                tmp = Array.new(@num_elmts.zero? ? 1 : 2 * @num_elmts)
                @back_array.each_with_index { |x, i| tmp[i] = x }
                @back_array = tmp
        end

        def in_bounds?(i)
                i.between?(-@back_array.size, @back_array.size)
        end

        def to_s
                "num_elmts: #{@num_elmts}; array: " << @back_array.inspect
        end
end

# Exercise 2.1. The List method add_all(i, c) inserts all elements of the
# collection c into the list at position i. (The add(i,x) method is a special
# case where c = {x}.) Explain why, for the data structures in this chapter, it
# is not efficient to implement add all(i, c) by repeated calls to add(i,x).
# Design and implement a more efficient implementation.d

# My immediate thought is, repeated calls to add() will cause repeated calls to
# resize(). If there are enough elements in c to cause m calls to resize(), this
# will incur:
#       sum from 1 to m { (2**m)*n }    // each successive call doubles
#
# instead, if we pre calculate the required amount of space needed for the new
# elements in c, we can achieve O(n) with just one call to resize.

x = ArrayStack.new
puts x
x.add(1)
puts x
x.add(2)
x.add(3)
x.add 69, 1
puts x
