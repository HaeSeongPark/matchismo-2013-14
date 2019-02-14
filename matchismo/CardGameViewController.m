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

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;

@end

@implementation CardGameViewController

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
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];

}

- (IBAction)touchCardButton:(UIButton *)sender {
    if ( [sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardBack"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
        self.flipCount++;
    } else {
        Card *card = [self.deck drawRandomCard];
        if ( card ) {
            [sender setBackgroundImage:[UIImage imageNamed:@"cardFront"] forState:UIControlStateNormal];
            [sender setTitle:card.contents forState:UIControlStateNormal];
            self.flipCount++;
        }
    }
}

@end
