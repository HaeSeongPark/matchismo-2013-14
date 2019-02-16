## Required Task
-  3. Drag out a switch (UISwitch) or a segmented control (UISegmentedControl) into your View somewhere which controls whether the game matches two cards at a time or three cards at a time (i.e. it sets “2-card-match mode” vs. “3-card-match mode”). Give the user appropriate points depending on how difficult the match is to accomplish. In 3-card-match mode, it should be possible to get some (although a significantly lesser amount of) points for picking 3 cards of which only 2 match in some way. In that case, all 3 cards should be taken out of the game (even though only 2 match). In 3-card-match mode, choosing only 2 cards is never a match.

## Related Hints
-  4. You will have to read the documentation for UISwitch and/or UISegmentedControl to figure out how to use them. A switch is probably (a little bit) easier to understand, but a segmented control might be more appropriate to the task. Being able to figure a class out solely from its documentation is crucial to being a good iOS developer. That’s what that Required Task is about.

- 5. The logic in your Model will have to be configurable for the two different game play modes. And your PlayingCard class will also have to know how to match itself against two other cards (it already knows how to match itself against one other card).

- 6.  Often in computer science we talk about there only being 3 numbers: 0, 1 and n. The Matchismo we developed in class matches against 1 other card. You are being asked to match against 2 other cards, but perhaps (at least in your CardMatchingGame class, but maybe not in PlayingCard) you should choose to match against n other cards instead of just 2 other cards? This is not a Required Task, just something to consider.

- 7. You can feel free to adjust the scoring of 2-card-match mode if you want it to be consistent with your 3-card-match mode’s scoring. In other words, consider the difficulty of matching 2 out of 2 cards of the same suit (medium) versus 2 out of 3 (easy) or 3 out of 3 (hard).

## My Solutions
##### When I use a header "class someName..." in code block for some code, that means the following code is within the scope of the class named 'someName'.

 1. According to related Hint 4, I dicided to use the UISegmentedControl instead of UISwiftch. After reading documentation of UISegmentedControl, I would use below code 1. But where I have to put this code? I thought that viewDidLoad is right place to put this code in. But not yet introduced in Lecture. How about the others like game, creatDeck, etc. It's not right place I think... So I just made IBAction for UISegmentedControl as UIButtons. And I made EXTRA_NUMBER_FOR_CARDMATCHMODE. I could have segemented title 2, 3 and use it rightly. But then user couldn't know What it is. So I had segemented title 2CardMatch, 3CardMatch explicitly. And it works
 ```objc
------------1.
 [segmentedControl addTarget:self
                     action:@selector(action:)
           forControlEvents:UIControlEventValueChanged];

-----------2.
class CardGameViewContoller...

static const int EXTRA_NUMBER_FOR_CARDMATCHMODE = 2;

- (IBAction)changedCardsMatchMode:(UISegmentedControl *)sender {
    NSLog(@"%d", (int)[sender selectedSegmentIndex] + EXTRA_NUMBER_FOR_CARDMATCHMODE); 
    // 2 for first segmented, 3 for segmented segmented
}
```
2. I needed to let the game know which mode had seleted. For short, 2 or 3.
   Frist, I made cardsMatchMode property in game -1. and set mode to it. -2. Also we need to set default value to it.- 3. Ah! make sure that in storyboard, segment1 is seleted. 
```objc
-----1.
class CardMatcingGame...

@property (nonatomic) int cardsMatchMode;

------------2
class CardGameViewContoller...

- (IBAction)changedCardsMatchMode:(UISegmentedControl *)sender {
    self.game.cardsMatchMode = (int)[sender selectedSegmentIndex] + EXTRA_NUMBER_FOR_CARDMATCHMODE;
}

----------3
class CardGameViewContoller...

static const int DEFAULT_CARDMATCHMODE = 2;

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        _game.cardsMatchMode = DEFAULT_CARDMATCHMODE;
    }
    return _game;
}
```

3. We need to ready for 3 cards match mode. There is already 2 cards match way in previous project.
    - First, before match, we collec all the cards which is selected and not matched -1. And then, when otherCards.count + 1 is equal cardsMatchMode start match logic -2. ( I wanted to use functional mehods like map in swift.)
```objc
-----1
CardMatchingGame...
    NSMutableArray *otherCards = [NSMutableArray array];
    for( Card *otherCard in self.cards) {
        if ( otherCard.isChosen && !otherCard.isMached ) {
            [otherCards addObject:otherCard];
        }
    }
------2
    if ( [otherCards count] +  1 == self.cardsMatchMode ) {
        int matchScore = [card match:otherCards];
        if ( matchScore ) {
            self.score += matchScore * MATCH_BONUS;
            card.matched = YES;
            for (Card *otherCard in otherCards) {
                otherCard.matched = YES;
            }
        } else {
            self.score -= MISMATCH_PENALTY;
            for (Card *otherCard in otherCards) {
                otherCard.matched = NO;
            }
        }
    }
```
4. Change the match logic for 3 cardsMatchMode. And ready for 3 out of 3 cards of same Rank and Suit, Plus, Also ready, All cases AB, AC, BC if 3cards(A,B,C) with recursion.
```objc
class PlayingCard
-(int)match:(NSArray *)otherCards {
    int score = 0;
    int numberOfOtherCards = (int)[otherCards count];
    int numberOfSuitMatch = 0;
    int numberOfRankMatch = 0;
    
    for (Card *card in otherCards) {
        if ( [card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherCard = (PlayingCard *)card;
            if ( [self.suit isEqualToString:otherCard.suit]) {
                numberOfSuitMatch++;
                score += 1;
            } else if ( self.rank == otherCard.rank) {
                score += 4;
                numberOfRankMatch++;
            }
        }
    }
    
    // for 3 CardsMatchMode case
    if ( numberOfOtherCards > 1) {
        // 3 ouf of 3 cards of same Rank is supre hard, so bonus 100
        if ( numberOfRankMatch == numberOfOtherCards ) {
            score *= score;
        }
        
        // 3 ouf of 3 cards of same Suit is hard, so bonus 10
        if ( numberOfSuitMatch == numberOfOtherCards ) {
            score += 10;
        }
        
        score += [[otherCards firstObject] match:[otherCards subarrayWithRange:NSMakeRange(1, numberOfOtherCards - 1)]];
    }
    
    return score;
}
```