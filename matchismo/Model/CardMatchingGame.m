//
//  CardMatchingGame.m
//  matchismo
//
//  Created by rhino Q on 14/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger totalScore;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, readwrite) int eachScore;
@property (nonatomic, strong) NSMutableArray* chosenCards;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if(!_cards) _cards = [NSMutableArray new];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if ( self ) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if ( card ) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    
    return (index < [self.cards count] ) ? self.cards[index] : nil;
}

//#define MISMATCH_PENALTY 2
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if ( !card.isMached ) {
        if ( card.isChosen ) {
            card.chosen = NO;
        } else {
            NSMutableArray *otherCards = [NSMutableArray array];
            for( Card *otherCard in self.cards) {
                if ( otherCard.isChosen && !otherCard.isMached ) {
                    [otherCards addObject:otherCard];
                }
            }
            
            [self.chosenCards addObjectsFromArray:otherCards];
            [self.chosenCards addObject:card];
            
            if ( [otherCards count] + 1 == self.cardsMatchMode ) {
                int matchScore = [card match:otherCards];
                if ( matchScore ) {
                    self.eachScore += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                    }
                } else {
                    self.eachScore -= MISMATCH_PENALTY;
                    for (Card *otherCard in otherCards) {
                        otherCard.chosen = NO;
                    }
                }
            }
            self.totalScore += self.eachScore - COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end
