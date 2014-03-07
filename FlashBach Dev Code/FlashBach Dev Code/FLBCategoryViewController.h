//
//  FLBCategoryViewController.h
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLBCategoryViewController : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textNewCategory;


- (BOOL)textFieldShouldReturn:(UITextField *)textField;
@end
