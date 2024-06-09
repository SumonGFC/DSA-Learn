# frozen_string_literal: true

# Node object represents BST node
class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    return nil if self.class != other.class

    if block_given?
      block_result = yield(@data, other.data)
      return block_result if [-1, 0, 1].include?(block_result)

      raise 'Invalid block given to <=>. Return value should be in [-1, 0, 1]'
    end

    @data <=> other.data
  end
end

# Tree class represents our (balanced) Binary Seach Tree
class Tree
  attr_reader :root, :arr

  def initialize(arr)
    @arr = arr.sort.uniq
    @root = build_tree(@arr)
  end

  def build_tree(arr)
    return nil if arr.empty?

    mid = arr.length / 2
    Node.new(arr[mid], build_tree(arr[0...mid]), build_tree(arr[(mid + 1)..]))
  end

  def insert(node, start = @root)
    return start.left = node if start.left.nil? && node < start
    return start.right = node if start.right.nil? && node > start

    if node < start
      insert(node, start.left)
    elsif node == start
      nil
    else
      insert(node, start.right)
    end
  end

  def delete(node, root = @root)
    return root if root.nil?

    # If we find the node
    if node == root.data
      # handle leaf cases
      return root.left if root.right.nil?
      return root.right if root.left.nil?

      # handle nodes with 2 children
      next_largest = root.right
      next_largest = next_largest.left until next_largest.left.nil?
      root.data = next_largest.data
      delete(next_largest.data, root.right)
    elsif node < root.data
      root.left = delete(node, root.left)
    else
      root.right = delete(node, root.right)
    end

    root
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left
  end
end



arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
bst = Tree.new(arr)
bst.build_tree(bst.arr)
# p bst.root
new_node = Node.new(10)
new_node2 = Node.new(8.5)
bst.insert(new_node, bst.root)
bst.insert(new_node2, bst.root)

bst.pretty_print

bst.delete(5)
bst.pretty_print
