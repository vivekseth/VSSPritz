//
//  UIView+KHAExtensions.m
//  Khan Academy
//
//  Created by Laura Savino on 7/2/13.
//  Copyright (c) 2013 Khan Academy. All rights reserved.
//

#import "UIView+KHAExtensions.h"

@implementation UIView (KHAExtensions)

- (void)assertIsSuperviewOfView:(UIView *)subview {
	NSAssert1([subview isDescendantOfView:self], @"Given subview must be descendent of %@", self);
}

- (void)kha_addConstraintsForCenteredSubview:(UIView *)subview; {
	[self kha_addConstraintsForHorizontallyCenteredSubview:subview];
	[self kha_addConstraintsForVerticallyCenteredSubview:subview];
}

- (void)kha_addConstraintsForHorizontallyCenteredSubview:(UIView *)subview; {
	[self assertIsSuperviewOfView:subview];
	[self kha_addConstraintsForHorizontallyCenteredSubview:subview withPriority:UILayoutPriorityRequired];
}

- (void)kha_addConstraintsForHorizontallyCenteredSubview:(UIView *)subview withPriority:(UILayoutPriority)priority {
	NSLayoutConstraint *centeredConstraint = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
	centeredConstraint.priority = priority;
	[self addConstraint:centeredConstraint];
}

- (void)kha_addConstraintsForVerticallyCenteredSubview:(UIView *)subview; {
	[self assertIsSuperviewOfView:subview];
	[self kha_addConstraintsForVerticallyCenteredSubview:subview withPriority:UILayoutPriorityRequired];
}

- (void)kha_addConstraintsForVerticallyCenteredSubview:(UIView *)subview withPriority:(UILayoutPriority)priority {
	NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
	verticalConstraint.priority = priority;
	[self addConstraint:verticalConstraint];
}

- (void)kha_addConstraintsForFullWidthSubview:(UIView *)subview {
	[self assertIsSuperviewOfView:subview];
	NSDictionary *views = NSDictionaryOfVariableBindings(subview);
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subview]|" options:0 metrics:nil views:views]];
}

- (void)kha_addConstraintsForFullHeightSubview:(UIView *)subview {
	[self assertIsSuperviewOfView:subview];
	NSDictionary *views = NSDictionaryOfVariableBindings(subview);
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview]|" options:0 metrics:nil views:views]];
}

- (void)kha_pinSubview:(UIView *)subview toEdges:(UIRectEdge)edges; {
	[self kha_pinSubview:subview toEdges:edges withInsets:UIEdgeInsetsZero];
}

- (void)kha_pinSubview:(UIView *)subview toEdges:(UIRectEdge)edges withInsets:(UIEdgeInsets)insets; {
	[self assertIsSuperviewOfView:subview];

	if (edges & UIRectEdgeTop) {
		[self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:insets.top]];
	}

	if (edges & UIRectEdgeBottom) {
		[self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:subview attribute:NSLayoutAttributeBottom multiplier:1 constant:insets.bottom]];
	}

	if (edges & UIRectEdgeLeft) {
		[self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:insets.left]];
	}

	if (edges & UIRectEdgeRight) {
		[self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:subview attribute:NSLayoutAttributeRight multiplier:1 constant:insets.right]];
	}

}

- (void)kha_constrainHeight:(CGFloat)height; {
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height]];
}

- (void)kha_constrainWidth:(CGFloat)width; {
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width]];
}

- (void)kha_constrainAttribute:(NSLayoutAttribute)attribute asEqualBetweenView:(UIView *)view1 andView:(UIView *)view2 {
	[self assertIsSuperviewOfView:view1];
	[self assertIsSuperviewOfView:view2];

	[self addConstraint:[NSLayoutConstraint constraintWithItem:view1 attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view2 attribute:attribute multiplier:1 constant:0]];
}

- (void)kha_animateConstraint:(NSLayoutConstraint *)constraint toConstant:(CGFloat)constant duration:(NSTimeInterval)duration {
	constraint.constant = constant;
	[self setNeedsUpdateConstraints];

	[UIView animateWithDuration:duration animations:^{
		[self layoutIfNeeded];
	}];
}
- (UIImage *)kha_convertToImage {
	UIGraphicsBeginImageContext(self.bounds.size);
	[self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

- (void)kha_convertToImageWithCompletion:(void (^)(UIImage *))callback {
	NSParameterAssert(callback);
	dispatch_async(dispatch_get_main_queue(), ^{
		UIImage * imageOfView = [self kha_convertToImage];
		callback(imageOfView);
	});
}

@end
