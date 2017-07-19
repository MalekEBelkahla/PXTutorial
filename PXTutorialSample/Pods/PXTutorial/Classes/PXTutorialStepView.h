//
//  Copyright © 2017 Proxym-IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXTutorialStep.h"

@interface PXTutorialStepView : UIView

@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageExistsConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageDoesntExistConstraint;

/**
 *  Initialize a step view with given step and a flag for landscape mode
 *
 *  @param step      A object conforming with the protocol PXTutorialStep
 *  @param landscape A flag for landscape mode
 *
 *  @return An PXTutorialStepView object
 */
+ (instancetype)stepViewWithStep:(id <PXTutorialStep>)step landscape:(BOOL)landscape contentBundle:(NSBundle *)contentBundle;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end
