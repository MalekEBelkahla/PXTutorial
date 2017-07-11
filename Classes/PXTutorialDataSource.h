//
//  Copyright © 2017 Proxym-IT. All rights reserved.
//

#import "PXTutorialStepConfig.h"
/**
 *  A datasource class to define tutorial steps programmatically instead of via json config file
 */
@protocol PXTutorialDataSource <NSObject>

@required

/**
 *  Delegate method to get an array of tutorial steps
 *
 *  @return an array of tutorial steps
 */
- (nonnull NSArray <PXTutorialStepConfig *> *)tutorialSteps;

@end
