//
//  Copyright © 2017 Proxym-IT. All rights reserved.
//

#import "PXTutorialStep.h"


/**
   An implementation of PXTutorialStep that exposes it's properties readonly.
 */
@interface PXTutorialStepConfig : NSObject <PXTutorialStep>

/**
   The designated initializer

   @param json            A dictionary created from JSON
   @param ressourceBundle The resourceBundle for assets, e.g. images

   @return A new instance of `PXTutorialStepConfig`
 */
- (nullable instancetype)initWithJSON:(nonnull NSDictionary *)json resourceBundle:(nonnull NSBundle *)ressourceBundle;

/// The image to be shown in a tuturialStep
@property (readonly, nonnull) UIImage *image;

/// The imageNem to be shown in a tutorialStep
@property (readonly, nonnull) NSString *imageName;

/// The headline to be shown in a tutorialStep
@property (readonly, nonnull) NSString *headline;

/// The text to be shown in a tutorialStep
@property (readonly, nonnull) NSString *text;

/// An optional link of a tutorialStep
@property (readonly, nullable) NSString *link;

/// An optional linkText related to the `link`
@property (readonly, nullable) NSString *linkText;

/// An optional title of a close button
@property (readonly, nullable) NSString *closeButtonText;

@end
