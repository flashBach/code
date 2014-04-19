//
//  FLBAddCardViewController.h
//  FlashBach Dev Code
//
//  Created by Xiaofan Fang on 3/3/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLBCardViewController.h"
#import "FLBDataManagement.h"

@interface FLBAddCardViewController : UIViewController <UITextFieldDelegate>

// Text fields
@property (weak, nonatomic) IBOutlet UITextField *textCardFront;
@property (weak, nonatomic) IBOutlet UITextField *textCardBack;
@property (nonatomic, strong) IBOutlet UITextField *textChooseDeck;
@property (nonatomic, strong) IBOutlet UITextField *textChooseCategory;

// Buttons
@property (weak, nonatomic) IBOutlet UIButton *buttonDeck;
@property (weak, nonatomic) IBOutlet UIButton *buttonCategory;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;

// Scroll View
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

// Card Data
@property (retain, nonatomic) NSMutableArray *entryFields;
@property (strong, nonatomic) NSMutableArray *myDecks;
@property (weak, nonatomic) NSNumber *cardID;
@property (weak, nonatomic) NSString *currentDeck;
@property (weak, nonatomic) NSString *currentCategory;
@property (weak, nonatomic) NSMutableArray *currentCardData;
@property (weak, nonatomic) NSDictionary * myDict;

// Methods
- (IBAction) deckButtonTapped:(id)sender;
- (IBAction) categoryButtonTapped:(id)sender;
- (IBAction) saveButtonTapped:(id)sender;
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL) textFieldShouldReturn:(UITextField *)textField;

@end
