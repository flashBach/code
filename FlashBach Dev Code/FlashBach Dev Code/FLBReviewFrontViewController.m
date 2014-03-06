//
//  FLBCardViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBReviewFrontViewController.h"

@interface FLBReviewFrontViewController ()

@end

@implementation FLBReviewFrontViewController

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
    _buttonFlip.layer.borderWidth = 0.7f;
    _buttonFlip.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonFlip.layer.cornerRadius = 7;
    
    // Add border to button
    _buttonSkip.layer.borderWidth = 0.7f;
    _buttonSkip.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonSkip.layer.cornerRadius = 7;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
