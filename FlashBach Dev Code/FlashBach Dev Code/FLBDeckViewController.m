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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) addButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"addCardFromDeckView" sender:sender];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

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
