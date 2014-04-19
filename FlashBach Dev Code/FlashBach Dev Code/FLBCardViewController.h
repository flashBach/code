//
//  FLBCardViewController.h
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLBAddCardViewController.h"

@interface FLBCardViewController : UITableViewController

@property (nonatomic) NSDictionary *myDict;        
@property (nonatomic) NSString *currentDeck;
@property (nonatomic) NSString *currentCategory;

@property (nonatomic) NSMutableArray *cardPrompts;
@property (nonatomic) NSMutableArray *cardKeys;

- (void) loadCardDataFromPlist;

@end
