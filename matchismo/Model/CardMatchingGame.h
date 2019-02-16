//
//  CardMatchingGame.h
//  matchismo
//
//  Created by rhino Q on 14/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

// designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck: (Deck*)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex: (NSUInteger)index;

@property (nonatomic, readonly) NSInteger totalScore;
@property (nonatomic) int cardsMatchMode;
@end

NS_ASSUME_NONNULL_END
