//
//  FLBReviewBackViewController.h
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLBAddCardViewController.h"



@interface FLBReviewBackViewController : UIViewController

// Buttons
@property (weak, nonatomic) IBOutlet UIButton *buttonHard;
@property (weak, nonatomic) IBOutlet UIButton *buttonNormal;
@property (weak, nonatomic) IBOutlet UIButton *buttonEasy;
@property (weak, nonatomic) IBOutlet UIButton *buttonEditCard;

// View
@property (weak, nonatomic) IBOutlet UITextView *cardFrontTextView;
@property (weak, nonatomic) IBOutlet UITextView *cardBackTextView;
@property (weak, nonatomic) IBOutlet UILabel *dueCountsLabel;

// Data
@property (strong, nonatomic) NSMutableArray * dueCardsID;
@property (nonatomic) NSUInteger dueTotal;
@property (weak, nonatomic) NSNumber * cardID;
@property (weak, nonatomic) NSDictionary * myDict;



@end
