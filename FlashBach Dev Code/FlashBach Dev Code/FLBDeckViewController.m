//
//  FLBDeckViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBDeckViewController.h"

@interface FLBDeckViewController ()

@end

@implementation FLBDeckViewController
@synthesize autocompleteValuesDisplay;
@synthesize autocompleteTableView;
@synthesize autocompleteValuesArray;
@synthesize decks;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Add new deck
// http://stackoverflow.com/questions/6319417/whats-a-simple-way-to-get-a-text-input-popup-dialog-box-on-an-iphone
- (IBAction)addDeckButtonPressed:(id)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Create New Deck" message:@"Please enter the name of the new deck:" delegate:self cancelButtonTitle:@"Save" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeAlphabet;
    alertTextField.placeholder = @"Enter new deck name";
    [alert show];
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    NSString* detailString = textField.text;
//    NSLog(@"String is: %@", detailString); //Put it on the debugger
//    if ([textField.text length] <= 0 || buttonIndex == 0){
//        return; //If cancel or 0 length string the string doesn't matter
//    }
//    
//    
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load in the Card Data for the current view
    [self loadCardDataFromPlist];

    ///////////////////// Modify add card button //////////////////////////////////////////////////////
//    
//    // Attempt to add border to add button on deck view
//    UIButton* buttonAdd = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    // Add "+" label to button
//    [buttonAdd.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
//    [buttonAdd setTitle:@"New Card" forState:UIControlStateNormal];
//    [buttonAdd setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    
//    // Add frame to button
//    buttonAdd.frame = CGRectMake(0, 0, 80.0, 30.0); // make frame
//    buttonAdd.layer.borderWidth = 1.2f;
//    buttonAdd.layer.borderColor = [[UIColor blueColor]CGColor];
//    buttonAdd.layer.cornerRadius = 7;
//    
//    // Add action to button
//    [buttonAdd addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    
//    // Make bar button out of this button
//    UIBarButtonItem* barButtonAdd = [[UIBarButtonItem alloc] initWithCustomView:buttonAdd];
//    self.navigationItem.rightBarButtonItem = barButtonAdd;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Allow dismissing keyboard
    _textNewDeck.delegate = self;
    
    // Auto complete custom values
//    autocompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,80,320,120) style:UITableViewStylePlain];
//    autocompleteTableView.delegate = self;
//    autocompleteTableView.dataSource = self;
//    autocompleteTableView.scrollEnabled = YES;
//    autocompleteTableView.hidden = YES;
//    [self.view addSubview:autocompleteTableView];
}

/*
//- (BOOL)textField:(UITextField*)textField
//    shouldChangeCharactersInRange:(NSRange)range
//    replacementString:(NSString*)string{
//    autocompleteTableView.hidden = NO;
//    
//    NSString *substring = [NSString stringWithString:textField.text];
//    substring = [substring stringByReplacingCharactersInRange:range withString:string];
//    [self searchAutocompleteEntriesWithSubstring:substring];
//    return YES;
//}
//
//- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
//    // Put anything that starts with this substring into the autocmplete array
//    // The items in this array is what will show up in the table view
//    [autocompleteValuesDisplay removeAllObjects];
//    for (NSString *curString in autocompleteValuesArray) {
//        NSRange substringRange = [curString rangeOfString:substring];
//        if (substringRange.location == 0) {
//            [autocompleteValuesDisplay addObject:curString];
//        }
//    }
//    [autocompleteTableView reloadData];
//}

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
    if([[segue identifier] isEqualToString:@"DeckToCategory"])
    {
        FLBCategoryViewController *detailViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        detailViewController.currentDeck = [decks objectAtIndex:indexPath.row];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
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
    return [decks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [decks objectAtIndex:indexPath.row];
    
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
    decks = [NSMutableArray array];
    for(id key in myDick)
    {
        NSMutableArray *cardAtKey = [NSMutableArray arrayWithArray:[myDick objectForKey:key]];
        NSString *deckAtKey = [cardAtKey objectAtIndex:0];
        // For each new deck, add it to the list of decks
        if( ![decks containsObject:deckAtKey] )
        {
            [decks addObject:deckAtKey];
        }
    }
}

// Is called when a background touch occurs, dismisses any open keyboard
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textNewDeck resignFirstResponder];
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
