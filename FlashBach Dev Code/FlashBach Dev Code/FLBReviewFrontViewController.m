//
//  FLBCardViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBReviewFrontViewController.h"

@implementation FLBReviewFrontViewController

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addButtonBorders];
}

- (void) addButtonBorders
{
    _buttonFlip.layer.borderWidth = 0.7f;
    _buttonFlip.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonFlip.layer.cornerRadius = 7;
    
    _buttonSkip.layer.borderWidth = 0.7f;
    _buttonSkip.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonSkip.layer.cornerRadius = 7;
}

@end
