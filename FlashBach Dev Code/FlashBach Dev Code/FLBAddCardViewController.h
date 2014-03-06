//
//  FLBAddCardViewController.h
//  FlashBach Dev Code
//
//  Created by Xiaofan Fang on 3/3/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLBAddCardViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *deckChoice;
@property (nonatomic, strong) IBOutlet UITextField *categoryChoice;
@property (nonatomic, strong) NSMutableArray *myDecks;

@property (weak, nonatomic) IBOutlet UIButton *buttonDeck;

@property (weak, nonatomic) IBOutlet UIButton *buttonCategory;

- (IBAction) deckButtonTapped:(id)sender;
- (IBAction) categoryButtonTapped:(id)sender;

@end
