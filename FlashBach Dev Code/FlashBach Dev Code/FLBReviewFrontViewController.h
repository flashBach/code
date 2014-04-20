//
//  FLBCardViewController.h
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLBDataManagement.h"

@interface FLBReviewFrontViewController : UIViewController

// Buttons
@property (weak, nonatomic) IBOutlet UIButton *buttonFlip;
@property (weak, nonatomic) IBOutlet UIButton *buttonSkip;

@property (weak, nonatomic) NSMutableArray *cardsToReview;
@property (nonatomic)       NSDictionary    *myDict;


@end
