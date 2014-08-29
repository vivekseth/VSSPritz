//
//  VSSpritzView.h
//  FastRead
//
//  Created by Vivek Seth on 8/7/14.
//  Copyright (c) 2014 Vivek Seth. All rights reserved.
//

/**
 Abstract protocol that all spritz view's must conformt to
 */
@protocol VSSpritzView <NSObject>

/**
 Displays word with pivot character highlighted.
 */
- (void)setWord:(NSString *)word pivotCharacterIndex:(NSInteger)pivotCharacterIndex;

/**
 Just shows start animation and calls completion block. Does not start spritz controller.
 */
- (void)beginStartAnimationWithCompletion:(void(^)(BOOL finished))completion;

@end