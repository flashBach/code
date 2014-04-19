//
//  FLBCategoryViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBCategoryViewController.h"

@implementation FLBCategoryViewController

@synthesize categories;
@synthesize currentDeck;
@synthesize alertTextField;
@synthesize theNewCategoryName;
@synthesize myDict;

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
    _textNewCategory.delegate = self;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"CategoryToCard"])
    {
        FLBCardViewController *cardViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        cardViewController.currentCategory = [categories objectAtIndex:indexPath.row];
        cardViewController.currentDeck = currentDeck;
    }
}

 

#pragma mark - Table-view Management

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
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
    // Create view's perception of the decks we have available based on the cards.
    categories = [NSMutableArray array];
    for(id key in myDict)
    {
        NSMutableArray *cardAtKey = [NSMutableArray arrayWithArray:[myDict objectForKey:key]];
        NSString *deckAtKey = [cardAtKey objectAtIndex:0];
        NSString *categoryAtKey = [cardAtKey objectAtIndex:1];
        // For each new deck, add it to the list of decks
        if( ![categories containsObject:categoryAtKey] && [deckAtKey isEqualToString:currentDeck])
        {
            [categories addObject:categoryAtKey];
        }
    }
}

// Is called when a background touch occurs, dismisses any open keyboard
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textNewCategory resignFirstResponder];
}

- (IBAction)addCategoryButtonPressed:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Create New Category" message:@"Please enter the name of the new category:" delegate:self cancelButtonTitle:@"Save" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeAlphabet;
    alertTextField.placeholder = @"Enter new category name";
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ([alertTextField.text length] <= 0 )
    {
        return; //If cancel or 0 length string the string doesn't matter
    }
    
    theNewCategoryName = alertTextField.text;
    
    [self saveCard];
    
    myDict = [FLBDataManagement loadCardDataDictionaryFromPlist];
    [self loadCardDataFromDictionary];
    [self.tableView reloadData];
}

- (void) saveCard
{
    NSNumber *difficulty = @0;
    NSDate *today = [NSDate date];
    
    NSMutableArray *newCard = [[NSMutableArray alloc] init];
    [newCard addObject:currentDeck];
    [newCard addObject:theNewCategoryName];
    [newCard addObject:@"Default"];
    [newCard addObject:@"Default"];
    [newCard addObject:difficulty];
    [newCard addObject:today];
    
    [FLBDataManagement saveNewCard: newCard];
}


// Is called on textField when Return/Done is pressed to dismiss keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
