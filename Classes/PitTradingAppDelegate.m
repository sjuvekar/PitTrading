//
//  PitTradingAppDelegate.m
//  PitTrading
//
//  Created by Sudeep Juvekar on 3/5/10.
//  Copyright UC Berkeley 2010. All rights reserved.
//

#import "PitTradingAppDelegate.h"
#import "PitTradingNavController.h"

@implementation PitTradingAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize pitTradingNavController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
	[window makeKeyAndVisible];
}

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
	[pitTradingNavController release];
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

