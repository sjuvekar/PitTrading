//
//  PitTradingAppDelegate.h
//  PitTrading
//
//  Created by Sudeep Juvekar on 3/5/10.
//  Copyright UC Berkeley 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PitTradingNavController;

@interface PitTradingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	IBOutlet PitTradingNavController *pitTradingNavController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet PitTradingNavController *pitTradingNavController;

@end
