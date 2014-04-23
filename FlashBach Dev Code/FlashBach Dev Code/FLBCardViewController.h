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
#import "FLBCategoryViewController.h"

// Allows for updating the categories view
//http://stackoverflow.com/questions/19844727/objective-c-storyboards-segue-passing-data-from-destination-back-to-sourceview
@protocol DataUpdateDelegate <NSObject>

- (void) newDeckIs: (NSString*) newDeck;

@end

@interface FLBCardViewController : UITableViewController

// Data
@property (nonatomic) NSDictionary   *myDict;
@property (nonatomic) NSString       *currentDeck;
@property (nonatomic) NSString       *currentCategory;
@property (nonatomic) NSMutableArray *cardPrompts;
@property (nonatomic) NSMutableArray *cardKeys;

// Handle updating the Categories view
@property id<DataUpdateDelegate>delegate;

// Needed here to allow auto-refresh to work
- (void) loadCardDataFromDictionary;

@end


