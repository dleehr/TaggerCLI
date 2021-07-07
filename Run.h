//
//  Run.h
//  TaggerCLI
//
//  Created by Dan Leehr on 10/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Run : NSManagedObject {
	NSInteger processID;
}
@property (retain) NSDate *date;
@property NSInteger processID;
@end
