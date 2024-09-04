## Array-Based Lists

After implementing the `List` interface with the `ArrayList` described in the
book, I came to the realization that Ruby, along with other dynamic high-level
languages, are likely horrible languages to work with these kinds of data
structures.

The built-in `Array` class, most likely already very well optimized for all of
its core methods, is probably much better at doing these jobs than any
implementation of the `ArrayList` could do.

In my own implementation, there are various "hacky" things that I've had to do
to ensure correspondance with the descriptions of the implementation in the
book. For instance, raising `NoMemoryError` in `#set`, or the entire `#insert`
method which is basically just a crude implementation of the source code for
`Array#insert`.

There are 2 big take-aways after implementing this data structure:
1. Learning DSA with C is most likely the best way to learn DSA because of how
close the virtual memory model of a computer resembles the theoretical model
of computation that this book uses.
1. Dynamic resizing and insert are the most expensive operations performed on
arrays -- hence it is probably a good idea to avoid these operations when
possible


