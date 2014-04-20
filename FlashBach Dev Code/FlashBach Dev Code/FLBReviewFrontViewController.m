//
//  FLBCardViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBReviewFrontViewController.h"

@implementation FLBReviewFrontViewController

@synthesize cardsToReview;
@synthesize myDict;


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
    
    
    [self updateText];
    
    
    
    
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"FronttoBack"])
    {
        FLBCategoryViewController *categoryViewController = [segue destinationViewController];
        
    }
}

- (void)updateText
{
    NSMutableArray *cardAtKey = [NSMutableArray arrayWithArray:[myDict objectForKey:cardsToReview[0]]];
    NSString *cardPromptAtKey = [cardAtKey objectAtIndex:2];
    
}

@end
