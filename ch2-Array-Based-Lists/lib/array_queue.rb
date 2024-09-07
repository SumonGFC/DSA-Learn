# frozen_string_literal: true

# Implements FIFO queue
class ArrayQueue
  attr_reader :arr, :head, :num

  def initialize
    @arr = Array.new(1)
    @head = 0
    @num = 0
  end

  def add(x)
    # resize if @arr.size < @num_elmts + 1

  end

  def resize; end
end

if ARGV.include? 'test'
end
