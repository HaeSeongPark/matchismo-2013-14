//
//  SetCard.h
//  matchismo
//
//  Created by rhino Q on 19/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCard : Card
@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *shading;

+(NSArray *)validShape;
+(NSArray *)validColor;
+(NSArray *)validShading;
+(NSUInteger)maxNumber;

@end

NS_ASSUME_NONNULL_END
