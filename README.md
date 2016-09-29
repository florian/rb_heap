# Heap

This is an heap implementation that can be used for priority queues.

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

## `pop` and `peak`

`pop` removes the top element of the heap and returns it. `peak` returns the top
element but doesn't change the heap itself.

When the heap doesn't have any elements, `nil` is returned. You can also
explicitly check if the heap still has elements using the `empty?` method.

## `replace`

## `offer`

## Other utilities

`size`
`empty?`
`to_a`

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
