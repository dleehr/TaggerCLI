//
//  Series.h
//  TaggerCLI
//
//  Created by Dan Leehr on 10/30/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Series : NSManagedObject {
	NSInteger seriesID;
	NSString *title;
}
@property (retain) NSString *title;
@property NSInteger seriesID;
@end
