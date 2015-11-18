# KFTextInputHelper

[![CI Status](http://img.shields.io/travis/K6F/KFTextInputHelper.svg?style=flat)](https://travis-ci.org/K6F/KFTextInputHelper)
[![Version](https://img.shields.io/cocoapods/v/KFTextInputHelper.svg?style=flat)](http://cocoapods.org/pods/KFTextInputHelper)
[![License](https://img.shields.io/cocoapods/l/KFTextInputHelper.svg?style=flat)](http://cocoapods.org/pods/KFTextInputHelper)
[![Platform](https://img.shields.io/cocoapods/p/KFTextInputHelper.svg?style=flat)](http://cocoapods.org/pods/KFTextInputHelper)

## Cut

![Cut](./Images/KFTextInputHelper.gif];

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

###Use KFTextField, KFTextView
####Only In storyboard
In storyboard, change the class of UITextField or UITextView
to KFTextField or KFTextView  
**IB_DESIGNABLE** supported!
![IB_Designable](./Images/IBDesign.jpg];

### Use KFTextInputHelper
To use KFTextInputHelper, invoke init method and it would setup automatically.

```objective-c
- (void) viewDidLoad{
	[super viewDidLoad];
	[KFTextInputHelper setupHelperWithContainerView:self.view];
}
```

You can get instance of helper by 

```objective-c
KFTextInputHelper *helper = [KFTextInputHelper helperWithContainerView:self.view];
```

## Requirements

## Installation

KFTextInputHelper is not available through [CocoaPods](http://cocoapods.org) yet. To install
it, simply add the following line to your Podfile:

```ruby
pod "KFTextInputHelper", :git=>"https://github.com/K6F/KFTextInputHelper.git"
```

## Author

K6F, Fan.Khiyuan@gmail.com

## License

KFTextInputHelper is available under the MIT license. See the LICENSE file for more info.
