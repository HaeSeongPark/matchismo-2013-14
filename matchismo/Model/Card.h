
//  Card.h
//  matchismo
//
//  Created by rhino Q on 11/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMached) BOOL matched;

-(int) match:(NSArray*)otherCards;

@end

NS_ASSUME_NONNULL_END
