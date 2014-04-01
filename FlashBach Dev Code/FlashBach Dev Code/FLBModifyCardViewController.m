//
//  FLBModifyCardViewController.m
//  FlashBach Dev Code
//
//  Created by CS121 on 3/6/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBModifyCardViewController.h"

@interface FLBModifyCardViewController ()

@end

@implementation FLBModifyCardViewController

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
    
    // Add border to Add Button
    // Add border to button
    _buttonDone.layer.borderWidth = 0.7f;
    _buttonDone.layer.borderColor = [[UIColor blueColor]CGColor];
    _buttonDone.layer.cornerRadius = 7;
    
    // Allow keyboard to disappear upon return press.
    _textBack.delegate = self;
    _textFront.delegate = self;
    _textNewCategory.delegate = self;
    _textNewDeck.delegate = self;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Is called when a background touch occurs, dismisses any open keyboard
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textNewCategory resignFirstResponder];
    [_textNewDeck resignFirstResponder];
    [_textFront resignFirstResponder];
    [_textBack resignFirstResponder];
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

// Returns from this view to sender (pop) when Done is clicked.
- (IBAction)handleDoneClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
