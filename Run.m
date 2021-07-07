//
//  Run.m
//  TaggerCLI
//
//  Created by Dan Leehr on 10/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Run.h"

@implementation Run

@dynamic date;

- (int)processID
{
	[self willAccessValueForKey:@"processID"];
	NSInteger pid = processID;
	[self didAccessValueForKey:@"processID"];
	return pid;
}

- (void)setProcessID:(int)newProcessID
{
	[self willChangeValueForKey:@"processID"];
	processID = newProcessID;
	[self didChangeValueForKey:@"processID"];
}

- (void)setNilValueForKey:(NSString *)key
{
		if([key isEqualToString:@"processID"])
		{
			self.processID = 0;
		}
		else
		{
			[super setNilValueForKey:key];
		}
}

- (void) awakeFromInsert
{
	[super awakeFromInsert];
	self.date = [NSDate date];
}


@end
