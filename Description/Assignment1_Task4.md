## Required Task
>  Use lazy instantiation to allocate and initialize this property (in the property’s getter)
so that it starts off with a full deck of PlayingCards.


check init fisrt, have not already init, then initialize.

```swift
- (NSMutableArray *)cards {
    if(!_cards) _cards = [NSMutableArray new];
    return _cards;
}
```