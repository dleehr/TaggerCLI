//
//  Series.m
//  TaggerCLI
//
//  Created by Dan Leehr on 10/30/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Series.h"


@implementation Series

- (int) seriesID
{
	[self willAccessValueForKey:@"seriesID"];
	NSInteger sid = seriesID;
	[self didAccessValueForKey:@"seriesID"];
	return sid;
}

- (void) setSeriesID:(int)newSeriesID
{
	[self willChangeValueForKey:@"seriesID"];
	seriesID = newSeriesID;
	[self didChangeValueForKey:@"seriesID"];
}

- (NSString*) title
{
	[self willAccessValueForKey:@"title"];
	NSString *tmptitle = [[NSString alloc]initWithString:title];
	[self didAccessValueForKey:@"title"];
	return tmptitle;
}

- (void) setTitle:(NSString*)newTitle
{
	[self willChangeValueForKey:@"title"];
	title = [[NSString alloc] initWithString:newTitle];
	[self didChangeValueForKey:@"title"];
}

@end
