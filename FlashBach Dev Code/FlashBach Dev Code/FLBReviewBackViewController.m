//
//  FLBCardResultViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBReviewBackViewController.h"
#import "FLBDataManagement.h"
#import "FLBReviewFrontViewController.h"
#include <math.h>

#define maxFrequency 5
#define minFrequency 0

@implementation FLBReviewBackViewController

@synthesize cardID;
@synthesize dueCardsID;
@synthesize myDict;
@synthesize cardFrontTextView;
@synthesize cardBackTextView;
@synthesize dueTotal;
@synthesize dueCountsLabel;

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

- (void) updateUI
{
    
    NSMutableArray *cardAtKey = [NSMutableArray arrayWithArray:[myDict objectForKey:cardID]];
    NSString * cardFront = [cardAtKey objectAtIndex:2];
    NSString * cardBack = [cardAtKey objectAtIndex:3];
    cardFrontTextView.text = cardFront;
    cardBackTextView.text = cardBack;
    dueCountsLabel.text = [NSString stringWithFormat:@"%d Left/ %d Total", [dueCardsID count], dueTotal];
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
    _buttonHard.layer.borderColor = [[UIColor redColor]CGColor];
    _buttonHard.layer.cornerRadius = 7;
    
    _buttonEditCard.layer.borderWidth = 0.7f;
    _buttonEditCard.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonEditCard.layer.cornerRadius = 7;
}

- (IBAction)loadDestinationVC:(id)sender {
    if([dueCardsID count] == 0){
        
        [self performSegueWithIdentifier:@"BackToDecks" sender:nil];
    } else {
        [self performSegueWithIdentifier:@"BackToFront" sender:nil];
    }

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"ReviewToEdit"])
    {
        FLBAddCardViewController *addCardViewController = [segue destinationViewController];
        addCardViewController.cardID = cardID;
        addCardViewController.title = @"Edit Card";
    }
    
    if([[segue identifier] isEqualToString:@"BackToFront"])
    {
        FLBReviewFrontViewController *reviewFrontViewController = [segue destinationViewController];
        reviewFrontViewController.dueCardsID = dueCardsID;
        reviewFrontViewController.dueTotal = dueTotal;
    }

    if([[segue identifier] isEqualToString:@"NormalToFront"])
    {
        FLBReviewFrontViewController *reviewFrontViewController = [segue destinationViewController];
        reviewFrontViewController.dueCardsID = dueCardsID;
        reviewFrontViewController.dueTotal = dueTotal;
    }
    
    if([[segue identifier] isEqualToString:@"HardToFront"])
    {
        FLBReviewFrontViewController *reviewFrontViewController = [segue destinationViewController];
        reviewFrontViewController.dueCardsID = dueCardsID;
        reviewFrontViewController.dueTotal = dueTotal;
    }

}

#pragma mark - Data
- (IBAction)updateCard:(UIButton *)sender
{
    // Somehow we need to load myDict again!
    myDict = [FLBDataManagement loadCardDataDictionaryFromPlist];
    NSMutableArray *cardAtKey = [NSMutableArray arrayWithArray:[myDict objectForKey:cardID]];
    
    // Update frequency level
    NSNumber * frequency = [cardAtKey objectAtIndex:4];
    int value = [frequency intValue];
    
    if ([sender.currentTitle isEqualToString:@"Hard"] && value < maxFrequency)
    {
        NSNumber * newFrequency = [NSNumber numberWithInt:value + 1];
        [cardAtKey replaceObjectAtIndex:4 withObject:newFrequency];
    }

    if ([sender.currentTitle isEqualToString:@"Easy"] && value > minFrequency)
    {
        NSNumber * newFrequency = [NSNumber numberWithInt:value - 1];
        [cardAtKey replaceObjectAtIndex:4 withObject:newFrequency];

    }
    
    // Update due date
    frequency = [cardAtKey objectAtIndex:4];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    int daysFromToday = (int)pow(2, maxFrequency - [frequency intValue]);
    dayComponent.day = daysFromToday;
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * today = [NSDate date];
    NSDate * dueDate = [calendar dateByAddingComponents:dayComponent toDate:today options:0];
    [cardAtKey replaceObjectAtIndex:5 withObject:dueDate];
    
    [FLBDataManagement SaveCard:cardAtKey WithIndex:cardID];
}


@end
