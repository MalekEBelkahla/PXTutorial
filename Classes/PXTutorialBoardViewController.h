//
//  Copyright © 2017 Proxym-IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXTutorialCloseDelegate.h"
#import "PXTutorialDataSource.h"
#import "PXTutorialConfiguration.h"

/**
 *  A tutorial board view contains several tutorial step views, which can be scrolled
 */
@interface PXTutorialBoardViewController : UIViewController

/**
 *  Delegate for the close button
 */
@property (nonatomic, weak, nullable) id <PXTutorialCloseDelegate> tutorialCloseDelegate;

/**
 *  Delegate for datasource to define tutorial steps
 */
@property (nonatomic, weak, nullable) id <PXTutorialDataSource> tutorialDataSource;


/**
   A configuration object required to properly configure the tutorial
 */
@property (nonatomic, weak, nullable) PXTutorialConfiguration *configuration;

@property (nonatomic, weak) IBOutlet UIButton *backBtn;

- (IBAction)backAction:(id)sender;

@end
