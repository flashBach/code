//
//  FLBDeckViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBDeckViewController.h"
#import "FLBReviewFrontViewController.h"

#define addNewDeckAlertTag 0
#define deleteDeckAlertTag 1

@implementation FLBDeckViewController

@synthesize autocompleteValuesDisplay;
@synthesize autocompleteTableView;
@synthesize autocompleteValuesArray;
@synthesize decks;
@synthesize theNewDeckName;
@synthesize alertTextField;
@synthesize myDict;
@synthesize addNewDeck;
@synthesize deleteDeckAlert;
@synthesize deleteThisDeck;

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
    
    [self setupDeleteSwipe];
    
    [self.tableView reloadData];
}

// Ensures that the view updates each time it is seen
- (void) viewWillAppear:(BOOL)animated
{
    [self viewDidLoad];
}

#pragma mark - Delete Deck
// Swiping reference: // http://stackoverflow.com/questions/7144592/getting-cell-indexpath-on-swipe-gesture-uitableview

- (void) setupDeleteSwipe
{
    UISwipeGestureRecognizer *showExtrasSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipe:)];
    showExtrasSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tableView addGestureRecognizer:showExtrasSwipe];
}

-(void)deleteCell:(NSString *) deckToDelete
{
    myDict = [FLBDataManagement loadCardDataDictionaryFromPlist];
    NSMutableArray *cardsToDelete = [NSMutableArray new];

    for(id key in myDict)
    {
        NSMutableArray *cardAtKey = [NSMutableArray arrayWithArray:[myDict objectForKey:key]];
        NSString *deckAtKey = [cardAtKey objectAtIndex:0];
        
        // Add each category in the deck
        if( [deckAtKey isEqualToString:deckToDelete])
        {
            [cardsToDelete addObject:key];
        }
    }

    [FLBDataManagement deleteCards:cardsToDelete];
    NSLog(@"Deleted cell with Deck: %@\n", deckToDelete);
    
    [self viewWillAppear:true];
}

-(void)cellSwipe:(UISwipeGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:location];
    UITableViewCell *swipedCell  = [self.tableView cellForRowAtIndexPath:swipedIndexPath];
    
    deleteThisDeck = swipedCell.textLabel.text;
    
    // Initialize and display alert
    deleteDeckAlert =
    [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Delete %@",  deleteThisDeck]
                               message:[NSString stringWithFormat:@"You will delete all categories and all cards in %@. Are you sure?", deleteThisDeck]
                              delegate:self
                     cancelButtonTitle:@"Cancel"
                     otherButtonTitles:@"Delete", nil];
    deleteDeckAlert.tag = deleteDeckAlertTag;
    [deleteDeckAlert show];
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"DeckToCategory"])
    {
        FLBCategoryViewController *categoryViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        categoryViewController.currentDeck = [decks objectAtIndex:indexPath.row];
    }

    if([[segue identifier] isEqualToString:@"DeckToFront"])
    {
        FLBReviewFrontViewController *reviewFrontViewController = [segue destinationViewController];
        NSMutableArray * dueCardsID = [self generateDueCards];
        reviewFrontViewController.dueCardsID = dueCardsID;
        reviewFrontViewController.dueTotal = [dueCardsID count];
    }
}


#pragma mark - Table-View Management

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    NSMutableArray * dueCardsID = [[NSMutableArray alloc]init];
    
    for (id key in myDict)
    {
        NSMutableArray *cardAtKey = [NSMutableArray arrayWithArray:[myDict objectForKey:key]];
        NSLog(@"Key: %d, Deck: %@", (int)key, [cardAtKey objectAtIndex:1]);
        NSDate *dateAtKey = [cardAtKey objectAtIndex:5];
        
        NSDate * today = [NSDate date];
        if ([dateAtKey compare:today] == NSOrderedAscending)
        {
            [dueCardsID addObject:key];
        }
    }
    
    return dueCardsID;
}


#pragma mark - Add New Deck
// Add new deck
// http://stackoverflow.com/questions/6319417/whats-a-simple-way-to-get-a-text-input-popup-dialog-box-on-an-iphone
- (IBAction)addDeckButtonPressed:(id)sender
{
    addNewDeck = [[UIAlertView alloc] initWithTitle:@"Create New Deck" message:@"Please enter the name of the new deck:" delegate:self cancelButtonTitle:@"Save" otherButtonTitles:@"Cancel", nil];
    addNewDeck.tag = addNewDeckAlertTag;
    addNewDeck.alertViewStyle = UIAlertViewStylePlainTextInput;
    alertTextField = [addNewDeck textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeAlphabet;
    alertTextField.placeholder = @"Enter new deck name";
    [addNewDeck show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // We use tags to differentiate all the
    // alerts in current viewController.
    if (alertView.tag == addNewDeckAlertTag)
    {
        if ([alertTextField.text length] <= 0 || buttonIndex == 1 )
        {
            return; //If cancel or 0 length string the string doesn't matter
        }
       
        theNewDeckName = alertTextField.text;
        
        [self saveCard];
        
        myDict = [FLBDataManagement loadCardDataDictionaryFromPlist];
        [self loadCardDataFromDictionary];
        [self.tableView reloadData];
    }
    
    else if (alertView.tag == deleteDeckAlertTag)
    {
        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
        
        if([title isEqualToString:@"Cancel"])
        {
            NSLog(@"Cancel was selected.");
        }
        else if([title isEqualToString:@"Delete"])
        {
            NSLog(@"Delete was selected.");
            [self deleteCell:deleteThisDeck];
        }
    }
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
