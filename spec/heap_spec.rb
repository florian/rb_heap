require "spec_helper"

describe Heap do
  before :each do
    @a = Heap.new
  end

  it "has a version number" do
    expect(Heap::VERSION).not_to be nil
  end

  describe :add do

  end

  describe :<< do

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

  end

  describe :pop do

  end

  describe :replace do

  end

  describe :offer do

  end

  describe :clear do
    it "clears the data" do
      @a << 2 << 3
      @a.clear
      expect(@a.size).to eq(0)
    end
  end

  describe :to_a do

  end
end
