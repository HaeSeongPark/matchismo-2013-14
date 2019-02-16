//
//  PlayingCard.m
//  matchismo
//
//  Created by rhino Q on 11/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

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

- (NSString *)contents {
    NSArray *rankString = [PlayingCard rankStrings];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♥️", @"♦️", @"♠️", @"♣️"];
}

-(void)setSuit:(NSString *)suit {
    if ( [[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

+ (NSArray *)rankStrings{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}
@end
