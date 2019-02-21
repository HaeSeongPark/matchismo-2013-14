//
//  SetCardGameViewController.m
//  matchismo
//
//  Created by rhino Q on 19/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck {
    return [SetCardDeck new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    NSString *shape = @"?";
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];

    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;

        if ([setCard.shape isEqualToString:@"circle"]) shape = @"●";
        if ([setCard.shape isEqualToString:@"triangle"]) shape = @"▲";
        if ([setCard.shape isEqualToString:@"square"]) shape = @"■";

        shape = [shape stringByPaddingToLength:setCard.number
                                      withString:shape
                                 startingAtIndex:0];

        if ([setCard.color isEqualToString:@"red"])
            [attributes setObject:[UIColor redColor]
                           forKey:NSForegroundColorAttributeName];
        if ([setCard.color isEqualToString:@"green"])
            [attributes setObject:[UIColor greenColor]
                           forKey:NSForegroundColorAttributeName];
        if ([setCard.color isEqualToString:@"purple"])
            [attributes setObject:[UIColor purpleColor]
                           forKey:NSForegroundColorAttributeName];

        if ([setCard.shading isEqualToString:@"solid"])
            [attributes setObject:@-5
                           forKey:NSStrokeWidthAttributeName];
        if ([setCard.shading isEqualToString:@"striped"])
            [attributes addEntriesFromDictionary:@{
                                                   NSStrokeWidthAttributeName : @-5,
                                                   NSStrokeColorAttributeName : attributes[NSForegroundColorAttributeName],
                                                   NSForegroundColorAttributeName : [attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]
                                                   }];
        if ([setCard.shading isEqualToString:@"outlined"])
            [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
    }
    
    return [[NSMutableAttributedString alloc] initWithString:shape
                                                  attributes:attributes];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.chosen ? @"setCardSelected" : @"setCard"];
    
}

@end
