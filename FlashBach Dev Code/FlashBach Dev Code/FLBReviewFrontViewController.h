//
//  FLBCardViewController.h
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLBReviewFrontViewController : UIViewController

// Buttons
@property (weak, nonatomic) IBOutlet UIButton *buttonFlip;
@property (weak, nonatomic) IBOutlet UIButton *buttonSkip;

// Data
@property (strong, nonatomic) NSMutableArray * dueCardsID;
@property (strong, nonatomic) NSNumber * cardID;
@property (weak, nonatomic) NSDictionary * myDict;

// View
@property (weak, nonatomic) IBOutlet UITextView *cardFrontTextView;
@property (weak, nonatomic) IBOutlet UILabel *dueCountsLabel;

@end
