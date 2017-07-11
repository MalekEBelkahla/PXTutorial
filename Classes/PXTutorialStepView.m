//
//  Copyright © 2017 Proxym-IT. All rights reserved.
//

#import "PXTutorialStepView.h"
//@import PXEssentials;

@interface PXTutorialStepView ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *headlineLabel;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *linkButton;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *linkHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *closeButtonHeight;
@property (strong, nonatomic) IBOutlet UIView *containerView;


@property (nonatomic, weak) id <PXTutorialStep> step;

@end

@implementation PXTutorialStepView


+ (instancetype)stepViewWithStep:(id <PXTutorialStep>)step landscape:(BOOL)landscape contentBundle:(NSBundle *)contentBundle {
	NSBundle *tutorialBundle = [NSBundle bundleForClass:[self class]];
	NSString *nibName = landscape ? @"PXTutorialStepViewLandscape" : @"PXTutorialStepView";
	NSArray *subviews = [tutorialBundle loadNibNamed:nibName
	                                           owner:self
	                                         options:nil];

	PXTutorialStepView *stepView = subviews.firstObject;
	NSAssert(stepView != nil, @"coulnd't get a stepview from nib");
	stepView.step = step;

	[stepView setupContentWithBundle:contentBundle];

	return stepView;
}

/**
 *  Initialize content of the view
 */
- (void)setupContentWithBundle:(NSBundle *)contentBundle {
	self.containerView.layer.cornerRadius = 5;

	self.translatesAutoresizingMaskIntoConstraints = NO;
	self.backgroundColor = [UIColor clearColor];
//	self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
//	self.layer.shadowOffset = CGSizeMake(2, 2);
//	self.layer.shadowOpacity = 0.5;

	UIImage *image = self.step.image;
	NSAssert(image != nil, @"step image is nil");

	self.imageView.image = image;
	//self.imageView.layer.cornerRadius = 5;

	[self activateConstraintsImageExists:image != nil];

	self.headlineLabel.text = NSLocalizedStringFromTableInBundle(self.step.headline,
	                                                             @"Localizable",
	                                                             contentBundle,
	                                                             @"tutorial headline");
	self.textView.text = NSLocalizedStringFromTableInBundle(self.step.text,
	                                                        @"Localizable",
	                                                        contentBundle,
	                                                        @"tutorial text");
	self.textView.textAlignment = NSTextAlignmentCenter;
	//self.textView.font = [UIFont allianzSansRegularFontWithSize:13];

	if (!self.step.link) {
		self.linkButton.hidden = YES;
		self.linkHeight.constant = 1;
	} else {
		[self.linkButton setTitle:NSLocalizedStringFromTableInBundle(self.step.linkText,
		                                                             @"Localizable",
		                                                             contentBundle,
		                                                             @"tutorial link text")
		                 forState:UIControlStateNormal];
	}

	if (!self.step.closeButtonText) {
		self.closeButton.hidden = YES;
		self.closeButtonHeight.constant = 1;
	} else {
		[self.closeButton setTitle:NSLocalizedString(self.step.closeButtonText, @"tutorial close button text")
		                  forState:UIControlStateNormal];
	}

	self.closeButton.layer.cornerRadius = 6;
}

- (void)activateConstraintsImageExists:(bool)imageExists {
	self.imageExistsConstraint.active = imageExists;
	self.imageDoesntExistConstraint.active = !imageExists;
}

/**
 *  Open the link inside a tutorial step when it is clicked
 *
 *  @param sender the link button
 */
- (IBAction)clickedLink:(UIButton *)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:NSLocalizedString(self.step.link, self.step.link)]];
}

@end
