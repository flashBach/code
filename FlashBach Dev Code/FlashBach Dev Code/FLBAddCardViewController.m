//
//  FLBAddCardViewController.m
//  FlashBach Dev Code
//
//  Created by Xiaofan Fang on 3/3/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBAddCardViewController.h"

@implementation FLBAddCardViewController

@synthesize textCardBack;
@synthesize textCardFront;
@synthesize textChooseCategory;
@synthesize textChooseDeck;

@synthesize currentCategory;
@synthesize currentDeck;
@synthesize currentCardData;
@synthesize cardID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Load in currentCardData;
    [self loadCardDataFromPlist];
    
    // Add border to button
    _buttonDeck.layer.borderWidth = 0.7f;
    _buttonDeck.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonDeck.layer.cornerRadius = 7;
   
    // Add border to button
    _buttonAdd.layer.borderWidth = 0.7f;
    _buttonAdd.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonAdd.layer.cornerRadius = 7;
    
    // Add border to button
    _buttonCategory.layer.borderWidth = 0.7f;
    _buttonCategory.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonCategory.layer.cornerRadius = 7;
    
    // Set textField delegate to let keyboard disappear on hitting Return
    textCardFront.delegate = self;
    textCardBack.delegate = self;
    textChooseCategory.delegate = self;
    textChooseDeck.delegate = self;
    
    // Look for keyboard size
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    textChooseDeck.text = currentDeck;
    textChooseCategory.text = currentCategory;
    
    if ([self.title  isEqual: @"Edit Card"])
    {
        textCardFront.text = [currentCardData objectAtIndex: 2];
        textCardBack.text = [currentCardData objectAtIndex:3];
    }
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
    currentCardData = [NSMutableArray arrayWithArray:[myDick objectForKey:cardID]];
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
    [newArray addObject:currentCategory];
    [newArray addObject:textCardFront.text];
    [newArray addObject:textCardBack.text];
    [newArray addObject:difficulty];
    [newArray addObject:today];
    
    if ([self.title isEqualToString:@"Add Card"])
    {
        [newMyDict setObject:newArray forKey:[newKey stringValue]];
    }
    if ([self.title isEqualToString:@"Edit Card"])
    {
        [newMyDict setObject:newArray forKey:cardID];
    }
	
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) deckButtonTapped:(id)sender
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Choose Deck"                                                        delegate:self
                                           cancelButtonTitle:@"Cancel"                                              destructiveButtonTitle:@"Dismiss"
                                           otherButtonTitles:@"CS 5", @"CS 70", @"CS 81",@"CS 105", nil];

[action  showInView:self.view];
}

- (IBAction) categoryButtonTapped:(id)sender
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Choose Category"                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"                                              destructiveButtonTitle:@"Dismiss"
                                               otherButtonTitles:@"Recursion", @"Pointers", @"Linked Lists", @"Trees", @"Hashtables", nil];
    
    [action  showInView:self.view];
}

- (IBAction)addButtonTapped:(id)sender
{
    [self saveData];
    
    if([self.title isEqualToString:@"Add Card"])
    {
        textCardBack.text = @"";
        textCardFront.text = @"";
    }
    
    // Time to rewind
    // https://developer.apple.com/library/ios/technotes/tn2298/_index.html
    [self performSegueWithIdentifier:@"unwindToCards" sender:self ];
}

// Required for auto-refresh. 
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FLBCardViewController *detailViewController = [segue destinationViewController];
    [detailViewController loadCardDataFromPlist];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textCardFront resignFirstResponder];
    [textCardBack resignFirstResponder];
    [textChooseCategory resignFirstResponder];
    [textChooseDeck resignFirstResponder];
}

// ===================
// http://iphoneincubator.com/blog/windows-views/how-to-create-a-data-entry-screen
// ===================
CGRect keyboardBounds;

#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[self scrollViewToCenterOfScreen:textField];
}

#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
	[self scrollViewToCenterOfScreen:textView];
}

- (void)scrollViewToCenterOfScreen:(UIView *)theView {
	CGFloat viewCenterY = theView.center.y;
	CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
	CGFloat availableHeight = applicationFrame.size.height - keyboardBounds.size.height;	// Remove area covered by keyboard
    
	CGFloat y = viewCenterY - availableHeight / 2.0;
	if (y < 0) {
		y = 0;
	}
	_scrollView.contentSize = CGSizeMake(applicationFrame.size.width, applicationFrame.size.height + keyboardBounds.size.height);
	[_scrollView setContentOffset:CGPointMake(0, y) animated:YES];
}

- (void)keyboardNotification:(NSNotification*)notification {
	NSDictionary *userInfo = [notification userInfo];
	NSValue *keyboardBoundsValue = [userInfo objectForKey:UIKeyboardBoundsUserInfoKey];
	[keyboardBoundsValue getValue:&keyboardBounds];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	// Find the next entry field
	for (UIView *view in [self entryFields]) {
		if (view.tag == (textField.tag + 1)) {
			[view becomeFirstResponder];
			break;
		}
        else{
            [view resignFirstResponder];
        }
	}
    
	return NO;
}

@synthesize entryFields;

/*
 Returns an array of all data entry fields in the view.
 Fields are ordered by tag, and only fields with tag > 0 are included.
 Returned fields are guaranteed to be a subclass of UIResponder.
 Note: The tags are set for priority in the stroyboard view.
 */
- (NSMutableArray *)entryFields {
	if (!entryFields || [entryFields count] == 0) {
		self.entryFields = [[NSMutableArray alloc] init];
		NSInteger tag = 1;
		UIView *aView;
		while ((aView = [self.view viewWithTag:tag])) {
			if (aView && [[aView class] isSubclassOfClass:[UIResponder class]]) {
				[entryFields addObject:aView];
			}
			tag++;
		}
	}
	return entryFields;
}

@end
