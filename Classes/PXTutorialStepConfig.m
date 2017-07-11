//
//  Copyright © 2017 Proxym-IT. All rights reserved.
//

#import "PXTutorialStepConfig.h"

@implementation NSDictionary (string)

- (NSString *)aom_stringForKey:(NSString *)key {
	id string = self[key];

	if ([string isKindOfClass:[NSString class]]) {
		return string;
	} else {
		return nil;
	}
}

@end

@implementation PXTutorialStepConfig

- (instancetype)initWithJSON:(nonnull NSDictionary *)json resourceBundle:(nonnull NSBundle *)resourceBundle {
	self = [super init];

	if (self != nil) {
		_imageName = [[json aom_stringForKey:@"imageName"] copy];
		_image = [UIImage imageNamed:_imageName inBundle:resourceBundle compatibleWithTraitCollection:nil];
		_headline = [[json aom_stringForKey:@"headline"] copy];
		_text = [[json aom_stringForKey:@"text"] copy];

		if (_imageName == nil || _image == nil || _headline == nil || _text == nil) {
			NSAssert(NO, @"init with json failed to due missing/ false key value pair");

			return nil;
		}

		_link = [[json aom_stringForKey:@"link"] copy];
		_linkText = [[json aom_stringForKey:@"linkText"] copy];
		_closeButtonText = [[json aom_stringForKey:@"closeButtonText"] copy];
	}

	return self;
}

@end
