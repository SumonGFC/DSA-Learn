# frozen_string_literal: true

# Singly Linked List. Implements FIFO+LIFO interface with:
#   - push(x), pop(), add(x) and remove() in O(1) time
#   - get(i) and set(i, x) in O(n) worst case
class SLL
  attr_reader :len

  def initialize
    @len = 0
    @head = nil
    @tail = nil
  end

  # MAIN OPERATIONS

  # Push: Add obj to head of list
  def add_first(obj)
    node = Node.new(obj)
    node.next = @head
    @head = node
    @tail = @head if len.zero?
    @len += 1
  end

  # Pop: Remove obj from head of list
  def remove_first
  end

  # Enqueue: Add obj to tail of list
  def add_last(obj)
  end

  # Remove tail of list; In the book, the remove op just calls pop(). However,
  # we might as well implement the full Deque interface (add first/last, remove
  # first/last)
  def remove_last
  end

  # EXTENSIONS
  def at(index)
  end

  def contains?(obj)
  end

  def find(obj)
  end

  # HELPERS
  def head
    @head&.data
  end

  def tail
    @tail&.data
  end

  def to_s
    node = @head
    str = "N: #{len}\nHead: #{head}\nTail: #{tail}\nList: "
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
