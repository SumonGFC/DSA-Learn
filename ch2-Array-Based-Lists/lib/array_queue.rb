# frozen_string_literal: true

# Implements FIFO queue
class ArrayQueue
  attr_reader :arr, :head_ptr, :num

  def initialize
    @arr = Array.new(1)
    @head_ptr = 0
    @num = 0 # number of elements in queue
  end

  def len
    @arr.size
  end

  def head
    @arr[@head_ptr]
  end

  def tail
    @arr[(@head_ptr + @num - 1) % len]
  end

  def add(x)
    resize if @arr.size < @num + 1
    @arr[(@head_ptr + @num) % len] = x
    @num += 1
    true
  end

  def remove
    return nil if @num.zero?

    removed = head
    @head_ptr = (@head_ptr + 1) % len
    @num -= 1
    resize if len >= 3 * @num
    removed
  end

  private

  def resize
    new_arr = Array.new([1, 2 * @num].max)
    len = @arr.size
    @num.times { |i| new_arr[i] = @arr[(@head_ptr + i) % len] }
    @arr = new_arr
    @head_ptr = 0
  end
end

if ARGV.include? 'test'
  big_queue = ArrayQueue.new
  (2**10).times { |i| big_queue.add(i) }
  puts(big_queue.len)

  until big_queue.num == 1
    old = big_queue.len
    big_queue.remove
    if big_queue.num <= old / 3
      puts "old len #{old}"
      puts "new len: #{big_queue.len}"
      puts "num: #{big_queue.num}"
      puts
    end
  end
end
