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

## Sorting

Heapsort is pretty light-weight to implement once you have a working heap. For this
reason this library also comes with a heapsort function.

```rb
Heap.sort([3,1,2]) # => [1, 2, 3]
```
