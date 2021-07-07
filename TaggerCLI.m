#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Series.h"
#import "Episode.h"

NSManagedObjectModel *managedObjectModel()
{
	static NSManagedObjectModel *mom = nil;
	if(mom != nil) { return mom; }
	
	mom = [[NSManagedObjectModel alloc] init];

	//Entities -- Series and Episode
	NSEntityDescription *seriesEntity = [[NSEntityDescription alloc] init];
	[seriesEntity setName:@"Series"];
	[seriesEntity setManagedObjectClassName:@"Series"];

	NSEntityDescription *episodeEntity = [[NSEntityDescription alloc] init];
	[episodeEntity setName:@"Episode"];
	[episodeEntity setManagedObjectClassName:@"Episode"];

	[mom setEntities:[NSArray arrayWithObjects:seriesEntity,episodeEntity,nil]];

	[seriesEntity release];
	[episodeEntity release];
	
	//Attributes for Series
	
	//Attribute - Title
	NSAttributeDescription *seriesTitleAttribute;
	seriesTitleAttribute = [[[NSAttributeDescription alloc] init] autorelease];
	
	[seriesTitleAttribute setName:@"title"];
	[seriesTitleAttribute setAttributeType:NSStringAttributeType];
	[seriesTitleAttribute setOptional:NO];
	
	//Attribute - ID
	NSAttributeDescription *idAttribute;
	idAttribute = [[[NSAttributeDescription alloc] init] autorelease];
	
	[idAttribute setName:@"seriesID"];
	[idAttribute setAttributeType:NSInteger32AttributeType];
	[idAttribute setOptional:NO];
	[idAttribute setDefaultValue:[NSNumber numberWithInt:-1]];
	
	//Attributes for Episodes
	
	//Attribute - Series ID (should link back to ID above)
	NSAttributeDescription *seriesIdAttribute;
	seriesIdAttribute = [[[NSAttributeDescription alloc] init] autorelease];
	[seriesIdAttribute setName:@"seriesID"];
	[seriesIdAttribute setAttributeType:NSInteger32AttributeType];
	[seriesIdAttribute setOptional:NO];
	
	//Atrribute - Episode ID
	NSAttributeDescription *episodeIDAttribute;
	episodeIDAttribute = [[[NSAttributeDescription alloc] init] autorelease];
	[episodeIDAttribute setName:@"episodeID"];
	[episodeIDAttribute setAttributeType:NSInteger32AttributeType];
	[episodeIDAttribute setOptional:NO];
	
	//Attribute - tvdb last updated
	NSAttributeDescription *lastUpdatedAttribute;
	lastUpdatedAttribute = [[[NSAttributeDescription alloc] init] autorelease];
	[lastUpdatedAttribute setName:@"lastUpdated"];
	[lastUpdatedAttribute setAttributeType:NSInteger32AttributeType];
	[lastUpdatedAttribute setOptional:NO];
	
	//Attribute - tvdb artwork path
	NSAttributeDescription *artworkPathAttribute;
	artworkPathAttribute = [[[NSAttributeDescription alloc] init] autorelease];
	[artworkPathAttribute setName:@"artworkPath"];
	[artworkPathAttribute setAttributeType:NSStringAttributeType];
	[artworkPathAttribute setOptional:YES];
	
	//Attribute - season number
	NSAttributeDescription *seasonNumberAttribute;
	seasonNumberAttribute = [[[NSAttributeDescription alloc] init] autorelease];
	[seasonNumberAttribute setName:@"seasonNumber"];
	[seasonNumberAttribute setAttributeType:NSInteger32AttributeType];
	[seasonNumberAttribute setOptional:NO];
	
	//Attribute - episode number
	NSAttributeDescription *episodeNumberAttribute;
	episodeNumberAttribute = [[[NSAttributeDescription alloc] init] autorelease];
	[episodeNumberAttribute setName:@"episodeNumber"];
	[episodeNumberAttribute setAttributeType:NSInteger32AttributeType];
	[episodeNumberAttribute setOptional:NO];
	
	//Attribute - episode name
	NSAttributeDescription *episodeNameAttribute;
	episodeNameAttribute = [[[NSAttributeDescription alloc] init] autorelease];
	[episodeNameAttribute setName:@"episodeName"];
	[episodeNameAttribute setAttributeType:NSStringAttributeType];
	[episodeNameAttribute setOptional:NO];
	
	//Attribute air date
	NSAttributeDescription *airDateAttribute;
	airDateAttribute = [[[NSAttributeDescription alloc] init] autorelease];
	[airDateAttribute setName:@"airDate"];
	[airDateAttribute setAttributeType:NSDateAttributeType];
	[airDateAttribute setOptional:YES];
	
	//Attribute - production Code
	NSAttributeDescription *productionCodeAttribute;
	productionCodeAttribute = [[[NSAttributeDescription alloc] init] autorelease];
	[productionCodeAttribute setName:@"productionCode"];
	[productionCodeAttribute setAttributeType:NSStringAttributeType];
	[productionCodeAttribute setOptional:YES];
	
	//Attribute - overview
	NSAttributeDescription *overviewAttribute;
	overviewAttribute = [[[NSAttributeDescription alloc] init] autorelease];
	[overviewAttribute setName:@"overview"];
	[overviewAttribute setAttributeType:NSStringAttributeType];
	[overviewAttribute setOptional:YES];
	
	
	//Relationships?
	
	
	
	
	
	
	//Validation
	NSExpression *lhs = [NSExpression expressionForEvaluatedObject];
	NSExpression *rhs = [NSExpression expressionForConstantValue:[NSNumber numberWithInt:0]];
	
	NSPredicate *validationPredicate = [NSComparisonPredicate 
										predicateWithLeftExpression:lhs
										rightExpression:rhs 
										modifier:NSDirectPredicateModifier
										type:NSGreaterThanPredicateOperatorType
										options:0];
	//Error String and Validation
	NSString *validationWarning = @"Series ID < 1";
	[idAttribute setValidationPredicates:[NSArray arrayWithObject:validationPredicate]
				  withValidationWarnings:[NSArray arrayWithObject:validationWarning]];
	
	[seriesEntity setProperties:[NSArray arrayWithObjects: seriesTitleAttribute, idAttribute, nil]];
	[episodeEntity setProperties:[NSArray arrayWithObjects:seriesIdAttribute,episodeIDAttribute,
								  lastUpdatedAttribute,artworkPathAttribute,seasonNumberAttribute,
								  episodeNumberAttribute,episodeNameAttribute,airDateAttribute,
								  productionCodeAttribute,overviewAttribute,nil]];
	 
	
	
	NSMutableDictionary *localizationDictionary = [NSMutableDictionary dictionary];
	
	[localizationDictionary setObject:@"Title" forKey:@"Property/title/Entity/Series"];
	[localizationDictionary setObject:@"Series ID" forKey:@"Property/SeriesID/Entity/Series"];
	[localizationDictionary setObject:@"Series ID must not be less than 1" forKey:@"ErrorString/Series ID < 1"];
	
	[mom setLocalizationDictionary:localizationDictionary];
		
	return mom;
}

NSString *applicationLogDirectory()
{
    NSString *LOG_DIRECTORY = @"TaggerCLI";
    static NSString *ald = nil;
	
    if (ald == nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains
		(NSLibraryDirectory, NSUserDomainMask, YES);
        if ([paths count] == 1)
        {
            ald = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Application Support"];
            ald = [[ald stringByAppendingPathComponent:LOG_DIRECTORY] retain];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            BOOL isDirectory = NO;
            if (![fileManager fileExistsAtPath:ald isDirectory:&isDirectory])
            {
                if (![fileManager createDirectoryAtPath:ald attributes:nil])
                {
                    [ald release];
                    ald = nil;
                }
            }
            else
            {
                if (!isDirectory)
                {
                    [ald release];
                    ald = nil;
                }
            }
        }
    }
    return ald;
}

NSManagedObjectContext *managedObjectContext()
{
	static NSManagedObjectContext *moc = nil;
	if(moc != nil) { return moc; }
	
	moc = [[NSManagedObjectContext alloc] init];
	
	NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: managedObjectModel()];
	[moc setPersistentStoreCoordinator: coordinator];
	[coordinator release];
	
	NSString *STORE_TYPE = NSXMLStoreType;
	NSString *STORE_FILENAME = @"TaggerCLI.taggercli";
	
	NSError *error;
	NSURL *url = [NSURL fileURLWithPath: [applicationLogDirectory() stringByAppendingPathComponent:STORE_FILENAME]];
	
	id newStore = [coordinator addPersistentStoreWithType:STORE_TYPE
											configuration:nil
													  URL:url 
												  options:nil
													error:&error];
	if(newStore == nil) {
		NSLog(@"Store Configuration Failure\n%@", 
			  ([error localizedDescription] != nil) ?
			  [error localizedDescription] : @"Unknown Error");
	}
	
	
	return moc;
}

void addSeries(NSInteger seriesID,NSString* seriesTitle)
{
	NSManagedObjectModel *mom = managedObjectModel();
	NSManagedObjectContext *moc = managedObjectContext();
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *seriesEntity = [[mom entitiesByName] objectForKey:@"Series"];
	[request setEntity:seriesEntity];
	//see if this seriesID is already in the store
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:
							  @"(seriesID = %d)", seriesID];
	[request setPredicate:predicate];
	
	NSError *error = nil;
	NSArray *found = [moc executeFetchRequest:request error:&error];
	if (found != nil) {
		int count = [found count]; // may be 0 if the object has been deleted
		if(count > 0)
		{
			NSLog(@"Series with ID %d already exists",seriesID);
		} 
		else
		{
			Series *series = [[[Series alloc] initWithEntity:seriesEntity insertIntoManagedObjectContext: moc] autorelease];
	
			//Series Title and series ID
			[series setTitle:seriesTitle];
			[series setSeriesID:seriesID];
			
			error = nil;
		}
		if(![moc save: &error])
		{
			NSLog(@"Error while saving\n%@",
				  ([error localizedDescription] != nil) ? [error localizedDescription] :
				  @"Unknown Error");
			exit(1);
		}
	}
	
}

void addEpisode(NSInteger seriesID,NSInteger episodeID,NSInteger lastUpdated,
	NSString *artworkPath,NSInteger seasonNumber,NSInteger episodeNumber,
	NSString *episodeName, NSDate *airDate, NSString *productionCode,
				NSString *overview)
{
	NSManagedObjectModel *mom = managedObjectModel();
	NSManagedObjectContext *moc = managedObjectContext();
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *episodeEntity = [[mom entitiesByName] objectForKey:@"Episode"];
	[request setEntity:episodeEntity];
	//see if this episodeID is already in the store
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:
							  @"(episodeID = %d)", episodeID];
	[request setPredicate:predicate];

	NSError *error = nil;
	NSArray *found = [moc executeFetchRequest:request error:&error];
	if (found != nil) {
		int count = [found count]; // may be 0 if the object has been deleted
		if(count > 0)
		{
			NSLog(@"Episode with ID %d already exists",episodeID);
		} 
		else
		{
			Episode *episode = [[[Episode alloc] initWithEntity:episodeEntity insertIntoManagedObjectContext: moc] autorelease];
			
			episode.seriesID = seriesID;
			episode.episodeID = episodeID;
			episode.lastUpdated = lastUpdated;
			episode.artworkPath = artworkPath;
			episode.seasonNumber = seasonNumber;
			episode.episodeNumber = episodeNumber;
			episode.episodeName = episodeName;
			episode.airDate = airDate;
			episode.productionCode = productionCode;
			episode.overview = overview;
			
			error = nil;
			
		}
		
		if(![moc save: &error])
		{
			NSLog(@"Error while saving\n%@",
				  ([error localizedDescription] != nil) ? [error localizedDescription] :
				  @"Unknown Error");
			exit(1);
		}
		
	}
	
	
	
}

void parseSeriesChildren(NSXMLNode *series)
{
	int attributes = [series childCount];
	
	NSInteger seriesID;
	NSString *seriesTitle;
	
	for(int i=0;i<attributes;i++)
	{
		NSXMLNode * attr = [series childAtIndex:i];
		if([[attr name] isEqualToString:@"id"])
			seriesID = [[attr stringValue] intValue];
		if([[attr name] isEqualToString:@"SeriesName"])
			seriesTitle = [NSString stringWithString:[attr stringValue]];
	}

	NSLog(@"Series Name:\t%@\tSeries ID:\t%d\n",seriesTitle,seriesID);
	addSeries(seriesID, seriesTitle);
	
	
}



void parseEpisodeChildren(NSXMLNode *episode)
{
	int attributes = [episode childCount];
	
	NSInteger episodeID;
	NSInteger seriesID;
	NSInteger lastUpdated;
	NSString *artworkPath;
	NSDate *airDate;
	NSString *overview;
	NSString *productionCode;
	NSString *episodeName;
	NSInteger seasonNumber;
	NSInteger episodeNumber;
	for(int i=0;i<attributes;i++)
	{
		NSXMLNode * attr = [episode childAtIndex:i];
		if([[attr name] isEqualToString:@"id"])
			episodeID = [[attr stringValue] intValue];
		if([[attr name] isEqualToString:@"seriesid"])
			seriesID = [[attr stringValue] intValue];
		if([[attr name] isEqualToString:@"lastupdated"])
			lastUpdated = [[attr stringValue] intValue];
		if([[attr name] isEqualToString:@"filename"])
			artworkPath = [NSString stringWithString:[attr stringValue]];
		if([[attr name] isEqualToString:@"FirstAired"])
			airDate = [NSDate dateWithNaturalLanguageString:[attr stringValue]];
		if([[attr name] isEqualToString:@"Overview"])
			overview = [NSString stringWithString:[attr stringValue]];
		if([[attr name] isEqualToString:@"ProductionCode"])
			productionCode = [NSString stringWithString: [attr stringValue]];
		if([[attr name] isEqualToString:@"EpisodeName"])
			episodeName = [NSString stringWithString:[attr stringValue]];
		if([[attr name] isEqualToString:@"SeasonNumber"])
			seasonNumber = [[attr stringValue] intValue];
		if([[attr name] isEqualToString:@"EpisodeNumber"])
			episodeNumber = [[attr stringValue] intValue];
	}

	NSLog(@"Episode Number:\t%d\tSeason Number:\t%d\t%@\n",episodeNumber,seasonNumber,episodeName);
	addEpisode(seriesID, 
			   episodeID, 
			   lastUpdated, 
			   artworkPath, 
			   seasonNumber, 
			   episodeNumber, 
			   episodeName, 
			   airDate, 
			   productionCode, 
			   overview);

}

void doSomethingWithNode(NSXMLNode *child)
{
	NSString * nodeName = [[NSString alloc] initWithString:[child name]];
	if([nodeName isEqualToString:@"Series"])
	{
		parseSeriesChildren(child);
	}
	
	if([nodeName isEqualToString:@"Episode"])
	{
			parseEpisodeChildren(child);
	}
	[nodeName release];
	return;
	
}

void tagFile(NSString *fileName, NSString *artworkFile, Episode* episode, Series *series)
{
	NSString *seriesName = [series title];
	NSString *albumName = [[NSString alloc] initWithString:[seriesName stringByAppendingString:[NSString stringWithFormat:@", Season %d",episode.seasonNumber]]];
	
	NSDateFormatter *airDateFormatter = [[NSDateFormatter alloc] init];
	[airDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];

	NSTask *tagTask;
	tagTask = [[NSTask alloc] init];
	[tagTask setLaunchPath:@"/usr/local/bin/AtomicParsley"];
	NSArray *arguments;
	arguments = [NSArray arrayWithObjects:fileName,
	@"-a",seriesName,
	@"--title",episode.episodeName,
	@"-b",albumName,
	@"-A",albumName,
	@"-k",[NSString stringWithFormat:@"%d",[episode episodeNumber]],
	@"-y",[airDateFormatter stringFromDate:episode.airDate],
	@"-S",@"TV Show",
	@"--desc",episode.overview,
	@"-H",seriesName,
	@"-I",episode.productionCode,
	@"-U",[NSString stringWithFormat:@"%d",[episode seasonNumber]],
	@"-N",[NSString stringWithFormat:@"%d",[episode episodeNumber]],
	@"--genre",@"Comedy",
	@"--artwork", artworkFile,
	@"--overWrite",
	nil];	

	NSLog(@"Arguments: %d",[arguments count]);
	[tagTask setArguments:arguments];
	[tagTask launch];
	[tagTask waitUntilExit];
	
	
}

void renameFile(NSString *fileName, Episode *episode)
{
	NSString *newFileName = [[NSString alloc] initWithFormat:@"%02d %@",episode.episodeNumber,episode.episodeName];
	NSString *basePath = [fileName stringByDeletingLastPathComponent];
	NSString *extension = [fileName pathExtension];
	
	newFileName = [[basePath stringByAppendingPathComponent:newFileName] stringByAppendingPathExtension:extension];
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	[fileManager movePath:fileName toPath:newFileName handler:nil];
	NSLog(@"Rename %@ to %@",fileName,newFileName);
}


int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	if (applicationLogDirectory() == nil) {
		NSLog(@"Could not find application log directory\nExiting...");
		exit(1);
	}
	NSError *tvdberror;
	//First determine if mode is init
	if(argc == 1)
	{
		//print out the series list
		
		NSManagedObjectModel *mom = managedObjectModel();
		NSManagedObjectContext *moc = managedObjectContext();
		
		NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
		NSEntityDescription *seriesEntity = [[mom entitiesByName] objectForKey:@"Series"];
		[request setEntity:seriesEntity];

        NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] autorelease];
        [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
		
		tvdberror = nil;
		
		NSArray *array = [moc executeFetchRequest:request error:&tvdberror];
		if ((tvdberror != nil) || (array == nil))
		{	
			NSLog(@"Error while fetchin\n%@",
				  ([tvdberror localizedDescription] != nil) ? [tvdberror localizedDescription]
				  : @"Unknown Error");
			exit(1);
		}
		Series *series;
		for(series in array)
		{
			NSLog(@"Series Name:\t%@\tSeries ID:\t%d\n",series.title,series.seriesID);
		}
		
		
		
		
		printf("Arguments: <xmlfile> | <seriesid> <season> <episode> [<filename> <artwork>]\n");
		exit(1); 
	} else if(argc == 2) {
	
		NSLog(@"Initializing\n");
		NSString *xmlfile = [NSString stringWithCString:argv[1]];
		NSURL * episodeListURL = [NSURL fileURLWithPath:xmlfile];
		NSXMLDocument * episodeList = [[NSXMLDocument alloc] initWithContentsOfURL:episodeListURL options:NSXMLDocumentTidyXML error:&tvdberror];
		NSXMLNode *root = [episodeList rootElement];
		
		int i, count = [root childCount];
		for (i=0; i < count; i++) {
			NSXMLNode *child = [root childAtIndex:i];
			doSomethingWithNode(child);
			[child release];
		}
	} else if(argc >= 4) {
		NSLog(@"Finding Series\n");
		//First find the series
		NSInteger seriesID = atoi(argv[1]);
		NSInteger seasonNumber = atoi(argv[2]);
		NSInteger episodeNumber = atoi(argv[3]);
		
		NSManagedObjectModel *mom = managedObjectModel();
		NSManagedObjectContext *moc = managedObjectContext();

		NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
		NSEntityDescription *seriesEntity = [[mom entitiesByName] objectForKey:@"Series"];
		[request setEntity:seriesEntity];
		
		NSPredicate *predicate = [NSPredicate predicateWithFormat:
								  @"(seriesID = %d)",seriesID];
		
		[request setPredicate:predicate];
		tvdberror = nil;
		
		NSArray *array = [moc executeFetchRequest:request error:&tvdberror];
		if ((tvdberror != nil) || (array == nil))
		{	
			NSLog(@"Error while fetchin\n%@",
				  ([tvdberror localizedDescription] != nil) ? [tvdberror localizedDescription]
				  : @"Unknown Error");
			exit(1);
		}
		
		Series *series = [array objectAtIndex:0];
		NSLog(@"Series Name:\t%@\tSeries ID:\t%d\n",series.title,series.seriesID);
		
		//Now find the episode
		
		request = [[[NSFetchRequest alloc] init] autorelease];
		NSEntityDescription *episodeEntity = [[mom entitiesByName] objectForKey:@"Episode"];
		[request setEntity:episodeEntity];
		
		predicate = [NSPredicate predicateWithFormat:
								  @"(episodeNumber = %d AND seasonNumber = %d AND seriesID = %d)", episodeNumber,seasonNumber,seriesID];
		[request setPredicate:predicate];
		tvdberror = nil;
			
		array = [moc executeFetchRequest:request error:&tvdberror];
		if ((tvdberror != nil) || (array == nil))
		{	
			NSLog(@"Error while fetchin\n%@",
				  ([tvdberror localizedDescription] != nil) ? [tvdberror localizedDescription]
				  : @"Unknown Error");
			exit(1);
		}
	
		Episode * episode;
		NSLog(@"Contents:\n");
		episode  = [array objectAtIndex:0];
			NSLog(@"Season:\t%d\nEpisode:\t%d\nTitle:\t%@\nAir Date:\t%@\nProduction Code:\t%@\nOverview:\t%@\n",
				episode.seasonNumber,
				episode.episodeNumber,
				episode.episodeName,
				[episode.airDate description],
				episode.productionCode,
				episode.overview);
		if(argc == 6) {
			
			NSString *fileName = [NSString stringWithCString:argv[4]];
			NSString *artworkFile = [NSString stringWithCString:argv[5]];
			NSLog(@"Tagging %@\n",fileName);
			tagFile(fileName,artworkFile,episode,series);
//			renameFile(fileName,episode);
		}
		
		
	}
								   
	
    [pool drain];
    return 0;
}
