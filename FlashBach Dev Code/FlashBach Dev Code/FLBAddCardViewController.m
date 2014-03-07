//
//  FLBAddCardViewController.m
//  FlashBach Dev Code
//
//  Created by Xiaofan Fang on 3/3/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBAddCardViewController.h"

@interface FLBAddCardViewController ()

@end

@implementation FLBAddCardViewController

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
    _buttonDeck.layer.borderWidth = 0.7f;
    _buttonDeck.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonDeck.layer.cornerRadius = 7;
   
    // Add border to button
    _buttonCategory.layer.borderWidth = 0.7f;
    _buttonCategory.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonCategory.layer.cornerRadius = 7;
    
    // Add border to button
    _buttonAddCard.layer.borderWidth = 0.7f;
    _buttonAddCard.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonAddCard.layer.cornerRadius = 7;
    
    // Set textField delegate to let keyboard disappear on hitting Return
    _textCardFront.delegate = self;
    _textCardBack.delegate = self;
    _textChooseCategory.delegate = self;
    _textChooseDeck.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) deckButtonTapped:(id)sender
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Choose Deck"                                                        delegate:self
                                           cancelButtonTitle:@"Cancel"                                              destructiveButtonTitle:@"Dismiss"
                                           otherButtonTitles:@"CS 5", @"CS 70", @"CS 81",@"CS 105", nil];

[action  showInView:self.view];
}

- (IBAction) categoryButtonTapped:(id)sender
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Choose Category"                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"                                              destructiveButtonTitle:@"Dismiss"
                                               otherButtonTitles:@"Recursion", @"Pointers", @"Linked Lists", @"Trees", @"Hashtables", nil];
    
    [action  showInView:self.view];
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textCardFront resignFirstResponder];
    [_textCardBack resignFirstResponder];
    [_textChooseCategory resignFirstResponder];
    [_textChooseDeck resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField) {
        [textField resignFirstResponder];
    }
    
    return NO;
}

@end
