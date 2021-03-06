//
//  FLBDeckViewController.h
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLBCategoryViewController.h"
#import "FLBDataManagement.h"

@interface FLBDeckViewController : UITableViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

// Used in creating a new deck
@property (weak, nonatomic) IBOutlet UITextField *textNewDeck;
@property (nonatomic)           UITextField    *alertTextField;
@property (nonatomic)           NSString       *theNewDeckName; // can't start with "new" or there are struggles
@property (nonatomic)           UIAlertView    *addNewDeck;

// Used in deleting a deck
@property (nonatomic)           UIAlertView    *deleteDeckAlert;
@property (weak, nonatomic) NSString * deleteThisDeck;

// Data
@property (nonatomic)           NSMutableArray *decks;
@property (nonatomic)       NSDictionary    *myDict;
@property (strong, nonatomic) NSMutableArray * dueCardsID;

// Autocomplete Stuff
@property (nonatomic, retain)   UITableView    *autocompleteTableView;
@property (nonatomic, retain)   NSMutableArray *autocompleteValuesArray;
@property (nonatomic, retain)   NSMutableArray *autocompleteValuesDisplay;

- (NSMutableArray *) generateDueCards;
- (void)loadCardDataFromDictionary;
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;
- (IBAction)addDeckButtonPressed:(id)sender;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
