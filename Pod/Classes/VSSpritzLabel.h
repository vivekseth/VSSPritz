//
//  OSSpritzLabel.h
//  OpenSpritzDemo
//
//  Created by Francesco Mattia on 08/03/14.
//  Copyright (c) 2014 Fr4ncis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSSpritzView.h"

@interface VSSpritzLabel : UIView <VSSpritzView>

- (void)setWord:(NSString *)word pivotCharacterIndex:(NSInteger)pivotCharacterIndex;

- (void)beginStartAnimationWithCompletion:(void(^)(BOOL finished))completion;

@end
