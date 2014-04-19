//
//  FLBDataManagement.m
//  FlashBach Dev Code
//
//  Created by CS121 on 4/19/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "FLBDataManagement.h"

@implementation FLBDataManagement


+ (NSDictionary *) loadCardDataDictionaryFromPlist
{
    NSString *plistPath = [self getPlistPath];
	
	// Read property list into memory as an NSData object
	NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
	NSString *errorDesc = nil;
	NSPropertyListFormat format;
    
	// Convert static property list into dictionary object
	NSDictionary *myDict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
	
    // Error Checking
    if (!myDict)
	{
		NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
	}
    
    return myDict;
}

+ (void) saveNewCard: (NSArray *) newCard
{
    // Get the dictionary and keys
    NSDictionary *myDict = [self loadCardDataDictionaryFromPlist];
    NSArray *dictKeys = [myDict allKeys];
    
    // Generate a new key
    NSNumber *newKey = @0;
    while ([dictKeys containsObject:[newKey stringValue]])
    {
        newKey = @(newKey.intValue + 1);
    }
    
    // Doesn't work without the stringValue there... probably type mismatch somewhere
    [self SaveCard:newCard WithIndex:[newKey stringValue]];
}

+ (void) SaveCard:(NSArray *)card WithIndex:(NSNumber *)cardIndex
{
    NSString *plistPath = [self getPlistPath];
    
    // Get the dictionary and keys
    NSDictionary *myDict = [self loadCardDataDictionaryFromPlist];
    
	// Put the new card into a new dictionary
	NSMutableDictionary *newMyDict = [NSMutableDictionary dictionaryWithDictionary:myDict];
    [newMyDict setObject:card forKey:cardIndex];
	
	// Create a non-mutable dictionary from this
    NSDictionary *plistDict = newMyDict;
	
    // Use to collect any error message from creating the Plist
	NSString *error = nil;
    
	// Create the Plist from the non-mutable dictionary
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
	
    // Check if plistData exists
	if(plistData)
	{
        [plistData writeToFile:plistPath atomically:YES];
    }
    else
	{
        NSLog(@"Error in saveData: %@", error);
    }
}

+ (NSString *) getPlistPath
{
    // Loads data from Documents or Bundle Directory
    //     First, try the mutable Documents Directory...
	NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [paths firstObject];
    NSLog(@"Documents Path > %@", documentsPath);
	NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"CardData.plist"];
    
	//     Check to see if we found the CardData.plist file...
	if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
	{
		//Copy the file from the app bundle.
        NSString * defaultPath = [[NSBundle mainBundle] pathForResource:@"CardData" ofType:@"plist"];
        [[NSFileManager defaultManager] copyItemAtPath:defaultPath toPath:plistPath error:NULL];
	}
    
    return plistPath;
}


@end
