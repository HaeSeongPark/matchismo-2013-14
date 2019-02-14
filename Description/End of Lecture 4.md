## In this lecture
- More Objective-C
   - objects, nil, id(dynamic binding) with example below, Introspection, overall foundation( NSobject, NSArray, NSData, UIFont, UIColor, NSAttributedString, etc)

- dynamic typing
```objc
method match in class PlayingCard...

    if([otherCards count] == 1) {
        id card = [otherCards firstObject];
        if ( [card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherCard = (PlayingCard *)card;
            if ( [self.suit isEqualToString:otherCard.suit]) {
                score = 1;
            } else if ( self.rank == otherCard.rank) {
                score = 4;
            }
        }
    }
```
