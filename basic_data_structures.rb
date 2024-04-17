# Implement the basic data structure interfaces described in the book's
# introduction chapter. These include FIFO Queue, LIFO Queue, Priority Queue,
# Deque, List, USet and SSet. Note that all of the Queue interfaces may be
# subsumed by the List interface, but I will include them all here for the sake
# of completeness and practice.

module DataStructures
  class FIFOQueue
    attr_reader :collection
    
    def initialize(buffer_size)
      @buffer_size = buffer_size
      @collection = Array.new(buffer_size)
    end

    def add(x)
      if size() == @buffer_size
        # puts "Cannot exceed maximum buffer size #{@buffer_size}"
        return nil
      end
      @collection.push(x)
    end

    def remove
      @collection.shift()
    end

    def peak
      @collection.last()
    end

    def size
      @collection.length
    end
  end

  class LIFOQueue
    attr_reader :collection

    def initialize(buffer)
      @collection = Array.new(buffer)
    end

    def add(x)
      @collection.push(x)
    end

    def remove
      @collection.pop()
    end

    def peak
      @collection.last()
    end

    def size
      @collection.length
    end
  end

  class PriorityQueue
    # Will not implement this currently.
    # Wait until I learn about heaps.
  end

  class Deque
    attr_reader :collection

    def initialize
      @collection = []
    end

    def add_front(x)
      @collection.push(x)
    end

    def add_rear(x)
      @collection.unshift(x)
    end

    def remove_front
      @collection.pop
    end

    def remove_rear
      @collection.shift
    end

    def peak
      @collection.last()
    end

    def size
      @collection.length
    end
  end

  class List
    attr_reader :collection

    def initialize
      @collection = []
    end

    def size
      @collection.length
    end

    def get(i)
      @collection[i]
    end

    def set(i, x)
      @collection[i] = x
    end

    def add(i, x)
      @collection.insert(i, x)
    end

    def remove(i)
      if i < @collection.length && i >= 0
        @collection.delete_at(i)
      else
        puts "Error: Out of bounds"
        nil
      end
    end
  end

  class USet
    attr_reader :collection

    def initialize
      @collection = []
    end

    def size
      @collection.length
    end

    def add(x)
      @collection.each { |y| return false if (y == x) }
      @collection.push(x)
      return true
    end

    def remove(x)
      @collection.delete(x)
    end

    def find(x)
      @collection.each { |y| return y if y == x }
    end
  end

  class SSet
    attr_reader :collection

    def initialize
      @collection = []
    end

    def size
      @collection.length
    end

    def add(x)
      @collection.each { |y| return nil if (y == x) }
      @collection.push(x)
    end


    def remove(x)
      @collection.delete(x)
    end

    def find(x)
    end

    private

    def compare(x, y)
    end
  end
end
