//
//  FLBCardResultViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBReviewBackViewController.h"

@interface FLBReviewBackViewController ()

@end

@implementation FLBReviewBackViewController

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
    
    // Add border to button
    _buttonEasy.layer.borderWidth = 0.7f;
    _buttonEasy.layer.borderColor = [[UIColor greenColor]CGColor];
    _buttonEasy.layer.cornerRadius = 7;
    
    // Add border to button
    _buttonNormal.layer.borderWidth = 0.7f;
    _buttonNormal.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonNormal.layer.cornerRadius = 7;
    
    // Add border to button
    _buttonHard.layer.borderWidth = 0.7f;
    _buttonHard.layer.borderColor = [[UIColor redColor]CGColor];
    _buttonHard.layer.cornerRadius = 7;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
