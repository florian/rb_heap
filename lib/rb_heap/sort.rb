class Heap
  def self.sort(array, order = :<, &compare_fn)
    compare_fn = self.invertComparison(order, &compare_fn)
    heap = Heap.new(order, array, &compare_fn)

    array.each do |element|
      heap.add(element)
    end

    (0...array.size).reverse_each do |i|
      array[i] = heap.pop
    end

    heap.to_a
  end

  def self.invertComparison(order, &compare_fn)
    if block_given?
      lambda{|a, b| not compare_fn.call(a, b)}
    elsif order == :< or order.nil?
      lambda{|a, b| a > b}
    elsif order == :>
      lambda{|a, b| a < b}
    else
      raise ArgumentError.new("The comparison symbol needs to be either :> or :<")
    end
  end
end
