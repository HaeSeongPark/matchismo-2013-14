//
//  SetCard.m
//  matchismo
//
//  Created by rhino Q on 19/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

#pragma mark - Properites

#pragma mark - Shape
@synthesize shape = _shape;

+ (NSArray *)validShape {
    return @[@"circle", @"triangle", @"square"]; // maybe added diamond
}

- (void)setShape:(NSString *)shape {
    if ( [[SetCard validShape] containsObject:shape] ) {
        _shape = shape;
    }
}

- (NSString *)shape {
    return _shape ? _shape : @"?";
}

#pragma mark - Color
@synthesize color = _color;

+ (NSArray *)validColor {
    return @[@"red", @"purple", @"green"]; // maybe added blue later?
}

- (void)setColor:(NSString *)color {
    if ( [[SetCard validColor] containsObject:color]) {
        _color = color;
    }
}

- (NSString *)color {
    return _color ? _color : @"?";
}

#pragma mark - Shading
@synthesize shading = _shading;

+ (NSArray *)validShading {
    return @[@"solid", @"striped", @"outlined"]; // maybe added dotted later?
}

- (void)setShading:(NSString *)shading {
    if ( [[SetCard validShading] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSString *)shading {
    return _shading ? _shading : @"?";
}

#pragma mark - maxNumer
+ (NSUInteger )maxNumber {
    return [[self validShape] count];
}

#pragma mark - contents
- (NSString *)contents {
    return [NSString stringWithFormat:@"%@:%@:%@:%d",self.shape, self.color, self.shading, (int)self.number];
}

#pragma mark - Match
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count] == self.numberOfMatchingCards - 1) {
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        NSMutableArray *symbols = [[NSMutableArray alloc] init];
        NSMutableArray *shadings = [[NSMutableArray alloc] init];
        NSMutableArray *numbers = [[NSMutableArray alloc] init];
        [colors addObject:self.color];
        [symbols addObject:self.shape];
        [shadings addObject:self.shading];
        [numbers addObject:@(self.number)];
        for (id otherCard in otherCards) {
            if ([otherCard isKindOfClass:[SetCard class]]) {
                SetCard *otherSetCard = (SetCard *)otherCard;
                if (![colors containsObject:otherSetCard.color])
                    [colors addObject:otherSetCard.color];
                if (![symbols containsObject:otherSetCard.shape])
                    [symbols addObject:otherSetCard.shape];
                if (![shadings containsObject:otherSetCard.shading])
                    [shadings addObject:otherSetCard.shading];
                if (![numbers containsObject:@(otherSetCard.number)])
                    [numbers addObject:@(otherSetCard.number)];
            }
        }
        if (([colors count] == 1 || [colors count] == self.numberOfMatchingCards)
            && ([symbols count] == 1 || [symbols count] == self.numberOfMatchingCards)
            && ([shadings count] == 1 || [shadings count] == self.numberOfMatchingCards)
            && ([numbers count] == 1 || [numbers count] == self.numberOfMatchingCards)) {
            score = 4;
        }
    }
    return score;
}

+ (NSArray *)cardsFromText:(NSString *)text
{
    NSString *pattern = [NSString stringWithFormat:@"(%@):(%@):(%@):(\\d+)",
                         [[SetCard validShape] componentsJoinedByString:@"|"],
                         [[SetCard validColor] componentsJoinedByString:@"|"],
                         [[SetCard validShading] componentsJoinedByString:@"|"]];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) return nil;
    NSArray *matches = [regex matchesInString:text
                                      options:0
                                        range:NSMakeRange(0, [text length])];
    if (![matches count]) return nil;
    
    NSMutableArray *setCards = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *match in matches) {
        SetCard *setCard = [[SetCard alloc] init];
        setCard.shape = [text substringWithRange:[match rangeAtIndex:1]];
        setCard.color = [text substringWithRange:[match rangeAtIndex:2]];
        setCard.shading = [text substringWithRange:[match rangeAtIndex:3]];
        setCard.number = [[text substringWithRange:[match rangeAtIndex:4]] intValue];
        [setCards addObject:setCard];
    }
    
    return setCards;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.numberOfMatchingCards = 3;
    }
    return self;
}
@end
