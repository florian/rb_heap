require "spec_helper"

describe Heap do
  before :each do
    @a = Heap.new
  end

  it "has a version number" do
    expect(Heap::VERSION).not_to be nil
  end

  describe :peak do
    it "returns the top element" do
      @a << 3 << 2 << 5
      expect(@a.peak).to eq(2)
    end

    it "does not delete the top element" do
      @a << 3 << 2 << 5
      3.times do
        @a.peak
      end

      expect(@a.peak).to eq(2)
    end
  end

  describe :new do
    it "creates a min heap by default" do
      a = Heap.new
      a << 3 << 2 << 5
      expect(a.pop).to eq(2)
      expect(a.pop).to eq(3)
      expect(a.pop).to eq(5)
    end

    it "can create a min heap using :<" do
      a = Heap.new(:<)
      a << 3 << 2 << 5
      expect(a.pop).to eq(2)
      expect(a.pop).to eq(3)
      expect(a.pop).to eq(5)
    end

    it "can create a min heap using :<" do
      a = Heap.new(:>)
      a << 3 << 2 << 5
      expect(a.pop).to eq(5)
      expect(a.pop).to eq(3)
      expect(a.pop).to eq(2)
    end

    it "can create a custom heap using a block" do
      a = Heap.new{|a, b| a.abs < b.abs}
      a << 3 << -2 << -5
      expect(a.pop).to eq(-2)
      expect(a.pop).to eq(3)
      expect(a.pop).to eq(-5)
    end
  end

  describe :size do
    it "returns the number of added elements" do
      @a << 5 << 4 << 3 << 2 << 1
      expect(@a.size).to eq(5)
    end

    it "updates if we keep adding elements do" do
      @a << 5 << 4 << 3 << 2 << 1
      expect(@a.size).to eq(5)

      @a << 10 << 9
      expect(@a.size).to eq(7)

      @a << 8 << 7 << 6
      expect(@a.size).to eq(10)
    end

    it "counts elements that appear more than once" do
      @a << 1 << 1 << 1 << 1
      expect(@a.size).to eq(4)
    end
  end

  describe :empty? do
    it "returns true when the heap is empty" do
      expect(@a.empty?).to be true
    end

    it "returns false when the heap has elements" do
      @a << 1
      expect(@a.empty?).to be false
    end

    it "returns false when we elements are added after being removed" do
      @a << 1
      @a.pop
      @a << 2
      expect(@a.empty?).to be false
    end
  end

  describe :pop do
    it "returns the top element" do
      @a << 2 << 1 << 3
      expect(@a.pop).to eq(1)
    end

    it "removes the top element" do
      @a << 2 << 1 << 3 << 5 << 4 << 8 << 6 << 7 << 9

      (1..9).each do |i|
        expect(@a.pop).to eq(i)
      end
    end

    it "returns nil when the heap is empty" do
      expect(@a.pop).to be nil
    end
  end

  describe :replace do
    it "replaces the top element" do
      @a << 2 << 1 << 3 << 5 << 4 << 8 << 6 << 7 << 9
      @a.replace(0)
      expect(@a.peak).to eq(0)
    end

    it "does not change the heap size" do
      @a << 2 << 1 << 3 << 5 << 4 << 8 << 6 << 7 << 9
      oldSize = @a.size
      @a.replace(0)
      expect(@a.size).to eq(oldSize)
    end

    it "rebalances the heap" do
      @a << 2 << 1 << 3 << 5 << 4 << 8 << 6 << 7 << 9
      @a.replace(10)
      expect(@a.peak).to eq(2)
    end
  end

  describe :offer do
    it "does not replace the top if the given element is not in relation with it" do
      @a << 5 << 3 << 4
      @a.offer(2) # 2 < 3 is true, so it should not be replaced
      expect(@a.pop).to eq(3)
      expect(@a.pop).to eq(4)
      expect(@a.pop).to eq(5)
    end

    it "does replace the top if the given element is in relation with it" do
      @a << 5 << 3 << 4
      @a.offer(6) # 6 < 3 is false, so it should be replaced
      expect(@a.pop).to eq(4)
      expect(@a.pop).to eq(5)
      expect(@a.pop).to eq(6)
    end

    it "respects the given order relation" do
      a = Heap.new{|a, b| a.abs < b.abs}
      a << -3 << -5 << 4
      a.offer(-10) # -10.abs < -3.abs is false, so it should be replaced
      expect(a.pop).to eq(4)
      expect(a.pop).to eq(-5)
      expect(a.pop).to eq(-10)
    end
  end

  describe :clear do
    it "clears the data" do
      @a << 2 << 3
      @a.clear
      expect(@a.size).to eq(0)
    end
  end

  describe :to_a do
    it "returns the heap as an array" do
      @a << 2 << 1 << 3 << 4 << 6 << 5
      # We have to sort because we can't make assumptions about the order
      expect(@a.to_a.sort).to eq([1,2,3,4,5,6])
    end

    it "contains no meta elements" do
      expect(@a.to_a).to eq([])
    end
  end
end
