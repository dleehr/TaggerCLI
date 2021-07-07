//
//  Episode.h
//  TaggerCLI
//
//  Created by Dan Leehr on 11/1/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Episode : NSManagedObject {
	//Fields for tvdb
	NSInteger seriesID;
	NSInteger episodeID;
	NSInteger lastUpdated;
	NSString *artworkPath;
	//local fields
	NSInteger seasonNumber;
	NSInteger episodeNumber;
	NSString *episodeName;
	NSDate *airDate;
	NSString *productionCode;
	NSString *overview;
	
}

@property NSInteger seriesID;
@property NSInteger episodeID;
@property NSInteger lastUpdated;
@property (retain) NSString *artworkPath;

@property NSInteger seasonNumber;
@property NSInteger episodeNumber;
@property (retain) NSString *episodeName;
@property (retain) NSDate *airDate;
@property (retain) NSString *productionCode;
@property (retain) NSString *overview;

@end
