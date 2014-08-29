//
//  VSViewController.m
//  Open Spritz iOS
//
//  Created by Vivek Seth on 8/17/14.
//  Copyright (c) 2014 Vivek Seth. All rights reserved.
//

#import "VSViewController.h"
#import "VSSpritzViewController.h"

static NSString * const VSExampleBodyText =
@"Here’s to the crazy ones. The misfits. The rebels. The troublemakers. The round pegs "
"in the square holes. The ones who see things differently. They’re not fond of rules. "
"And they have no respect for the status quo. You can quote them, disagree with them, "
"glorify or vilify them. But the only thing you can’t do is ignore them. Because they "
"change things. They push the human race forward. And while some may see them as the "
"crazy ones, we see genius. Because the people who are crazy enough to think they can "
"change the world, are the ones who do.";

@interface VSViewController ()<VSSpritzViewControllerDelegate>

@property (nonatomic, strong) VSSpritzViewController *spritzViewController;

@end

@implementation VSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.spritzViewController = [[VSSpritzViewController alloc] initWithBodyText:VSExampleBodyText];
	self.spritzViewController.delegate = self;
	self.spritzViewController.spritzView = self.spritzLabel;
	self.spritzViewController.wordsPerMinute = 400;
}

- (void)spritzViewController:(VSSpritzViewController *)spritzViewController didShowWordIndex:(NSUInteger)wordIndex {
	[self.progressView setProgress: ((CGFloat)wordIndex / self.spritzViewController.totalWordCount) animated:YES];
}

- (void)spritzViewControllerDidStartShowingWords:(VSSpritzViewController *)spritzViewController {
	[self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
}

- (void)spritzViewControllerDidFinishShowingWords:(VSSpritzViewController *)spritzViewController {
	[self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
}

- (IBAction)didTapStartStopButton:(id)sender {
	if (self.spritzViewController.isStarted) {
		[self.spritzViewController stop];
	} else {
		[self.spritzViewController start];
	}
}

- (IBAction)didChangeWPMSliderValue:(id)sender {
	self.spritzViewController.wordsPerMinute = self.wpmSlider.value;
	self.wpmLabel.text = [NSString stringWithFormat:@"%d WPM", (int)self.wpmSlider.value];
}

@end
