//
//  ViewController.m
//  matchismo
//
//  Created by rhino Q on 11/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import "CardGameViewController.h"
#import "Model/Deck.h"
#import "Model/PlayingCardDeck.h"
#import "Model/CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

-(Deck *) createDeck {
    return [PlayingCardDeck new];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int cardIndex = (int)[self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

-(void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = (int)[self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMached;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score : %d", (int)self.game.score];
}
- (IBAction)touchedDealButton:(UIButton *)sender {
    self.game = nil;
    [self updateUI];
}

static const int EXTRA_NUMBER_FOR_CARDMATCHMODE = 2;

- (IBAction)changedCardsMatchMode:(UISegmentedControl *)sender {
    NSLog(@"%d", (int)[sender selectedSegmentIndex] + EXTRA_NUMBER_FOR_CARDMATCHMODE);
}



-(NSString *)titleForCard: (Card*)card {
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed: card.isChosen ? @"cardFront" : @"cardBack"];
}
@end
