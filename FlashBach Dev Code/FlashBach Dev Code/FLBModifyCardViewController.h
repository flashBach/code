//
//  FLBModifyCardViewController.h
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLBModifyCardViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFront;
@property (weak, nonatomic) IBOutlet UITextField *textBack;

@property (weak, nonatomic) IBOutlet UITextField *textNewDeck;
@property (weak, nonatomic) IBOutlet UITextField *textNewCategory;
@property (weak, nonatomic) IBOutlet UIButton *buttonDone;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) NSMutableArray *entryFields;

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL) textFieldShouldReturn:(UITextField *)textField;

@end
