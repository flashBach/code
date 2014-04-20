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
@synthesize myDict;

@synthesize entryFields;

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    myDict = [FLBDataManagement loadCardDataDictionaryFromPlist];
    
    // Create view's perception of the decks we have available based on the cards.
    currentCardData = [NSMutableArray arrayWithArray:[myDict objectForKey:cardID]];
    
    [self addButtonBorders];
    
    [self setupKeyboard];
    
    textChooseDeck.text = currentDeck;
    textChooseCategory.text = currentCategory;
    
    if ([self.title  isEqual: @"Edit Card"])
    {
        textCardFront.text = [currentCardData objectAtIndex: 2];
        textCardBack.text = [currentCardData objectAtIndex:3];
    }
    
    // Detects background button presses (used to dismiss keyboard)
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self.view addGestureRecognizer:singleTap];
}

- (void) addButtonBorders
{
    _buttonDeck.layer.borderWidth = 0.7f;
    _buttonDeck.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonDeck.layer.cornerRadius = 7;
    
    _buttonAdd.layer.borderWidth = 0.7f;
    _buttonAdd.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonAdd.layer.cornerRadius = 7;
    
    _buttonCategory.layer.borderWidth = 0.7f;
    _buttonCategory.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonCategory.layer.cornerRadius = 7;
}

- (void) setupKeyboard
{
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
}


# pragma mark - Button Actions

- (IBAction) deckButtonTapped:(id)sender
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Choose Deck"                                                                              delegate:self
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

- (IBAction)saveButtonTapped:(id)sender
{
    [self saveCard];
    
    // Time to rewind
    // https://developer.apple.com/library/ios/technotes/tn2298/_index.html
    [self performSegueWithIdentifier:@"unwindToCards" sender:self ];
}

#pragma mark - Navigation

// Required for auto-refresh.
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FLBCardViewController *cardViewController = [segue destinationViewController];
    cardViewController.myDict = [FLBDataManagement loadCardDataDictionaryFromPlist];
    [cardViewController loadCardDataFromDictionary];
    [cardViewController.tableView reloadData];
}

# pragma mark - Data Management

- (void) saveCard
{
    NSNumber *frequency = @5;
    NSDate *today = [NSDate date];
    
    NSMutableArray *newCard = [[NSMutableArray alloc] init];
    [newCard addObject:currentDeck];
    [newCard addObject:currentCategory];
    [newCard addObject:textCardFront.text];
    [newCard addObject:textCardBack.text];
    [newCard addObject:frequency];
    [newCard addObject:today];
    
    if ([self.title isEqualToString:@"Add Card"])
    {
        [FLBDataManagement saveNewCard:newCard];
    }
    else if ([self.title isEqualToString:@"Edit Card"])
    {
        [FLBDataManagement SaveCard:newCard WithIndex:cardID];
    }

}

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


# pragma mark - Keyboard/View

// ===================
// http://iphoneincubator.com/blog/windows-views/how-to-create-a-data-entry-screen
// ===================
CGRect keyboardBounds;

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[self scrollViewToCenterOfScreen:textField];
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

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    [textCardFront resignFirstResponder];
    [textCardBack resignFirstResponder];
    [textChooseCategory resignFirstResponder];
    [textChooseDeck resignFirstResponder];
}




@end
