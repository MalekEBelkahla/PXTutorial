//
//  Copyright © 2017 Proxym-IT. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
   A configuration required for proper setup of the tutorial. Hint: In order to load images from
   other modules that are not contained in the main bundle the bundle has to be known.
 */
@interface PXTutorialConfiguration : NSObject

/**
   The bundle for content that is to be loaded, e.g. images.
 */
@property (nonatomic, strong, nullable) NSBundle *contentBundle;

@end
