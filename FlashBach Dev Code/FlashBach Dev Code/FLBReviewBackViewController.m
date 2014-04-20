//
//  FLBCardResultViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBReviewBackViewController.h"

@implementation FLBReviewBackViewController

@synthesize cardID;

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
    _buttonEasy.layer.borderWidth = 0.7f;
    _buttonEasy.layer.borderColor = [[UIColor greenColor]CGColor];
    _buttonEasy.layer.cornerRadius = 7;
    
    _buttonNormal.layer.borderWidth = 0.7f;
    _buttonNormal.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonNormal.layer.cornerRadius = 7;
    
    _buttonHard.layer.borderWidth = 0.7f;
    _buttonHard.layer.borderColor = [[UIColor purpleColor]CGColor];
    _buttonHard.layer.cornerRadius = 7;
    
    _buttonEditCard.layer.borderWidth = 0.7f;
    _buttonEditCard.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonEditCard.layer.cornerRadius = 7;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"ReviewToEdit"])
    {
        FLBAddCardViewController *addCardViewController = [segue destinationViewController];
        
        // TODO update the current cardID whenever entering review.
        // TODO once there is a cardID member present, uncomment the following line and the edit card button should work
        // addCardViewController.cardID = cardID;
    }
}

@end
