//
//  Copyright © 2017 Proxym-IT. All rights reserved.
//

#import "PXTutorialDataSource.h"
#import "PXTutorialConfiguration.h"

/**
 *  A class to read json config file with defined tutorial steps
 */
@interface PXTutorialJSONDataSource : NSObject <PXTutorialDataSource>

/**
 *  To create a singelton of PXTutorialJSONDataSource
 *
 *  @return A singelton of PXTutorialJSONDataSource
 */
+ (nonnull instancetype)sharedInstance;

/**
 *  Parse the tutorial json config file with given name without file suffix
 *
 *  @param name Json config file name without file suffix
 */
- (void)parseTutorial:(nonnull NSString *)name withConfiguration:(nonnull PXTutorialConfiguration *)configuration;

@end
