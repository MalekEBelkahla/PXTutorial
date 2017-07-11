//
//  Copyright © 2017 Proxym-IT. All rights reserved.
//

/**
 *  A tutorial step can contain image, headline, text, link and close button.
 */
@protocol PXTutorialStep <NSObject>

@required

/**
 *  Image of a tutorial step
 */
@property (readonly, nonnull) UIImage *image;

/**
 *  Image name of a tutorial step, in case image is nil
 */
@property (readonly, nonnull) NSString *imageName;

/**
 *  Headline of a tutorial step
 *
 */
@property (readonly, nonnull) NSString *headline;

/**
 *  Text body of a tutorial step
 *
 */
@property (readonly, nonnull) NSString *text;

/**
 *  Link to a web page
 *
 */
@property (readonly, nullable) NSString *link;

/**
 *  Text of the web link, for nil text, no link will be displayed
 *
 */
@property (readonly, nullable) NSString *linkText;

/**
 *  Text of the close button, for nil text, no button will be displayed
 *
 */
@property (readonly, nullable) NSString *closeButtonText;

@end
