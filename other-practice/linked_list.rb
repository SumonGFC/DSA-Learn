# Implementation of a linked list
class LinkedList
  def initialize(val = nil)
    @head = val.nil? ? Node.new : Node.new(val)
    @tail = @head
    @size = 1
  end

  def append(val)
    return @head.value = val if @head.value.nil?

    node = Node.new(val)
    @tail.next_node = node
    @tail = node
    @size += 1
  end

  def prepend(val)
    @head = Node.new(val, @head)
    @size += 1
  end

  def size
    @size
  end

  def head
    @head.value
  end

  def tail
    @tail.value
  end

  def at(index)
    if index >= @size || index <= 0
      puts 'Index out of bounds of Linked List entries'
      return nil
    end
    tmp = @head
    index.times { tmp = tmp.next_node }
    tmp.value
  end

  def pop
    node = @head
    return node if node.next_node.nil?

    node = node.next_node until node.next_node.next_node.nil?
    node.next_node = nil
    @tail = node
  end

  def contains?(val)
    node = @head
    node = node.next_node until node.value == val || node.next_node.nil?
    return true if node.value == val

    false
  end

  def find(val)
    node = @head
    i = 0
    until node.value == val || node.next_node.nil?
      node = node.next_node
      i += 1
    end
    return i if node.value == val

    nil
  end

  def to_s
    node = @head
    until node.next_node.nil?
      puts node.value
      node = node.next_node
    end
    puts node.value
  end

  # Node class represents each node in out Linked List
  class Node
    attr_accessor :value, :next_node

    def initialize(val = nil, ptr = nil)
      @value = val
      @next_node = ptr
    end
  end
end


# Testing

p test_vals = 10.times.map { rand(0..20) }
sll = LinkedList.new
10.times { |i| sll.append(test_vals[i]) }
sll.to_s

puts "at: #{sll.at(9)}"
puts "tail: #{sll.tail}"
p sll.pop
p sll.pop
p sll.contains?(sll.head)
p sll.find(sll.tail)
