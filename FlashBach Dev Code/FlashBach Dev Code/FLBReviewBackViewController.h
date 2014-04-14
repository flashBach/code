//
//  FLBCardResultViewController.h
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLBAddCardViewController.h"

@interface FLBReviewBackViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *buttonHard;
@property (weak, nonatomic) IBOutlet UIButton *buttonNormal;
@property (weak, nonatomic) IBOutlet UIButton *buttonEasy;
@property (weak, nonatomic) IBOutlet UIButton *buttonEditCard;
@property (nonatomic) NSMutableArray *cardKeys;


@end
