//
//  FLBCardViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBReviewFrontViewController.h"
#import "FLBDataManagement.h"
#import "FLBReviewBackViewController.h"

@implementation FLBReviewFrontViewController

@synthesize dueCardsID;
@synthesize cardID;
@synthesize myDict;
@synthesize cardFrontTextView;

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    myDict = [FLBDataManagement loadCardDataDictionaryFromPlist];
    [self addButtonBorders];
    
    [self updateUI];
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

- (void) updateUI
{
    NSLog(@"dueCardsID count: %d",[dueCardsID count]);
    if ([dueCardsID count])
    {
        cardID = dueCardsID[0];
        
        NSMutableArray *cardAtKey = [NSMutableArray arrayWithArray:[myDict objectForKey:cardID]];
        NSString * cardFront = [cardAtKey objectAtIndex:2];
        cardFrontTextView.text = cardFront;
    }
}

#pragma mark - Navigation
// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"FrontToBack"])
    {
        FLBReviewBackViewController *reviewBackViewController = [segue destinationViewController];
        [dueCardsID removeObjectAtIndex:0];
        reviewBackViewController.dueCardsID = dueCardsID;
        reviewBackViewController.cardID = cardID;
        
    }
    
}



@end
