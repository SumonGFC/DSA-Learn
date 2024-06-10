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

  def find(node_val, root = @root)
    if node_val.nil?
      puts 'BST does not support nil value nodes'
      return nil
    elsif root.nil?
      puts "Could not find #{node_val} in BST"
      return nil
    end

    return root if node_val == root.data

    if node_val < root.data
      find(node_val, root.left)
    else
      find(node_val, root.right)
    end
  end

  def level_order(root = @root, queue = [root])
    until queue.empty?
      head = queue.shift
      block_given? ? yield(head) : puts(head.data)
      queue.push(head.left) unless head.left.nil?
      queue.push(head.right) unless head.right.nil?
    end
  end

  def preorder(node = @root)
    return if node.nil?

    block_given? ? yield(node) : puts(node.data)
    preorder(node.left)
    preorder(node.right)
  end

  def inorder(node = @root)
    return if node.nil?

    preorder(node.left)
    block_given? ? yield(node) : puts(node.data)
    preorder(node.right)
  end

  def postorder(node = @root)
    return if node.nil?

    preorder(node.left)
    preorder(node.right)
    block_given? ? yield(node) : puts(node.data)
  end

  def height(node = @root)
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  def depth(node)
    ctr = 0
    tmp = @root
    until node == tmp
      ctr += 1
      tmp = node < tmp ? tmp.left : tmp.right
    end
    ctr
  end

  def balanced?

  end

  def rebalance
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
bst.pretty_print
puts "height: #{bst.height}"
puts "depth: #{bst.depth(bst.find(5))}"
