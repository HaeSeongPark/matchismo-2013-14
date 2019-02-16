## Required Task
-  5. Add a text label somewhere which desribes the results of the last consideration by the CardMatchingGame of a card choice by the user. Examples: “Matched J♥ J♠ for 4 points.” or “6♦ J♣ don’t match! 2 point penalty!” or “8♦” if only one card is chosen or even blank if no cards are chosen. Do not violate MVC by building UI in your Model. “UI” is anything you are going to present to the user. This must work properly in either mode of Required Task 3.

  1. make UILabel which is description for result. and hook up that CardGameVC. I wanted have that named 'description'. But it's reserved word. 
  
  ```objc
  class GardGameVC...
...

@property (weak, nonatomic) IBOutlet UILabel *resultsDescription;

  ```
  2. We need to let the game have result information about chosen cards and its score.
   - Frist, I renamed existing score to totalScore
```objc
class GardMatcingGame
@property (nonatomic, readwrite) NSInteger totalScore;

```
 - And add properties eachScore, chosenCards
 ```objc
class GardMatcingGame.h ...
@property (nonatomic, readonly) int eachScore;
@property (nonatomic, readonly) NSArray* chosenCards;

class GardMatcingGame.h ...
@property (nonatomic, readwrite) int eachScore;
@property (nonatomic, strong) NSArray* chosenCards;
```
3. input chosnCards in chosenCards property and input each score in eachScore property preperly
```objc
    self.eachScore = 0;
    self.chosenCards = [otherCards arrayByAddingObject:card];
```
4. Add : display resultDescription in updateUI method

```objc
    NSString * description = @"";
    
    
    NSMutableArray *cardContents = [NSMutableArray array];
    for(Card *card in self.game.chosenCards) {
        [cardContents addObject:card.contents];
    }
    description = [cardContents componentsJoinedByString:@" "];
    
    if ( self.game.eachScore > 0 ) {
        description = [NSString stringWithFormat:@"Matched %@ for %d points", description, self.game.eachScore];
    } else if ( self.game.eachScore < 0) {
        description = [NSString stringWithFormat:@"%@ don't match! for %d points penalty", description, self.game.eachScore];
    }
    [self.resultsDescription setText:description];
```