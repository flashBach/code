//
//  FLBCategoryViewController.h
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLBCardViewController.h"

@interface FLBCategoryViewController : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textNewCategory;
@property (nonatomic)       NSMutableArray  *categories;
@property (nonatomic)       NSString        *currentDeck;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (IBAction)addCategoryButtonPressed:(id)sender;

@end
