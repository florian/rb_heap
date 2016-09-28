class Heap
  def self.sort(array)
    heap = Heap.new
    result = Array.new(array.size)

    array.each do |element|
      heap.add(element)
    end

    (0...array.size).each do |i|
      result[i] = heap.pop
    end

    result
  end
end
