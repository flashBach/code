//
//  FLBCategoryViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBCategoryViewController.h"

#define addNewCategoryAlertTag 0
#define deleteCategoryAlertTag 1

@implementation FLBCategoryViewController

@synthesize categories;
@synthesize currentDeck;
@synthesize createNewCategoryTextField;
@synthesize theNewCategoryName;
@synthesize myDict;
@synthesize textNewCategory;
@synthesize addNewCategory;
@synthesize deleteThisCategory;
@synthesize deleteCategoryAlert;

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
    
    self.navigationItem.title = currentDeck;
    
    // Allow keyboard to disappear on return press
    textNewCategory.delegate = self;
    
    [self setupDeleteSwipe];
    
    // Make sure new data appears
    [[self tableView] reloadData];
}

// The method called by the delegate to update the category view
- (void) newDeckIs: (NSString*) newDeck
{
    currentDeck = newDeck;
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



- (void) deleteCell:(NSString *) categoryToDelete
{
    myDict = [FLBDataManagement loadCardDataDictionaryFromPlist];
    NSMutableArray *cardsToDelete = [NSMutableArray new];
    
    for(id key in myDict)
    {
        NSMutableArray *cardAtKey = [NSMutableArray arrayWithArray:[myDict objectForKey:key]];
        NSString *deckAtKey = [cardAtKey objectAtIndex:0];
        NSString *categoryAtKey = [cardAtKey objectAtIndex:1];
        
        // Add each category in the deck
        if( [deckAtKey isEqualToString:currentDeck] &&
            [categoryAtKey isEqualToString:categoryToDelete])
        {
            [cardsToDelete addObject:key];
        }
    }
    
    [FLBDataManagement deleteCards:cardsToDelete];
    NSLog(@"Deleted cell with Deck: %@ and Category: %@ \n",currentDeck, categoryToDelete);
    
    [self viewDidLoad];
    [[self tableView] reloadData];
}

-(void)cellSwipe:(UISwipeGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:location];
    UITableViewCell *swipedCell  = [self.tableView cellForRowAtIndexPath:swipedIndexPath];
    
    deleteThisCategory = swipedCell.textLabel.text;
    
    // Initialize and display alert
    deleteCategoryAlert =
    [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Delete %@",  deleteThisCategory]
                               message:[NSString stringWithFormat:@"You will delete all cards in %@. Are you sure?", deleteThisCategory]
                              delegate:self
                     cancelButtonTitle:@"Cancel"
                     otherButtonTitles:@"Delete", nil];
    deleteCategoryAlert.tag = deleteCategoryAlertTag;
    [deleteCategoryAlert show];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"CategoryToCard"])
    {
        FLBCardViewController *cardViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        cardViewController.currentCategory = [categories objectAtIndex:indexPath.row];
        cardViewController.currentDeck = currentDeck;
        
        // warning can't be resolved by changing the type of the delgate
        // because the delegate's type cannot be set to the same type as self
        cardViewController.delegate = self;
    }
}
 

#pragma mark - Table-view Management

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [categories objectAtIndex:indexPath.row];
    
    return cell;
}

# pragma mark - Data Management

- (void) loadCardDataFromDictionary
{
    // Create view's perception of the categories we have available based on the cards.
    categories = [NSMutableArray array];
    for(id key in myDict)
    {
        NSMutableArray *cardAtKey = [NSMutableArray arrayWithArray:[myDict objectForKey:key]];
        NSString *deckAtKey = [cardAtKey objectAtIndex:0];
        NSString *categoryAtKey = [cardAtKey objectAtIndex:1];
        
        // Add each category in the deck
        if( ![categories containsObject:categoryAtKey] && [deckAtKey isEqualToString:currentDeck])
        {
            [categories addObject:categoryAtKey];
        }
    }
}

- (void) saveCard
{
    NSNumber *frequency = @5;
    NSDate *today = [NSDate date];
    
    NSMutableArray *newCard = [[NSMutableArray alloc] init];
    [newCard addObject:currentDeck];
    [newCard addObject:theNewCategoryName];
    [newCard addObject:@"Default"];
    [newCard addObject:@"Default"];
    [newCard addObject:frequency];
    [newCard addObject:today];
    
    [FLBDataManagement saveNewCard: newCard];
}

#pragma mark - Add New Category

- (IBAction)addCategoryButtonPressed:(id)sender {
    addNewCategory = [[UIAlertView alloc] initWithTitle:@"Create New Category"
                                                        message:@"Please enter the name of the new category:"
                                                        delegate:self
                                                        cancelButtonTitle:@"Save"
                                                        otherButtonTitles:@"Cancel",nil];
    
    addNewCategory.alertViewStyle = UIAlertViewStylePlainTextInput;
    addNewCategory.tag = addNewCategoryAlertTag;
    createNewCategoryTextField = [addNewCategory textFieldAtIndex:0];
    createNewCategoryTextField.keyboardType = UIKeyboardTypeAlphabet;
    createNewCategoryTextField.placeholder = @"Enter new category name";
    
    [addNewCategory show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == addNewCategoryAlertTag)
    {
        if ([createNewCategoryTextField.text length] <= 0 || buttonIndex == 1)
        {
            return; //If cancel or 0 length string the string doesn't matter
        }
        
        theNewCategoryName = createNewCategoryTextField.text;
        
        [self saveCard];
        
        // Reload the view to show the new category
        myDict = [FLBDataManagement loadCardDataDictionaryFromPlist];
        [self loadCardDataFromDictionary];
        [self.tableView reloadData];
    }

    else if (alertView.tag == deleteCategoryAlertTag)
    {
        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
        
        if([title isEqualToString:@"Cancel"])
        {
            NSLog(@"Cancel was selected.");
        }
        else if([title isEqualToString:@"Delete"])
        {
            NSLog(@"Delete was selected.");
            [self deleteCell:deleteThisCategory];
        }
    }
    
}

// Is called on textField when Return/Done is pressed to dismiss keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
