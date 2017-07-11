//
//  Copyright © 2017 Proxym-IT. All rights reserved.
//

#import "PXTutorialBoardViewController.h"

#import "PXTutorialStepView.h"

@interface PXTutorialBoardViewController () <UIScrollViewDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *containerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSLayoutConstraint *scrollViewContainerHeightConstraint;

@property (strong, nonatomic) NSMutableArray *tutorialSteps;

@end

@implementation PXTutorialBoardViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self addTutorialStepsForLandscape:(self.view.frame.size.width > self.view.frame.size.height)];
	self.pageControl.currentPage = 0;
	self.pageControl.numberOfPages = self.tutorialSteps.count;
	[self.view bringSubviewToFront:self.pageControl];

	self.scrollViewContainerHeightConstraint =
		[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
	self.scrollViewContainerHeightConstraint.active = YES;
}

- (void)viewDidLayoutSubviews {
	if ([self respondsToSelector:@selector(topLayoutGuide)]) {
		UIEdgeInsets currentInsets = self.scrollView.contentInset;
		self.scrollView.contentInset = (UIEdgeInsets) {
			.top = self.topLayoutGuide.length,
			.bottom = currentInsets.bottom,
			.left = currentInsets.left,
			.right = currentInsets.right
		};
	}

	CGFloat heightToSubtract = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
	self.scrollViewContainerHeightConstraint.constant = -heightToSubtract;
}

/**
 *  Add tutorial step views for given orientation
 *
 *  @param landscape Flag for landscape mode
 */
- (void)addTutorialStepsForLandscape:(BOOL)landscape {
	self.tutorialSteps = [NSMutableArray new];

	for (UIView *view in self.containerView.subviews) {
		if ([view isKindOfClass:[PXTutorialStepView class]]) {
			[view removeFromSuperview];
		}
	}

	for (id <PXTutorialStep> step in [self.tutorialDataSource tutorialSteps]) {
		[self addTutorialStep:step
		            landscape:landscape
		               bundle:self.configuration.contentBundle];
	}

	[self addConstraints];
}

- (void)addTutorialStep:(id <PXTutorialStep>)step
        landscape:(BOOL)landscape
        bundle:(NSBundle *)bundle {
	PXTutorialStepView *stepView = [PXTutorialStepView stepViewWithStep:step
	                                                            landscape:landscape
	                                                        contentBundle:bundle];

	if (step.closeButtonText) {
		[stepView.closeButton addTarget:self
		                         action:@selector(closeButtonClicked:)
		               forControlEvents:UIControlEventTouchUpInside];
	}

	[self.tutorialSteps addObject:stepView];
	[self.containerView addSubview:stepView];

	if (step.closeButtonText) {
		[stepView.closeButton addTarget:self
		                         action:@selector(closeButtonClicked:)
		               forControlEvents:UIControlEventTouchUpInside];
	}
}

/**
 *  Add constraints for step views
 */
- (void)addConstraints {
	for (int index = 0; index < self.tutorialSteps.count; index++) {
		//width and leading constraint
		if (index == 0) {
			[self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.tutorialSteps[index] attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
			[self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:self.tutorialSteps[index] attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
		} else {
			[self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:self.tutorialSteps[index] attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.tutorialSteps[index - 1] attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
			[self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:self.tutorialSteps[index] attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.tutorialSteps[index - 1] attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
		}

		// top constraint
		[self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:self.tutorialSteps[index] attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
		// bottom constraint
		[self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:self.tutorialSteps[index] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];

		// trailing constraint
		if (index > 0 && index == self.tutorialSteps.count - 1) {
			[self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:self.tutorialSteps[index] attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
		}
	}
}

// MARK: - Close tutorial delegate
- (void)closeButtonClicked:(id)sender {
	[self.tutorialCloseDelegate close];
}

// MARK: - ScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	NSInteger page = round(scrollView.contentOffset.x / scrollView.bounds.size.width);
	UIView *view = self.tutorialSteps[page];

//	[UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//	         view.transform = CGAffineTransformMakeScale(1, 1);
//	 } completion:nil];

	self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//	for (UIView *view in self.tutorialSteps) {
//		view.transform = CGAffineTransformMakeScale(0.9, 0.9);
//	}
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
	[super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
	[coordinator animateAlongsideTransition:^(id < UIViewControllerTransitionCoordinatorContext > context) {
	         [self addTutorialStepsForLandscape:(size.width > size.height)];
	 } completion:^(id <UIViewControllerTransitionCoordinatorContext> context) {
	         [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * self.pageControl.currentPage, self.scrollView.contentOffset.y) animated:YES];
	 }];
}

// Mark : IBAction Methods
- (IBAction)backAction:(id)sender {
    [self.tutorialCloseDelegate close];
}

@end
