//
//  FLBCardViewController.h
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLBAddCardViewController.h"
#import "FLBDataManagement.h"

@interface FLBCardViewController : UITableViewController

// Data
@property (nonatomic) NSDictionary   *myDict;
@property (nonatomic) NSString       *currentDeck;
@property (nonatomic) NSString       *currentCategory;
@property (nonatomic) NSMutableArray *cardPrompts;
@property (nonatomic) NSMutableArray *cardKeys;

// Needed here to allow auto-refresh to work
- (void) loadCardDataFromDictionary;

@end
