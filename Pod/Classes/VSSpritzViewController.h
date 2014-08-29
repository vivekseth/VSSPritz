//
//  VSSpritzLabelController.h
//  FastRead
//
//  Created by Vivek Seth on 8/6/14.
//  Copyright (c) 2014 Vivek Seth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSSpritzView.h"

@class VSSpritzViewController;

@protocol VSSpritzViewControllerDelegate <NSObject>

@optional

- (void)spritzViewController:(VSSpritzViewController * )spritzViewController didShowWordIndex:(NSUInteger)wordIndex;

- (void)spritzViewControllerDidStartShowingWords:(VSSpritzViewController * )spritzViewController;

- (void)spritzViewControllerDidFinishShowingWords:(VSSpritzViewController * )spritzViewController;

@end

@class VSSpritzViewController;

@interface VSSpritzViewController : NSObject

@property (nonatomic) BOOL isStarted;
@property (nonatomic) NSUInteger wordsPerMinute;
@property (nonatomic) NSUInteger currentWordIndex;

@property (nonatomic, strong) UIView<VSSpritzView> *spritzView;
@property (nonatomic, weak) id<VSSpritzViewControllerDelegate> delegate;

@property (nonatomic, readonly) NSUInteger totalWordCount;

- (instancetype)initWithBodyText:(NSString *)bodyText;

- (void)start;
- (void)startWithoutAnimation;
- (void)stop;

- (void)displayWordWithIndex:(NSInteger)wordIndex;

@end
