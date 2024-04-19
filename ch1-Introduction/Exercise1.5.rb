
# Exercise 1.5: Using a Uset, implement a Bag. A Bag is like a Uset - it
# supports the add(x), remove(x) and find(x) methods, but it allows duplicate
# elements to be stored. The find(x) operation in a Bag returns some element
# (if any) that is equal to x. In addition, a Bag supports the find_all(x)
# operation that returns a list of all elements in the Bag that are equal to x.

class HashBag
  def initialize
    @collection = {}
  end

  def add(x)
    if @collection.has_key?(x)
      @collection[x] = 1
    else
      @collection[x] += 1
    end
  end

  def remove(x)
    @collection[x] -= 1 if @collection.has_key?(x)
    @collection.delete(x) if @collection[x] < 1
  end
      
  def find(x)
    @collection.has_key?(x) ? x : nil
  end
end
