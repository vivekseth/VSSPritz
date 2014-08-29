//
//  OSSpritzLabel.m
//  OpenSpritzDemo
//
//  Created by Francesco Mattia on 08/03/14.
//  Copyright (c) 2014 Fr4ncis. All rights reserved.
//

#import "VSSpritzLabel.h"
#import "UIView+KHAExtensions.h"

@interface VSSpritzLabel ()
@property (nonatomic, strong) UILabel *wordLabel;
@property (nonatomic, strong) NSLayoutConstraint *horizontalWordPositionConstraint;
@property (nonatomic, strong) NSLayoutConstraint *horizontalCrosshairPositionConstraint;
@property (nonatomic) CGFloat pivotOffset;
@end

@implementation VSSpritzLabel

#pragma mark - Init

- (instancetype)init {
	self = [super initWithFrame:CGRectZero];
	if (!self) {
        return nil;
    }

	[self _commonInit];

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (!self) {
        return nil;
    }

	[self _commonInit];

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (!self) {
        return nil;
    }

	[self _commonInit];

    return self;
}

/**
 All init methods should call this method.
 */
- (void)_commonInit {
	[self setUpContainerBorder];
	[self setUpWordLabel];
	[self setUpCrosshairLine];
}

#pragma mark - Set Up

- (void)setUpWordLabel {
	self.wordLabel = [UILabel new];
	self.wordLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:60.0f];
	self.wordLabel.textAlignment = NSTextAlignmentLeft;

	self.wordLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:self.wordLabel];
	[self kha_addConstraintsForVerticallyCenteredSubview:self.wordLabel];

	NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:self.wordLabel
																  attribute:NSLayoutAttributeLeft
																  relatedBy:NSLayoutRelationEqual
																	 toItem:self
																  attribute:NSLayoutAttributeLeft
																 multiplier:1.0
																   constant:0.0];
	self.horizontalWordPositionConstraint = constraint;
	[self addConstraint:constraint];
}

- (void)setUpContainerBorder {
	self.layer.borderColor = [UIColor colorWithWhite:0.7 alpha:0.1].CGColor;
	self.layer.borderWidth = 4.0;
	self.layer.cornerRadius = 20;
}

- (void)setUpCrosshairLine {
	UIView *targetView = [UIView new];
	targetView.backgroundColor = [UIColor lightGrayColor];
	targetView.alpha = 0.1;

	targetView.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:targetView];
	[targetView kha_constrainWidth:2.0];
	[self kha_addConstraintsForFullHeightSubview:targetView];
	[self kha_addConstraintsForVerticallyCenteredSubview:targetView];
	self.horizontalCrosshairPositionConstraint = [NSLayoutConstraint constraintWithItem:self
																			  attribute:NSLayoutAttributeLeft
																			  relatedBy:NSLayoutRelationEqual
																				 toItem:targetView
																			  attribute:NSLayoutAttributeCenterX
																			 multiplier:1.0
																			   constant:-self.pivotOffset];
	[self addConstraint:self.horizontalCrosshairPositionConstraint];
}

/**
 Updates font to fit in area
 Updates crosshair location based on width
 */
// TODO(vivek): Only update constraints and font if dimensions of self have been invalidated
- (void)layoutSubviews {
	const CGFloat heightToFontSizeRatio = 0.3333;
	const CGFloat widthToPivotOffsetRatio = 0.3333;

	CGFloat oldOffsetFromLeft = self.pivotOffset - self.horizontalWordPositionConstraint.constant;
	CGFloat oldWordWidth = [self.wordLabel.text sizeWithAttributes:@{NSFontAttributeName: self.wordLabel.font}].width;

	self.pivotOffset = widthToPivotOffsetRatio * self.frame.size.width;
	self.horizontalCrosshairPositionConstraint.constant = -self.pivotOffset;
	self.wordLabel.font = [self.wordLabel.font fontWithSize:(heightToFontSizeRatio * self.frame.size.height)];

	// Calculate new offset for word based on old offset
	if (oldWordWidth != 0) {
		CGFloat offsetFromLeftWidthPercentage = oldOffsetFromLeft / oldWordWidth;
		CGFloat newOffsetFromLeft = offsetFromLeftWidthPercentage * [self.wordLabel.text sizeWithAttributes:@{NSFontAttributeName: self.wordLabel.font}].width;
		self.horizontalWordPositionConstraint.constant = -newOffsetFromLeft+self.pivotOffset;
	}

	[super layoutSubviews];
}

#pragma mark - Utility

- (CGFloat)calculateOffsetForWord:(NSString *)word pivotCharacterIndex:(NSInteger)pivotCharacterIndex {
	NSRange pivotCharRange = NSMakeRange(pivotCharacterIndex, 1);
	NSAssert(pivotCharRange.location != NSNotFound, @"no pivot char found");

	NSString *leftPartOfWord = [word substringToIndex:pivotCharacterIndex];
	NSString *pivotCharString = [word substringWithRange:pivotCharRange];

	CGFloat leftPartWidth = [leftPartOfWord sizeWithAttributes:@{NSFontAttributeName: self.wordLabel.font}].width;
	CGFloat centerPartWidth = [pivotCharString sizeWithAttributes:@{NSFontAttributeName: self.wordLabel.font}].width;

	return leftPartWidth + 0.5 * centerPartWidth;
}

#pragma mark - Public Methods

- (void)setWord:(NSString *)word pivotCharacterIndex:(NSInteger)pivotCharacterIndex {
	NSAssert(word && ![word isEqualToString:@""], @"word must not be nil, nor empty string");

	// Update font size and crosshair location if needed.
	[self layoutIfNeeded];

	CGFloat offsetFromLeft = [self calculateOffsetForWord:word pivotCharacterIndex:pivotCharacterIndex];
	self.horizontalWordPositionConstraint.constant = -offsetFromLeft+self.pivotOffset;
	self.wordLabel.text = word;

	NSMutableAttributedString * mutableAttributedString =
	[[NSMutableAttributedString alloc] initWithString:word
										   attributes:@{
														NSFontAttributeName: self.wordLabel.font,
														NSForegroundColorAttributeName : [UIColor lightGrayColor]
														}];

	NSRange pivotCharRange = NSMakeRange(pivotCharacterIndex, 1);
	[mutableAttributedString setAttributes:@{
											 NSFontAttributeName: self.wordLabel.font,
											 NSForegroundColorAttributeName : [UIColor blackColor]
											 }
									 range:pivotCharRange];

	self.wordLabel.attributedText = mutableAttributedString;
}

- (void)beginStartAnimationWithCompletion:(void(^)(BOOL finished))completion {
	UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.pivotOffset, self.frame.size.height)];
	leftView.backgroundColor = [UIColor blueColor];
	leftView.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:leftView];
	CGRect toFrameLeftView = CGRectMake(self.pivotOffset, 0, 0, self.frame.size.height);


	UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(self.pivotOffset, 0, (self.frame.size.width - self.pivotOffset), self.frame.size.height)];
	rightView.backgroundColor = [UIColor blueColor];
	rightView.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:rightView];
	CGRect toFrameRightView = CGRectMake(self.pivotOffset, 0, 0, self.frame.size.height);

	// Use exponential decay animation curve.
	// Setting springDampening to 1.0 creates a 'critically dampened' spring.
	// Its velocity decays with absolutely no oscilation.
	[UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:0 animations:^{
		leftView.alpha = 0.1;
		leftView.frame = toFrameLeftView;

		rightView.alpha = 0.1;
		rightView.frame = toFrameRightView;
	} completion:^(BOOL finished) {
		[leftView removeFromSuperview];
		[rightView removeFromSuperview];
		completion(finished);
	}];
}

@end