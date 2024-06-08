# Tree class represents our (balanced) Binary Seach Tree
class Tree
  attr_reader :root, :arr

  def initialize(arr)
    @arr = arr
  end

  def build_tree(arr)
    return nil if arr.empty?

    mid = arr.length / 2
    root = Node.new(arr[mid])
    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[(mid + 1)..])
    @root = root
  end

  def insert(node, curr_node)
    return curr_node.left = node if curr_node.left.nil? && node < curr_node
    return curr_node.right = node if curr_node.right.nil? && node > curr_node

    if node < curr_node
      insert(node, curr_node.left)
    elsif node == curr_node
      nil
    else
      insert(node, curr_node.right)
    end
  end


 def pretty_print(node = @root, prefix = '', is_left = true)
   pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
   puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
   pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
 end
end

# Node object represents a node in a balanced BST
class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
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

arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
arr3 = [1]
bst = Tree.new(arr)
bst.build_tree(bst.arr)
# p bst.root
bst.pretty_print
new_node = Node.new(10)
new_node2 = Node.new(8.5)
p bst.insert(new_node, bst.root)
p bst.insert(new_node2, bst.root)
p bst.root
bst.pretty_print
