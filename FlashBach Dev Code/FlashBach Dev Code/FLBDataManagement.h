//
//  FLBDataManagement.h
//  FlashBach Dev Code
//
//  Created by CS121 on 4/19/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLBDataManagement : NSObject

+ (NSDictionary *) loadCardDataDictionaryFromPlist;
+ (void) saveNewCard:(NSArray *)newCard;
+ (void) SaveCard:(NSArray *)card WithIndex:(NSNumber *)cardIndex;

@end
