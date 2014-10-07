# VSSpritz

[![CI Status](http://img.shields.io/travis/Vivek Seth/VSSpritz.svg?style=flat)](https://travis-ci.org/Vivek Seth/VSSpritz)
[![Version](https://img.shields.io/cocoapods/v/VSSpritz.svg?style=flat)](http://cocoadocs.org/docsets/VSSpritz)
[![License](https://img.shields.io/cocoapods/l/VSSpritz.svg?style=flat)](http://cocoadocs.org/docsets/VSSpritz)
[![Platform](https://img.shields.io/cocoapods/p/VSSpritz.svg?style=flat)](http://cocoadocs.org/docsets/VSSpritz)

Open Source Spritz framework for iOS (see example below).

You can set the size of a VSSpritzLabel using AutoLayout, Interface Builder, or by manually setting its frame. 

VSSpritzLabels automatically adjust themselves as their size changes:

- Font size will increase to optimially use space, 
- Crosshair marker will also adjust to ensure its always in the perfect location.

VSSpritz is built to be very customizable; everything is modular. Swap anything out that you would like to change. 

VSSpritz started out as a fork of [openspritz-ios](https://github.com/Fr4ncis/openspritz-ios). Since I've diverged quite considerably, I decided release this as its own project.

## Example

![](https://raw.githubusercontent.com/vivekseth/VSSPritz/master/VSSpritzDemo.gif)


## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Here's some code to get you started. 

	self.spritzLabel = [[VSSpritzLabel alloc] initWithFrame:CGRectMake(37, 95, 246, 73)];
	self.spritzLabel.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:self.spritzLabel];

	self.spritzViewController = [[VSSpritzViewController alloc] initWithBodyText:@"text goes here."];
	self.spritzViewController.delegate = self;
	self.spritzViewController.spritzView = self.spritzLabel;
	self.spritzViewController.wordsPerMinute = 400;
	
## Requirements

Works on any device.

Requires iOS7 or greater to work. 

## Installation

VSSpritz is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "VSSpritz"
    
Alternatively you can copy the contents of VSSPritz/Pod/Classes into your iOS project and import required classes.

	#import "VSSpritzLabel.h"
	#import "VSSpritzViewController.h"

## Author

Vivek Seth, Vivekseth.m@gmail.com

## License

VSSpritz is available under the MIT license. See the LICENSE file for more info.

