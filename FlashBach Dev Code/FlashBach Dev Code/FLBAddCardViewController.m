//
//  FLBAddCardViewController.m
//  FlashBach Dev Code
//
//  Created by Xiaofan Fang on 3/3/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBAddCardViewController.h"

@interface FLBAddCardViewController ()

@end

@implementation FLBAddCardViewController

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
    
    
    // Add border to button
    _buttonDeck.layer.borderWidth = 0.7f;
    _buttonDeck.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonDeck.layer.cornerRadius = 7;
   
    // Add border to button
    _buttonCategory.layer.borderWidth = 0.7f;
    _buttonCategory.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonCategory.layer.cornerRadius = 7;
    
    // Add border to button
    _buttonAddCard.layer.borderWidth = 0.7f;
    _buttonAddCard.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonAddCard.layer.cornerRadius = 7;
    
    // Set textField delegate to let keyboard disappear on hitting Return
    _textCardFront.delegate = self;
    _textCardBack.delegate = self;
    _textChooseCategory.delegate = self;
    _textChooseDeck.delegate = self;
    
    // Look for keyboard size
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
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


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textCardFront resignFirstResponder];
    [_textCardBack resignFirstResponder];
    [_textChooseCategory resignFirstResponder];
    [_textChooseDeck resignFirstResponder];
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
