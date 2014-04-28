//
//  FLBCategoryViewController.h
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLBCardViewController.h"
#import "FLBDataManagement.h"

@interface FLBCategoryViewController : UITableViewController <UITextFieldDelegate, UIAlertViewDelegate>

// Used in created a new category
@property (nonatomic)       UIAlertView          * addNewCategory;
@property (nonatomic)       UITextField          *createNewCategoryTextField;
@property (nonatomic)       NSString             *theNewCategoryName;
@property (weak, nonatomic) IBOutlet UITextField *textNewCategory;

// Used in deleting a category
@property (nonatomic)           UIAlertView    *deleteCategoryAlert;
@property (weak, nonatomic) NSString * deleteThisCategory;

// Data
@property (nonatomic)       NSMutableArray  *categories;
@property (nonatomic)       NSString        *currentDeck;
@property (nonatomic)       NSDictionary    *myDict;

// Handle button press
- (IBAction)addCategoryButtonPressed:(id)sender;

@end
