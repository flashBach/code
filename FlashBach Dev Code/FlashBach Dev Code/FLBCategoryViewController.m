//
//  FLBCategoryViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBCategoryViewController.h"

@interface FLBCategoryViewController ()

@end

@implementation FLBCategoryViewController
@synthesize categories;
@synthesize currentDeck;
@synthesize alertTextField;
@synthesize theNewCategoryName;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadCardDataFromPlist];
    
    self.navigationItem.title = currentDeck;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Allow keyboard to disappear on return press
    _textNewCategory.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"CategoryToCard"])
    {
        FLBCardViewController *detailViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        detailViewController.currentCategory = [categories objectAtIndex:indexPath.row];
        detailViewController.currentDeck = currentDeck;
    }
}

 

#pragma mark - Table view data source

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
	NSDictionary *myDick = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
	if (!myDick)
	{
		NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
	}
    
    // Create view's perception of the decks we have available based on the cards.
    categories = [NSMutableArray array];
    for(id key in myDick)
    {
        NSMutableArray *cardAtKey = [NSMutableArray arrayWithArray:[myDick objectForKey:key]];
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
    [self saveData];
    [self loadCardDataFromPlist];
    [self.tableView reloadData];
}

- (IBAction) saveData
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
	NSDictionary *myDict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    
    NSArray *dictKeys = [myDict allKeys];
    NSNumber *newKey = @0;
    
    while ([dictKeys containsObject:[newKey stringValue]])
    {
        newKey = @(newKey.intValue + 1);
    }
    
    NSNumber *difficulty = @0;
    NSDate *today = [NSDate date];
    
	// set the variables to the values in the text fields
	NSMutableDictionary *newMyDict = [NSMutableDictionary dictionaryWithDictionary:myDict];
    
    // Currently breaks if there is nothing in the field
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    [newArray addObject:currentDeck];
    [newArray addObject:theNewCategoryName];
    [newArray addObject:@"Default"];
    [newArray addObject:@"Default"];
    [newArray addObject:difficulty];
    [newArray addObject:today];
    
    [newMyDict setObject:newArray forKey:[newKey stringValue]];
	
	// create dictionary with values in UITextFields
    NSDictionary *plistDict = newMyDict;
	
	NSString *error = nil;
	// create NSData from dictionary
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
	
    // check is plistData exists
	if(plistData)
	{
		// write plistData to our Data.plist file
        [plistData writeToFile:plistPath atomically:YES];
    }
    else
	{
        NSLog(@"Error in saveData: %@", error);
    }
}

// Is called on textField when Return/Done is pressed to dismiss keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
