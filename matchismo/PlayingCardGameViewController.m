//
//  PlayingCardGameViewController.m
//  matchismo
//
//  Created by rhino Q on 17/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "Model/PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
