
# TKAnimatedCheckButton

Elastic Animated Check Box inpired by
https://dribbble.com/shots/1631598-On-Off
and
http://robb.is/working-on/a-hamburger-button-transition/


![Demo GIF Animation](https://raw.githubusercontent.com/entotsu/TKAnimatedCheckButton/master/demo.gif "Demo GIF Animation")

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
self.button.skeltonColor = UIColor.blueColor().CGColor
```
