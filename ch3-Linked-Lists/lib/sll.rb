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
    removed = @head&.data
    @head = @head&.next
    @len = [@len - 1, 0].max
    @tail = nil if @len.zero?
    removed
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
  def get(index)
  end

  def set(index, obj)
  end

  def contains?(obj)
  end

  def find(obj)
  end

  # HELPERS
  def head_ptr
    @head
  end

  def tail_ptr
    @tail
  end

  def head
    @head&.data
  end

  def tail
    @tail&.data
  end

  def to_a
    arr = []
    node = @head
    until node.nil?
      arr << node.data
      node = node.next
    end
    arr
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
