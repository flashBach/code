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

@interface FLBDeckViewController : UITableViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textNewDeck;

@property (nonatomic, retain)   UITableView    *autocompleteTableView;
@property (nonatomic, retain)   NSMutableArray *autocompleteValuesArray;
@property (nonatomic, retain)   NSMutableArray *autocompleteValuesDisplay;
@property (nonatomic)           NSMutableArray *decks;
@property (nonatomic)           UITextField    *alertTextField;
// can't start with "new" or there are struggles
@property (nonatomic)           NSString       *theNewDeckName;
@property (nonatomic)       NSDictionary    *myDict;


- (void)loadCardDataFromDictionary;
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;
- (IBAction)addDeckButtonPressed:(id)sender;


@end
