# PXTutorial
[![CocoaPods](https://img.shields.io/badge/pod-v1.2.0-blue.svg)]()

PXTutorial provides a configurable JSON file and programmatic interface to define the steps of a tutorial. Each step contains image, headline and text, additionally it can contain a link and a close button. The link can be used to open an external web link. The close button can be used to redirect users to the next view.

# Integration

#### CocoaPods (iOS 8+)
You can use [Cocoapods](http://cocoapods.org/) to install `PXTutorial` by adding it to your `Podfile`:
```ruby

platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
	pod ‘PXTutorial'
end
```
Note that this requires CocoaPods version [1.0.0](https://github.com/CocoaPods/CocoaPods/releases/tag/1.0.0) or later, and your iOS deployment target to be at least 8.0

## Building the module locally
The example project of this module should always compile locally when checking out the `master` or `develop` branch.

# Usage

#### DataSource
Define a datasource for tutorial steps by JSON config file or programmatically by implementing `PXTutorialDataSource`

- Use the default implementation `PXTutorialJSONDataSource` of `PXTutorialDataSource` to parse a JSON config file
- 
```objc
PXTutorialJSONDataSource *dataSource = [PXTutorialJSONDataSource sharedInstance];  
[dataSource parseTutorial:@“sample-tutorial"];
```

- Or implement your own data source to get an array of `PXTutorialStep`

#### PXTutorialBoardViewController
Instantiate `PXTutorialBoardViewController` from the storyboard `PXTutorialBoard`

```objc
NSBundle *bundle = [NSBundle bundleForClass:[self PXTutorialBoardViewController]];  
UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@“PXTutorialBoard" bundle:bundle];  
PXTutorialBoardViewController *tutorialVC = [storyboard instantiateViewControllerWithIdentifier:@“PXTutorialBoardViewController"];  
```

#### PXTutorialCloseDelegate
Implement the delegate method of `PXTutorialCloseDelegate`. The logic to memorize if a tutorial has been read can be implemented here.

```objc
@interface PXViewController : UIViewController <PXTutorialCloseDelegate>  
@end  

@implementation PXViewController  
// MARK: - PXTutorialCloseDelegate
- (void)close {  
  [self.navigationController popViewControllerAnimated:NO];  
} 
```

#### Set DataSource and Delegate
Within `PXTutorialBoardViewController` do

```objC
tutorialVC.tutorialCloseDelegate = <your implementation>; 
tutorialVC.tutorialDataSource = config or <your implementation>;
```

#### Presentation
```objc
[self.navigationController pushViewController:tutorialVC animated:YES];
```

