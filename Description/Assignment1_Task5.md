##### When I use a header "class someName..." in code block for some code, that means the following code is within the scope of the class named 'someName'.

## Required Task
>  Matchismo so far only displays the A♣ over and over. Fix Matchismo so that each time the card is flipped face up, it displays a different random card drawn from the
Deck property you’ve created above. In other words, Matchismo should flip through an entire deck of playing cards in random order, showing each card one at a time.

- start with card 'back'

- make drawRandomCard method

```swift
class Deck...

- (Card *)drawRandomCard {
    Card *randomCard = nil;
    
    if([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}
```
- make isEmpty method to check deck is empty. if deck ie empty, make card hidden

```swift
class Deck...

- (BOOL)isEmpty {
    return !_cards.count;
}

class VC...
-(void)turnCardBack:(UIButton*)sender {
    [sender setBackgroundImage:[UIImage imageNamed:@"cardBack"]
                      forState:UIControlStateNormal];
    [sender setTitle:@"" forState:UIControlStateNormal];
    [self checkDeckEmpty:sender];
}

-(void)checkDeckEmpty:(UIButton*)sender{
    if ( [self.deck isEmpty] ) { sender.hidden = YES; }
}

```