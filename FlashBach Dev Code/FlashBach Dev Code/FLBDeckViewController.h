//
//  FLBDeckViewController.h
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLBDeckViewController : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textNewDeck;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
@end
