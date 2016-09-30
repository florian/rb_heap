# Heap

This is an heap implementation that can be used for priority queues. Internally
it represents the heap as an array. It also contains an in-place heapsort
implementation.

`gem install rb_heap`

```rb
heap = Heap.new(:<)

# << and .add are aliases
heap << 3 << 1 << 2
heap.add(4)

heap.peak # => 4
heap.pop # => 4
heap.pop # => 3
heap.pop # => 2
heap.pop # => 1
```

## Different kind of heaps

The default heap is a min heap, but you can also specifiy it explicitely.
```rb
minHeap = Heap.new
anotherMinHeap = Heap.new(:<)
```

Creating a max heap is straight-forward:
```rb
maxHeap = Heap.new(:>)
```

You can also pass a custom comparison function using a block:
```rb
minAbsHeap = Heap.new{|a, b| a.abs < b.abs}
minAbsHeap << 3 << 1 << -2
minAbsHeap.pop # => 1
minAbsHeap.pop # => -2
minAbsHeap.pop # => 3
```

You can use this comparison function to compare specific fields:

```rb
Person = Struct.new(:name, :age)

ageHeap = Heap.new{|a, b| a.age < b.age}
ageHeap << Person.new("Richard Hendricks", 26)
ageHeap << Person.new("Erlich Bachman", 32)
ageHeap << Person.new("Dinesh Chugtai", 30)

ageHeap.pop.name # => Richard Hendricks
ageHeap.pop.name # => Dinesh Chugtai
ageHeap.pop.name # => Erlich Bachman

```

## `pop` (O(log n)) and `peak` (O(1))

`pop` removes the top element of the heap and returns it. `peak` returns the top
element but doesn't change the heap itself.

When the heap doesn't have any elements, `nil` is returned. You can also
explicitly check if the heap still has elements using the `empty?` method.

## `add` (O(log n))

You can add elements to the heap using `.add`. As you already saw `<<` is
aliased to `.add`.

## `replace` (O(log n))

You can replace the top element with a new one using this method. Of course you
could also `pop` and `add` but that would cause two rebalance operations.
`.replace` is optimised to only take one.

```rb
heap = Heap.new
heap << 1 << 2 << 3
heap.replace(4)

heap.pop # => 2
heap.pop # => 3
heap.pop # => 4
```

## `offer` (O(log n))

A lot of times you only want to replace the top element if it's smaller/larger
than the potentially new element.

```rb
heap = Heap.new
heap << 1

heap.offer(0) # It's a min heap and 1 > 0, so it's not replaced
heap.peak # => 1

heap.offer(2) # 1 < 2, so it's replaced
heap.peak # => 2
```

This method assumes that there's already a top element, so you have to check
yourself that you don't call it on an empty heap.

A potential use case would be finding the largest `k` numbers in a stream of
incoming numbers, without actually storing all numbers.

## Other utilities

### `size`

Returns the amount of elements that are in the heap.

### `empty?`

Returns a boolean that indicates whether the heap has any elements.

### `to_a`

Gives you all the heap contents as an array, but you shouldn't make any assumptions about
the order of the elements.

## Sorting

Heapsort is pretty light-weight to implement once you have a working heap. For this
reason this library also comes with an in-place heapsort function.

```rb
Heap.sort([3,1,2]) # => [1, 2, 3]
Heap.sort([3,1,2], :>) # => [3, 2, 1]
Heap.sort([3,1,-2]){|a, b| a.abs < b.abs} # => [1, -2, 3]
```

## Developing

You can run the unit tests using `rake`.

### Future ideas

Ideas for functions that could be added:

- Create a heap from an array. This is possible in O(n). Right now one could
  repeatly add all the array elements into a new heap, but that'd be O(n log n)
- Merging two heaps

I guess it would also be fun to implement different kind of heaps, but maybe
that's beyond the scope if this library.
