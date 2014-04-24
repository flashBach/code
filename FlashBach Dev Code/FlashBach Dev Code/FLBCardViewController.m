//
//  FLBCardViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBCardViewController.h"

@implementation FLBCardViewController

@synthesize cardPrompts;
@synthesize cardKeys;
@synthesize currentDeck;
@synthesize currentCategory;
@synthesize myDict;

#pragma mark - Initialization

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    myDict = [FLBDataManagement loadCardDataDictionaryFromPlist];
    [self loadCardDataFromDictionary];
    
    self.navigationItem.title = currentCategory;
    
    [self setupDeleteSwipe];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

#pragma mark - Delete Deck
// Swiping reference: // http://stackoverflow.com/questions/7144592/getting-cell-indexpath-on-swipe-gesture-uitableview

- (void) setupDeleteSwipe
{
    UISwipeGestureRecognizer *showExtrasSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipe:)];
    showExtrasSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tableView addGestureRecognizer:showExtrasSwipe];
}

-(void)cellSwipe:(UISwipeGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:location];
    
    NSNumber *cardIDToDelete = [cardKeys objectAtIndex:swipedIndexPath.row];
    
    [FLBDataManagement deleteCard:cardIDToDelete];

    [self viewDidLoad];
    [[self tableView] reloadData];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"CardToEdit"] || [[segue identifier] isEqualToString:@"CardToNewCard"])
    {
        FLBAddCardViewController *addOrEditCardViewController = [segue destinationViewController];
    
        addOrEditCardViewController.currentCategory = currentCategory;
        addOrEditCardViewController.currentDeck = currentDeck;
        
        if([[segue identifier] isEqualToString:@"CardToEdit"])
        {
            NSIndexPath *selectedCard = [self.tableView indexPathForSelectedRow];
            addOrEditCardViewController.cardID = [cardKeys objectAtIndex:selectedCard.row];
            addOrEditCardViewController.title = @"Edit Card";
        }
        
        else if([[segue identifier] isEqualToString:@"CardToNewCard"])
        {
            addOrEditCardViewController.title = @"Add Card";
        }
    }
}

// Called when the leaving the controller
// Triggers an update of the category view
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
        [self.delegate newDeckIs:currentDeck];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

// Need this here to tell the add/edit view where to return to after hitting save
- (IBAction)unwindToCards:(UIStoryboardSegue *) segue
{
    // nothing needed here
}


#pragma mark - Table-View Management

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [cardPrompts count];
}

// Load the cells in the table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [cardPrompts objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Data Management

// Create view's perception of the decks we have available based on the cards.
- (void) loadCardDataFromDictionary
{
    cardPrompts = [NSMutableArray array];
    cardKeys = [NSMutableArray array];
    
    for(id key in myDict)
    {
        NSMutableArray *cardAtKey = [NSMutableArray arrayWithArray:[myDict objectForKey:key]];
        
        NSString *deckAtKey = [cardAtKey objectAtIndex:0];
        NSString *categoryAtKey = [cardAtKey objectAtIndex:1];
        NSString *cardPromptAtKey = [cardAtKey objectAtIndex:2];
        
        // Get all cards in the current deck and category
        if( ![cardPrompts containsObject:categoryAtKey] && [deckAtKey isEqualToString:currentDeck] && [categoryAtKey isEqualToString:currentCategory])
        {
            [cardPrompts addObject:cardPromptAtKey];
            [cardKeys addObject:key];
        }
    }
}

@end
