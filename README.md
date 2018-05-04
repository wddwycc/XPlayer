# XPlayer

[![Version](https://img.shields.io/cocoapods/v/XPlayer.svg?style=flat)](https://cocoapods.org/pods/XPlayer)
[![License](https://img.shields.io/cocoapods/l/XPlayer.svg?style=flat)](https://cocoapods.org/pods/XPlayer)
[![Platform](https://img.shields.io/cocoapods/p/XPlayer.svg?style=flat)](https://cocoapods.org/pods/XPlayer)

![](https://storage.googleapis.com/duan/etc/69D3CB50-0CEF-4FA6-999F-926FB5A2C731/XPlayer_demo.gif
)

## Introduction

XPlayer is a **drop to use** lib for playing video on iOS with:

* playback control
* landscape & portrait switch
* picture in Picture mode with smooth interactive transition


To keep it simple, the lib currently only provides two methods:

```swift
class XPlayer {
    static func play(_ url: URL, themeColor: UIColor)
    static func dismiss(completion: (() -> ())? = nil)
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS >= 10.0

## Installation

XPlayer is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XPlayer'
```

## Author

wddwycc, wddwyss@gmail.com

## License

XPlayer is available under the MIT license. See the LICENSE file for more info.
