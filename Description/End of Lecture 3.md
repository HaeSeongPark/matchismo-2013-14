## In this lecture
- Solution about Assignment1
  - PlayingCard should not be in VC.
  In VC, We're building a 'generic' card game which has noting to do with PlayingCard. So, It should work with any kind of deck. fix later.
   - Solution is so simple. But mine is too complicated...
```objc
method touchCardButton in class ViewController...

    if ( [sender.currentTitle length]) {
      ...
    } else {
        Card *card = [self.deck drawRandomCard];
        if ( card ) {
          ...
        }
    }
```
- CardMatchingGame with new logic, it's 'Model' not V and C
- Mutiple cards
- And so on.
