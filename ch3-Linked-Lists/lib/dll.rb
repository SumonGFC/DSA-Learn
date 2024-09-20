# frozen_string_literal: true

# rubocop:disable Metrics/MethodParameterName

# Doubly Linked List
class DLL
  attr_reader :len, :dummy

  # initialize dummy node that links head and tail
  def initialize
    @len = 0
    @dummy = Node.new
    @dummy.next = @dummy
    @dummy.prev = @dummy
  end

  def get(i)
    raise IndexError unless i.between?(0, len - 1)

    get_node(i).data
  end

  def set(i, val)
    raise IndexError unless i.between?(0, len - 1)

    get_node(i).data = val
  end

  def add(i, node_data)
    if i == -1
      add_before(@dummy, node_data)
    else
      add_before(get_node(i), node_data)
    end
  end

  def remove_at(i)
    remove_node(get_node(i))
  end

  # O(n/2) = O(1 + min(i, n-i))
  def get_node(i)
    if i < len / 2
      node = @dummy.next
      i.times { node = node.next }
    else
      node = @dummy.prev
      (len - i).times { node = node.prev }
    end
    node
  end

  private

  def add_before(list_node, new_node_data)
    new_node = Node.new(new_node_data)
    new_node.prev = list_node.prev
    new_node.next = list_node
    new_node.next.prev = new_node
    new_node.prev.next = new_node
    @len += 1
    new_node
  end

  def remove_node(node)
    node.prev.next = node.next
    node.next.prev = node.prev
    @len = [@len - 1, 0].max
  end

  def to_s
    node = @dummy
    str = ''
    until node.next.data.nil?
      str += "(#{node.data}) -> "
      node = node.next
    end
    str += "(#{node.data})"
  end

  # DLL Node
  class Node
    attr_accessor :data, :prev, :next

    def initialize(data = nil, prev: nil, next_node: nil)
      @data = data
      @prev = prev
      @next = next_node
    end
  end
end

# rubocop:enable Metrics/MethodParameterName

x = DLL.new
10.times { |i| x.add(-1, i) }
puts x
12.times { x.remove_at(7); puts x }
puts x
