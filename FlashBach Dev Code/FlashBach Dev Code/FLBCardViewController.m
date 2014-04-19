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
    
    [self loadCardDataFromPlist];
    
    self.navigationItem.title = currentCategory;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"CardToEdit"])
    {
        FLBAddCardViewController *editCardViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        editCardViewController.cardID = [cardKeys objectAtIndex:indexPath.row];
        editCardViewController.title = @"Edit Card";
        editCardViewController.currentCategory = currentCategory;
        editCardViewController.currentDeck = currentDeck;
    }
    else if([[segue identifier] isEqualToString:@"CardToNewCard"])
    {
        FLBAddCardViewController *addCardViewController = [segue destinationViewController];
        addCardViewController.title = @"Add Card";
        addCardViewController.currentCategory = currentCategory;
        addCardViewController.currentDeck = currentDeck;
    }
}

// Need this here to tell the add/edit view where to return to after hitting save
- (IBAction)unwindToCards:(UIStoryboardSegue *) segue
{
}


#pragma mark - Table-View Management

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [cardPrompts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [cardPrompts objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Data Management

- (void) loadCardDataFromPlist
{
    // Loads data from Documents or Bundle Directory
    //     First, try the mutable Documents Directory...
	NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [paths objectAtIndex:0];
	NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"CardData.plist"];
    
	//     Check to see if we found the CardData.plist file...
	if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
	{
		// If not in documents, get property list from main bundle and load in.
		plistPath = [[NSBundle mainBundle] pathForResource:@"CardData" ofType:@"plist"];
	}
	
	// Read property list into memory as an NSData object
	NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
	NSString *errorDesc = nil;
	NSPropertyListFormat format;
	// Convert static property liost into dictionary object
	myDict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
	if (!myDict)
	{
		NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
	}
    
    // Create view's perception of the decks we have available based on the cards.
    cardPrompts = [NSMutableArray array];
    cardKeys = [NSMutableArray array];
    for(id key in myDict)
    {
        NSMutableArray *cardAtKey = [NSMutableArray arrayWithArray:[myDict objectForKey:key]];
        NSString *deckAtKey = [cardAtKey objectAtIndex:0];
        NSString *categoryAtKey = [cardAtKey objectAtIndex:1];
        NSString *cardPromptAtKey = [cardAtKey objectAtIndex:2];
        // For each new deck, add it to the list of decks
        if( ![cardPrompts containsObject:categoryAtKey] && [deckAtKey isEqualToString:currentDeck] && [categoryAtKey isEqualToString:currentCategory])
        {
            [cardPrompts addObject:cardPromptAtKey];
            [cardKeys addObject:key];
        }
    }
}


@end
