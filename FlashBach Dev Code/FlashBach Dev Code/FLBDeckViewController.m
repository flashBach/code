//
//  FLBDeckViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBDeckViewController.h"

@implementation FLBDeckViewController

@synthesize autocompleteValuesDisplay;
@synthesize autocompleteTableView;
@synthesize autocompleteValuesArray;
@synthesize decks;
@synthesize theNewDeckName;
@synthesize alertTextField;
@synthesize myDict;
@synthesize addNewDeck;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    myDict = [FLBDataManagement loadCardDataDictionaryFromPlist];
    
    [self loadCardDataFromDictionary];
    
    // Allow dismissing keyboard
    _textNewDeck.delegate = self;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"DeckToCategory"])
    {
        FLBCategoryViewController *categoryViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        categoryViewController.currentDeck = [decks objectAtIndex:indexPath.row];
    }
    if([[segue identifier] isEqualToString:@"DeckToReview"])
    {
        FLBCategoryViewController *categoryViewController = [segue destinationViewController];
        categoryViewController.cardsToReview = [self generateDueCards];
    }
}


#pragma mark - Table-View Management

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [decks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [decks objectAtIndex:indexPath.row];
    
    return cell;
}

- (void) loadCardDataFromDictionary
{
    // Create view's perception of the decks we have available based on the cards.
    decks = [NSMutableArray array];
    for(id key in myDict)
    {
        NSMutableArray *cardAtKey = [NSMutableArray arrayWithArray:[myDict objectForKey:key]];
        NSString *deckAtKey = [cardAtKey objectAtIndex:0];
        
        // For each new deck, add it to the list of decks
        if( ![decks containsObject:deckAtKey] )
        {
            [decks addObject:deckAtKey];
        }
    }
}

#pragma mark - Data Management

- (void) saveCard
{
    NSNumber *frequency = @5;
    NSDate *today = [NSDate date];
    
    NSMutableArray *newCard = [[NSMutableArray alloc] init];
    [newCard addObject:theNewDeckName];
    [newCard addObject:@"Default"];
    [newCard addObject:@"Default"];
    [newCard addObject:@"Default"];
    [newCard addObject:frequency];
    [newCard addObject:today];
    
    [FLBDataManagement saveNewCard:newCard];
}

- (NSMutableArray *) generateDueCards
{
    NSMutableArray * dueCards = [[NSMutableArray alloc]init];
    
    for (id key in myDict)
    {
        NSMutableArray *cardAtKey = [NSMutableArray arrayWithArray:[myDict objectForKey:key]];
        NSDate *dateAtKey = [cardAtKey objectAtIndex:5];
        
        NSDate * today = [NSDate date];
        if ([dateAtKey compare:today] == NSOrderedAscending)
        {
            [dueCards addObject:key];
        }
    }
    
    return dueCards;
}


#pragma mark - Add New Deck
// Add new deck
// http://stackoverflow.com/questions/6319417/whats-a-simple-way-to-get-a-text-input-popup-dialog-box-on-an-iphone
- (IBAction)addDeckButtonPressed:(id)sender
{
    addNewDeck = [[UIAlertView alloc] initWithTitle:@"Create New Deck" message:@"Please enter the name of the new deck:" delegate:self cancelButtonTitle:@"Save" otherButtonTitles:nil];
    addNewDeck.alertViewStyle = UIAlertViewStylePlainTextInput;
    alertTextField = [addNewDeck textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeAlphabet;
    alertTextField.placeholder = @"Enter new deck name";
    [addNewDeck show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if ([alertTextField.text length] <= 0 )
    {
        return; //If cancel or 0 length string the string doesn't matter
    }
   
    theNewDeckName = alertTextField.text;
    
    [self saveCard];
    
    myDict = [FLBDataManagement loadCardDataDictionaryFromPlist];
    [self loadCardDataFromDictionary];
    [self.tableView reloadData];
}

// Is called on textField when Return/Done is pressed to dismiss keyboard
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField) {
        [textField resignFirstResponder];
    }
    
    return NO;
}

@end
