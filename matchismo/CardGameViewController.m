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
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardMatchMode;
@property (weak, nonatomic) IBOutlet UILabel *resultsDescription;
@property (weak, nonatomic) IBOutlet UISlider *resultHistorySlider;
@end

@implementation CardGameViewController

static const int DEFAULT_CARDMATCHMODE = 2;

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        _game.cardsMatchMode = DEFAULT_CARDMATCHMODE;
    }
    return _game;
}

-(Deck *) createDeck {
    return [PlayingCardDeck new];
}
- (IBAction)slidedreulstHistorySlider:(UISlider *)sender {
    
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.cardMatchMode.enabled = NO;

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
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score : %d", (int)self.game.totalScore];
    
    
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
}
- (IBAction)touchedDealButton:(UIButton *)sender {
    self.cardMatchMode.enabled = YES;
    self.game = nil;
    [self updateUI];
}

static const int EXTRA_NUMBER_FOR_CARDMATCHMODE = 2;

- (IBAction)changedCardsMatchMode:(UISegmentedControl *)sender {
    self.game.cardsMatchMode = (int)[sender selectedSegmentIndex] + EXTRA_NUMBER_FOR_CARDMATCHMODE;
}

-(NSString *)titleForCard: (Card*)card {
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed: card.isChosen ? @"cardFront" : @"cardBack"];
}
@end
