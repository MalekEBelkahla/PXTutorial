//
//  Copyright © 2017 Proxym-IT. All rights reserved.
//

#import "PXTutorialJSONDataSource.h"
#import "PXTutorialStepConfig.h"

@interface PXTutorialJSONDataSource ()

@property (nonatomic, copy) NSArray <PXTutorialStepConfig *> *tutorialSteps;

@end

@implementation PXTutorialJSONDataSource

+ (nonnull instancetype)sharedInstance {
	static PXTutorialJSONDataSource *_sharedInstance;

	static dispatch_once_t oncePredicate;
	dispatch_once(&oncePredicate, ^{
		_sharedInstance = [[PXTutorialJSONDataSource alloc] init];
	});

	return _sharedInstance;
}

- (void)parseTutorial:(NSString *)name withConfiguration:(PXTutorialConfiguration *)configuration {
	NSBundle *resourceBundle = configuration.contentBundle;

	NSError *error = nil;
	NSString *filePath = [resourceBundle pathForResource:name ofType:@"json"];
	NSData *data = [NSData dataWithContentsOfFile:filePath];
	id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

	NSAssert(error == nil, @"Error: Failed to read tutorial: %@", name);

	if (![json isKindOfClass:[NSArray class]]) {
		NSAssert(NO, @"malformed json");

		return;
	}

	NSArray *jsonArray = json;
	NSMutableArray <PXTutorialStepConfig *> *tutorialSteps = [NSMutableArray arrayWithCapacity:jsonArray.count];

	for (NSDictionary *jsonConfig in jsonArray) {
		PXTutorialStepConfig *tutorialStepConfig = [[PXTutorialStepConfig alloc] initWithJSON:jsonConfig resourceBundle:resourceBundle];

		[tutorialSteps addObject:tutorialStepConfig];
	}

	self.tutorialSteps = tutorialSteps;
}

@end
