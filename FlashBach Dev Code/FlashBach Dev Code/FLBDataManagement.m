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
	if (!myDict)
	{
		NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
	}
    
    return myDict;
}


@end
