# frozen_string_literal: true

# rubocop:disable Metrics/MethodParameterName

# The idea with this structure is to get a double-ended queue, with insert and
# delete operations (not just at the ends) by checking how close the
# inserted/deleted element is to the middle of the queue. If it's closer to the
# head, only need to shift the elements in the "left half" of the array, else
# only need to shift in the "right-half". This gets us the List interface with
# O(n/2) time on insert/remove. Space efficiency is basically the same. The
# O(n/2) time does not take into account calls to resize() OR computation of
# the index modulus, which on some machines (and given a sufficiently large
# number of elements), can be inefficient (I see n^2 on some google searches).

# Implements List interface
class ArrayDeque
  def initialize
    @arr = Array.new(1)
    @head_ptr = 0
    @num = 0 # number of elements in the queue
  end

  def head
    @arr[@head_ptr]
  end

  def tail
    @arr[@head_ptr + @num % size]
  end

  def size
    @arr.size
  end

  def get(i)
    @arr[(@head_ptr + i) % size]
  end

  def set(i, x)
    return if @num.zero?

    removed = @arr[(@head_ptr + i) % size]
    @arr[(@head_ptr + i) % size] = x
    removed
  end

  def add(i = @head_ptr, x)
    return unless i.between?(0, size - 1)

    resize if @num == size
    # i near the head of the queue
    if i < @num / 2
      # shift head ptr then shift elements
      @head_ptr = (@head_ptr - 1) % size
      0.upto(i - 1) do |k|
        @arr[(@head_ptr + k) % size] = @arr[(@head_ptr + k + 1) % size]
      end
    # i near the tail of the queue
    else
      # no need to shift head here
      @num.downto(i + 1) do |k|
        @arr[(@head_ptr + k) % size] = @arr[(@head_ptr + k - 1) % size]
      end
    end
    @arr[(@head_ptr + i) % size] = x
    @num += 1
  end

  def remove(i)
    return unless i.between?(0, size - 1)

    removed = @arr[(@head_ptr + i) % size]
    if i < @num / 2
      i.downto(1) do |k|
        @arr[(@head_ptr + k) % size] = @arr[(@head_ptr + k - 1) % size]
      end
    else
      i.upto(@num - 2) do |k|
        @arr[(@head_ptr + k) % size] = @arr[(@head_ptr + k + 1) % size]
      end
    end
    @num -= 1
    resize if size >= 3 * @num
    removed
  end

  def in_order
    @arr.rotate(@head_ptr)
  end

  private

  def resize
    new_arr = Array.new([1, 2 * @num].max)
    len = @arr.size
    @num.times { |i| new_arr[i] = @arr[(@head_ptr + i) % len] }
    @arr = new_arr
    @head_ptr = 0
  end

  def to_s
    "array (unordered): #{@arr}" \
      "array (ordered): #{@arr.rotate(@head)}"
  end
end
