//
//  ViewController.m
//  matchismo
//
//  Created by rhino Q on 11/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import "ViewController.h"
#import "Model/Deck.h"
#import "Model/PlayingCardDeck.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;

@end

@implementation ViewController

- (Deck *)deck {
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

-(Deck *) createDeck {
    return [PlayingCardDeck new];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    [self updateFlipsLabel];
}

-(void)updateFlipsLabel {
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

-(void)updateFlipCount {
    self.flipCount++;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    [self updateFlipCount];
    
    if ( [sender.currentTitle length]) {
        [self turnCardBack:sender];
        return;
    }
    
    [self turnCardFront:sender];
}

-(void)turnCardBack:(UIButton*)sender {
    [sender setBackgroundImage:[UIImage imageNamed:@"cardBack"]
                      forState:UIControlStateNormal];
    [sender setTitle:@"" forState:UIControlStateNormal];
    [self checkDeckEmpty:sender];
}

-(void)checkDeckEmpty:(UIButton*)sender{
    if ( [self.deck isEmpty] ) { sender.hidden = YES; }
}

-(void)turnCardFront:(UIButton*)sender {
    [sender setBackgroundImage:[UIImage imageNamed:@"cardFront"] forState:UIControlStateNormal];
    [sender setTitle:[self.deck drawRandomCard].contents forState:UIControlStateNormal];
}

@end
