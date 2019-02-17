//
//  ViewController.h
//  matchismo
//
//  Created by rhino Q on 11/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
// Abstract class. Must implement methods as describes below.

#import <UIKit/UIKit.h>
#import "Model/Deck.h"
@interface CardGameViewController : UIViewController
//protected
// for subclasses
-(Deck *) createDeck; // abstract

@end

