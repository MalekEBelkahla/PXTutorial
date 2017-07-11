//
//  Copyright © 2017 Proxym-IT. All rights reserved.
//

/**
 *  A delegate class to handle the click action of the close button
 */
@protocol PXTutorialCloseDelegate <NSObject>

@required

/**
 *  Delegate method to handle clicking the close button in a tutorial step
 */
- (void)close;
@end
