//
//  VSViewController.h
//  Open Spritz iOS
//
//  Created by Vivek Seth on 8/17/14.
//  Copyright (c) 2014 Vivek Seth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VSSpritzLabel.h>

@interface VSViewController : UIViewController

@property (nonatomic, strong) IBOutlet VSSpritzLabel *spritzLabel;

@property (nonatomic, strong) IBOutlet UIProgressView *progressView;

@property (nonatomic, strong) IBOutlet UILabel *wpmLabel;

@property (nonatomic, strong) IBOutlet UIButton *startStopButton;

@property (nonatomic, strong) IBOutlet UISlider *wpmSlider;

@end
