require "spec_helper"

describe Heap do
  describe :sort do
    it "should sort all elements" do
      sorted = (1..1000).to_a
      unsorted = sorted.shuffle

      expect(Heap.sort(unsorted)).to eq(sorted)
    end

    it "should be able to deal with elements that appear more than once" do
      unsorted = ((1..2000).to_a * 2).shuffle
      sorted = unsorted.sort

      expect(Heap.sort(unsorted)).to eq(sorted)
    end

    it "should respect the given order" do
      sorted = (1..3000).to_a.reverse
      unsorted = sorted.shuffle

      expect(Heap.sort(unsorted, :>)).to eq(sorted)
    end

    it "should respect the given block" do
      sorted = (1..4000).to_a.map{|x| rand() > 0.5 ? x : -x}
      unsorted = sorted.shuffle

      heapsorted = Heap.sort(unsorted){|a, b| a.abs < b.abs}
      expect(heapsorted).to eq(sorted)
    end
  end
end
