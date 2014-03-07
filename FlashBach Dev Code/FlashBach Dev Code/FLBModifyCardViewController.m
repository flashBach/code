//
//  FLBModifyCardViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBModifyCardViewController.h"

@interface FLBModifyCardViewController ()

@end

@implementation FLBModifyCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Allow keyboard to disappear upon return press.
    _textNewCategory.delegate = self;
    _textNewDeck.delegate = self;
    
    // Change return key to be "done"
    [_textNewCategory setReturnKeyType:UIReturnKeyDone];
    [_textNewDeck setReturnKeyType:UIReturnKeyDone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
