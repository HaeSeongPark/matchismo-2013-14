//
//  ViewController.h
//  matchismo
//
//  Created by rhino Q on 11/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
// Abstract class. Must implement methods as describes below.

#import <UIKit/UIKit.h>
#import "Deck.h"
@interface CardGameViewController : UIViewController
//protected
// for subclasses
-(Deck *) createDeck; // abstract

-(NSAttributedString *)titleForCard: (Card*)card;
-(UIImage *)backgroundImageForCard:(Card *)card;
-(void)updateUI;
@property (weak, nonatomic) IBOutlet UILabel *resultsDescription;
@property (strong, nonatomic) NSMutableArray* resultHistory;


@end

