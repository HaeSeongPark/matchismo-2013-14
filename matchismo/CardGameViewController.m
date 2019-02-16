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
@property (strong, nonatomic) NSMutableArray* resultHistory;
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

-(NSMutableArray *)resultHistory {
    if(!_resultHistory) {
        _resultHistory = [NSMutableArray array];
    }
    return _resultHistory;
}


- (IBAction)slidedreulstHistorySlider:(UISlider *)sender {
    int positionOfSlide =  roundf(self.resultHistorySlider.value);
    if ( positionOfSlide > 0 ) {
        [self updateResultDescription:[self.resultHistory objectAtIndex:positionOfSlide - 1 ]];
    }
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
    
    [self storeHistory:description];
    [self updateResultHistorySlider];
    [self updateResultDescription:description];
}

-(void)updateResultDescription: (NSString *)description {
    [self.resultsDescription setText:description];
    if ( self.resultHistorySlider.value == self.resultHistorySlider.maximumValue ) {
        [self.resultsDescription setAlpha:1.0];
    } else {
        [self.resultsDescription setAlpha:0.5];
    }
}

-(void)storeHistory: (NSString *)resultDescritpion {
    [self.resultHistory addObject: resultDescritpion];
}

-(void)updateResultHistorySlider {
    self.resultHistorySlider.maximumValue = self.resultHistory.count;
    [self.resultHistorySlider setValue:self.resultHistory.count];
}

- (IBAction)touchedDealButton:(UIButton *)sender {
    self.cardMatchMode.enabled = YES;
    self.game = nil;
    [self updateUI];
    self.resultHistory = nil;
    [self updateResultHistorySlider];
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
