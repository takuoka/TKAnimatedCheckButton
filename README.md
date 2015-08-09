
# TKAnimatedCheckButton

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
[![CocoaPods](https://img.shields.io/cocoapods/v/TKAnimatedCheckButton.svg)]()


Elastic Animated Check Box inpired by
https://dribbble.com/shots/1631598-On-Off
and
http://robb.is/working-on/a-hamburger-button-transition/


![Demo GIF Animation](https://raw.githubusercontent.com/entotsu/TKAnimatedCheckButton/master/demo.gif "Demo GIF Animation")


# Installation
```
pod 'TKAnimatedCheckButton'
```

# Usage

## This is SubClass of UIButton

``` swift
self.button = TKAnimatedCheckButton(frame: CGRectMake(0, 0, 44, 44))
```

## How to toggle
``` swift
func toggle() {
  self.button.checked = !self.button.checked
}
```
## Custom Color
``` swift
self.button.color = UIColor.redColor().CGColor
self.button.skeletonColor = UIColor.blueColor().CGColor
```
