# frozen_string_literal: true

# Singly Linked List. Implements FIFO+LIFO interface with:
#   - push(x), pop(), add(x) and remove() in O(1) time
#   - get(i) and set(i, x) in O(n) worst case
class SLL
  attr_reader :n

  def initialize
    @n = 0
    @head = nil
    @tail = nil
  end

  def push(obj)
    node = Node.new(obj)
    node.next = @head
    @head = node
    @tail = @head if n.zero?
    @n += 1
  end

  # Helpers
  def head
    @head.data
  end

  def tail
    @tail.data
  end

  def to_s
    node = @head
    str = "N: #{n}\nHead: #{head}\nTail: #{tail}\nList: "
    until node.nil?
      str += "(#{node.data}) -> "
      node = node.next
    end
    str += 'nil'
    str
  end

  # List Nodes
  class Node
    attr_accessor :data, :next

    def initialize(data = nil, next_node = nil)
      @data = data
      @next = next_node
    end

    def nil?
      @data.nil?
    end
  end
end

if ARGV.include? 'test'
  sll = SLL.new
  10.times { |i| sll.push((i + 97).chr) }
  puts sll
end
