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
    p @arr
    @root = build_tree(@arr)
  end

  def build_tree(arr)
    return nil if arr.empty?

    mid = arr.length / 2
    Node.new(arr[mid], build_tree(arr[0...mid]), build_tree(arr[(mid + 1)..]))
  end

  def insert(node_val, start = @root)
    return start.left = Node.new(node_val) if start.left.nil? && node_val < start.data
    return start.right = Node.new(node_val) if start.right.nil? && node_val > start.data

    if node_val < start.data
      insert(node_val, start.left)
    elsif node_val == start.data
      nil
    else
      insert(node_val, start.right)
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

  def find(val, root = @root)
    if val.nil?
      puts 'BST does not support nil value nodes'
      return nil
    elsif root.nil?
      puts "Could not find #{val} in BST"
      return nil
    end

    return root if val == root.data

    val < root.data ? find(val, root.left) : find(val, root.right)
  end

  def level_order(node = @root, queue = [node], accum = [], block: nil)
    until queue.empty?
      head = queue.shift
      block.nil? ? accum << head.data : block.call(head)
      queue.push(head.left) unless head.left.nil?
      queue.push(head.right) unless head.right.nil?
    end
    accum
  end

  def preorder(node = @root, accum = [], block: nil)
    return if node.nil?

    block.nil? ? accum << node.data : block.call(node)
    preorder(node.left, accum, block: block)
    preorder(node.right, accum, block: block)
    accum
  end

  def inorder(node = @root, accum = [], block: nil)
    return if node.nil?

    inorder(node.left, accum, block: block)
    block.nil? ? accum << node.data : block.call(node)
    inorder(node.right, accum, block: block)
    accum
  end

  def postorder(node = @root, accum = [], block: nil)
    return if node.nil?

    postorder(node.left, accum, block: block)
    postorder(node.right, accum, block: block)
    block.nil? ? accum << node.data : block.call(node)
    accum
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

  def balanced?(node = @root)
    return 0 if node.nil?

    left = balanced?(node.left)
    right = balanced?(node.right)

    return -1 if (left - right).abs > 1 || left.negative? || right.negative?

    [left, right].max + 1
  end

  def rebalance
    vals = inorder
    @root = build_tree(vals)
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left
  end
end

bst = Tree.new(Array.new(15) { rand(1..100) })
bst.pretty_print
p bst.balanced?
pre = []
pre_lamb = ->(node) { pre.push(node.data) }
bst.preorder(bst.root, block: pre_lamb)
p pre
traversed_pre = bst.preorder
p traversed_pre

in_ = []
in_lamb = ->(node) { in_.push(node.data) }
bst.inorder(bst.root, block: in_lamb)
p in_
traversed_in = bst.inorder
p traversed_in

p bst.level_order

new_vals = Array.new(10) { rand(50..200) }
new_vals.each { |val| bst.insert(val) }
bst.pretty_print
p bst.balanced?

bst.rebalance
bst.pretty_print

p bst.balanced?
