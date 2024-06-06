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
