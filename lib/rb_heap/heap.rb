class Heap
  def initialize(compare_symbol = :<, &compare_fn)
    initialize_heap
    initialize_compare(compare_symbol, &compare_fn)
  end

  def size
    @heap.size - 1
  end

  def empty?
    size == 0
  end

  def peak
    @heap[1]
  end

  def pop
    result = peak

    if size > 1
      @heap[1] = @heap.pop
      rebalance_down(1)
    else
      clear
    end

    result
  end

  def add(element)
    @heap << element
    rebalance_up(size)
    self
  end

  alias :<< :add

  def replace(element)
    @heap[1] = element
    rebalance_down(1)
  end

  def offer(element)
    if compare(element, peak)
      result = peak
      replace(element)
      result
    else
      element
    end
  end

  def clear
    initialize_heap
  end

  def to_s
    result = ""
    i = 1

    while i <= size
      result << @heap[i, i].to_s
      i *= 2
    end

    result
  end

  def to_a
    @heap[1..-1]
  end

  private

  def initialize_heap
    @heap = [nil]
  end

  def initialize_compare(symbol, &fn)
    @compare = if block_given?
      compare_fn
    elsif symbol == :< or symbol.nil?
      lambda{|a, b| a < b}
    elsif symbol == :>
      lambda{|a, b| a > b}
    else
      raise ArgumentError.new("The comparison symbol needs to be either :> or :<")
    end
  end

  def compare(a, b)
    @compare.call(a, b)
  end

  def rebalance_up(i)
    parent_i = parent(i)

    if has_parent(i) and compare(@heap[i], @heap[parent_i])
      @heap[i], @heap[parent_i] = @heap[parent_i], @heap[i]
      rebalance_up(parent_i)
    end
  end

  def rebalance_down(i)
    left_i = left(i)
    right_i = right(i)

    if has_left(i) and compare(@heap[left_i], @heap[i]) and (not has_right(i) or compare(@heap[left_i], @heap[right_i]))
      @heap[i], @heap[left_i] = @heap[left_i], @heap[i]
      rebalance_down(left_i)
    elsif has_right(i) and compare(@heap[right_i], @heap[i])
      @heap[i], @heap[right_i] = @heap[right_i], @heap[i]
      rebalance_down(right_i)
    end
  end

  def has_parent(i)
    i >= 2
  end

  def parent(i)
    (i / 2).floor
  end

  def has_left(i)
    left(i) <= size
  end

  def left(i)
    i * 2
  end

  def has_right(i)
    right(i) <= size
  end

  def right(i)
    i * 2 + 1
  end
end
