require_relative './linked_list'

# Implement simple chained hashmap
class HashMap
  attr_reader :buckets, :capacity

  def initialize
    @buckets = Array.new(16)
    @load_factor = 0.75
    @capacity = 0
  end

  def hash(key)
    hash_code = 31
    prime = 31

    key.each_char { |char| hash_code = prime * hash_code + char.ord }
    hash_code
  end

  def set(key, val)
    i = hash(key) % @buckets.length
    raise IndexError if i.negative? || i >= @buckets.length

    if @buckets[i].nil?
      write_new_node(key, val, i)
    else
      pos = (@buckets[i].find(key) { |node_val| node_val[:k] == key })
      p pos
      overwrite_node(pos, i, key, val)
    end
  end

  private

  def write_new_node(key, val, index)
    @buckets[index] = LinkedList.new({ k: key, v: val, i: index })
    @capacity += 1
  end

  def overwrite_node(pos, hash_val, key, val)
    if pos.nil?
      @buckets[hash_val].append({ k: key, v: val, i: hash_val })
      @capacity += 1
    else
      buckets[hash_val].at(pos)[:v] = val
    end
  end

  def resize
  end
end


# hashmap = HashMap.new
# puts "FIRST"
# hashmap.set('John', 'Smith')
# puts "SECOND"
# hashmap.set('John', 'Smith2')
# puts "THIRD"
# hashmap.set('John', 'Smith3')
# puts "FOURTH"
# hashmap.set('John', 'Smith4')
# hashmap.buckets.each do |bucket|
#   puts 'nil' if bucket.nil?
#   bucket.to_s unless bucket.nil?
# end
# p hashmap.capacity
