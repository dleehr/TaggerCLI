//
//  Episode.m
//  TaggerCLI
//
//  Created by Dan Leehr on 11/1/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Episode.h"


@implementation Episode

@dynamic artworkPath;

- (int)lastUpdated
{
	[self willAccessValueForKey:@"lastUpdated"];
	NSInteger pid = lastUpdated;
	[self didAccessValueForKey:@"lastUpdated"];
	return pid;
}

- (void)setLastUpdated:(int)newLastUpdated
{
	[self willChangeValueForKey:@"lastUpdated"];
	lastUpdated = newLastUpdated;
	[self didChangeValueForKey:@"lastUpdated"];
}


- (int)seriesID
{
	[self willAccessValueForKey:@"seriesID"];
	NSInteger pid = seriesID;
	[self didAccessValueForKey:@"seriesID"];
	return pid;
}

- (void)setSeriesID:(int)newSeriesID
{
	[self willChangeValueForKey:@"seriesID"];
	seriesID = newSeriesID;
	[self didChangeValueForKey:@"seriesID"];
}

- (int)episodeID
{
	[self willAccessValueForKey:@"episodeID"];
	NSInteger pid = episodeID;
	[self didAccessValueForKey:@"episodeID"];
	return pid;
}

- (void)setEpisodeID:(int)newEpisodeID
{
	[self willChangeValueForKey:@"episodeID"];
	episodeID = newEpisodeID;
	[self didChangeValueForKey:@"episodeID"];
}

- (int)seasonNumber
{
	[self willAccessValueForKey:@"seasonNumber"];
	NSInteger pid = seasonNumber;
	[self didAccessValueForKey:@"seasonNumber"];
	return pid;
}

- (void)setSeasonNumber:(int)newSeasonNumber
{
	[self willChangeValueForKey:@"seasonNumber"];
	seasonNumber = newSeasonNumber;
	[self didChangeValueForKey:@"seasonNumber"];
}


- (int)episodeNumber
{
	[self willAccessValueForKey:@"episodeNumber"];
	NSInteger pid = episodeNumber;
	[self didAccessValueForKey:@"episodeNumber"];
	return pid;
}

- (void)setEpisodeNumber:(int)newEpisodeNumber
{
	[self willChangeValueForKey:@"episodeNumber"];
	episodeNumber = newEpisodeNumber;
	[self didChangeValueForKey:@"episodeNumber"];
}

@dynamic episodeName;
@dynamic productionCode;
@dynamic airDate;
@dynamic overview;

@end
