## In this lecture
- Add : to make CardGameVC abstract class and createDeck mandatory method
- Add : to make PlayingCardGameViewController subclass GardGameViewController
- Add : to change custom class to PlayingCardGameViewController instead of CardGameVC in storyBoard
- IBoutlet and IBAction still works greatfully

```objc
@interface CardGameViewController : UIViewController
// protected
// for subclasses
-(Deck *) createDeck; // abstract 

-------------------- CardGameViewController.m ...
...
-(Deck *) createDeck { // abstract
    return nil;
}
...

----------------
@interface PlayingCardGameViewController : CardGameViewController

@end

------------  PlayingCardGameViewController.m
- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

```
