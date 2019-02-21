//
//  SetCardDeck.m
//  matchismo
//
//  Created by rhino Q on 19/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        for( NSString *shape in [SetCard validShape]) {
            for(NSString *color in [SetCard validColor]) {
                for(NSString *shading in [SetCard validShading]) {
                    for(NSInteger number = 1; number<= [SetCard maxNumber]; number++) {
                        SetCard *card = [SetCard new];
                        card.shape = shape;
                        card.color = color;
                        card.shading = shading;
                        card.number = number;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}
@end
