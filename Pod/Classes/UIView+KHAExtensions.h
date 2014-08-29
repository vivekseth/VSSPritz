//
//  UIView+KHAExtensions.h
//  Khan Academy
//
//  Created by Laura Savino on 7/2/13.
//  Copyright (c) 2013 Khan Academy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KHAExtensions)

// Uses autolayout to center subview in the receiver. (Receiver must be a superview of the subview.)
- (void)kha_addConstraintsForCenteredSubview:(UIView *)subview;
- (void)kha_addConstraintsForHorizontallyCenteredSubview:(UIView *)subview;
- (void)kha_addConstraintsForHorizontallyCenteredSubview:(UIView *)subview withPriority:(UILayoutPriority)priority;
- (void)kha_addConstraintsForVerticallyCenteredSubview:(UIView *)subview;
- (void)kha_addConstraintsForVerticallyCenteredSubview:(UIView *)subview withPriority:(UILayoutPriority)priority;

// Uses autolayout to expand a subview to the dimensions of its superview.
- (void)kha_addConstraintsForFullWidthSubview:(UIView *)subview;
- (void)kha_addConstraintsForFullHeightSubview:(UIView *)subview;

/**
 Pins subview to a superview, relying on info in `insets` to inform padding from each edge.

 Values in `insets` that do not correspond to `edges` passed in will be ignored.
 */
- (void)kha_pinSubview:(UIView *)subview toEdges:(UIRectEdge)edges withInsets:(UIEdgeInsets)insets;

/**
 Pins subview to superview edges with UIEdgeInsetsZero.
 */
- (void)kha_pinSubview:(UIView *)subview toEdges:(UIRectEdge)edges;

/**
 Sets a view's height to a constant value
 */
- (void)kha_constrainHeight:(CGFloat)height;

/**
 Sets a view's width to a constant value
 */
- (void)kha_constrainWidth:(CGFloat)width;

/**
 Sets specified attribute of view1 and view2 to be equal.
 */
- (void)kha_constrainAttribute:(NSLayoutAttribute)attribute asEqualBetweenView:(UIView *)view1 andView:(UIView *)view2;

/**
 Animates changing the constant of the given constraint to the given value.
 
 The given constraint must belong to this view or a descendant of this view.
 */
- (void)kha_animateConstraint:(NSLayoutConstraint *)constraint toConstant:(CGFloat)constant duration:(NSTimeInterval)duration;

/**
 Returns the view as an image. Sometimes this will crash based on the order
 of view layout operations (see http://stackoverflow.com/q/19903665/400717). In
 that case, run -convertToImageWithCompletion:.
 */
- (UIImage *)kha_convertToImage;

/**
 Asynchronously computes and returns the view from -convertToImage.
 */
- (void)kha_convertToImageWithCompletion:(void(^)(UIImage *screenshot))callback;


@end
