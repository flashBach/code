//
//  FLBCardViewController.h
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLBCardViewController : UITableViewController

@property (nonatomic) NSMutableArray *cardPrompts;
@property (nonatomic) NSString *currentDeck;
@property (nonatomic) NSString *currentCategory;

@end
