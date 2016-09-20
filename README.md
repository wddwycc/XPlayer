XDPlayer
--
XDPlayer is a PIP (Picture in Picture) Video Player for iOS.  
**Swift3** only.







It's designed super easy to use

```
// Play
XDPlayer.play(url: URL(string: "video_url")!)
// Dismiss
XDPlayer.dismiss()
```


### Install:

Cocoapods:

```
pod 'XDPlayer'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
```

Carthage:

```
github "wddwycc/XDPlayer"
```



---

Icons are from [AwesomeFont](http://fontawesome.io/)  
The Project is under MIT License


