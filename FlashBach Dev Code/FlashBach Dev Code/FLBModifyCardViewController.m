//
//  FLBModifyCardViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBModifyCardViewController.h"

@implementation FLBModifyCardViewController

@synthesize cardID;
@synthesize currentCardData;
@synthesize textBack;
@synthesize textFront;
@synthesize textNewCategory;
@synthesize textNewDeck;

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
    _buttonDone.layer.borderWidth = 0.7f;
    _buttonDone.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonDone.layer.cornerRadius = 7;
    
    // Allow keyboard to disappear upon return press.
    textBack.delegate = self;
    textFront.delegate = self;
    textNewCategory.delegate = self;
    textNewDeck.delegate = self;
    
    textNewDeck.text = [currentCardData objectAtIndex:0];
    textNewCategory.text = [currentCardData objectAtIndex:1];
    textFront.text = [currentCardData objectAtIndex:2];
    textBack.text = [currentCardData objectAtIndex:3];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Is called when a background touch occurs, dismisses any open keyboard
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_buttonDone resignFirstResponder];
    [textNewDeck resignFirstResponder];
    [textNewCategory resignFirstResponder];
    [textFront resignFirstResponder];
    [textBack resignFirstResponder];
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

// Returns from this view to sender (pop) when Done is clicked.
- (IBAction)handleDoneClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
