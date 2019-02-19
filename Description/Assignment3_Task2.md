## Required Task
- 2. The Set game only needs to allow users to pick sets and get points for doing so (e.g. it does not redeal new cards when sets are found). In other words, it works just like the Playing Card matching game. The only differences are that it is a 3-card matching game and uses different cards (deal your Set cards out of a complete Set deck).


##### When I use a header "class someName..." in code block for some code, that means the following code is within the scope of the class named 'someName'.

## My Solution
 - Let's make detail and logic of SetCard stuff.
   - In the early task1, mentioned that game has Shpae, color, number, shading. So Let's make those in SetCard like PlayingCard

```objc
class SetCard.h ...

@interface SetCard : Card
@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *shading;

+(NSArray *)validShape;
+(NSArray *)validColor;
+(NSArray *)validShading;
+(NSArray *)maxNumber;

@end

class SetCard.m ...
#pragma mark - Shape
@synthesize shape = _shape;

+ (NSArray *)validShape {
    return @[@"ovals", @"squiggles", @"diamonds"]; // maybe added rectangles later?
}

- (void)setShape:(NSString *)shape {
    if ( [[SetCard validShape] containsObject:shape] ) {
        _shape = shape;
    }
}

- (NSString *)shape {
    return _shape ? _shape : @"?";
}

... 

same as color, shading

#pragma mark - maxNumer
+ (NSUInteger )maxNumber {
    return [[self validShape] count];
}

#pragma mark - contents
- (NSString *)contents {
    return [NSString stringWithFormat:@"%@ %@ %@ %d",self.shape, self.color, self.shading, (int)self.number];
}

```
 - When it comes to match method, I copy the m2mmtech [code](https://github.com/m2mtech/matchismo-2013-14/blob/assignment3task2/Matchismo/Model/SetCard.m).

 - make SetCardDeck init

 ```objc
  SetCardDeck.m ...
 - (instancetype)init
{
    self = [super init];
    if (self) {
        for( NSString *shape in [SetCard validShading]) {
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
 ```
 - make SetCardGameVC createDeck

 ```objc
 SetCardGameVC.m ...
 - (Deck *)createDeck {
    return [SetCardDeck new];
}

 ```