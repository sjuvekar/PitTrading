//
//  AllMMViewController.h
//  PitTrading
//
//  Created by Sudeep Juvekar on 3/5/10.
//  Copyright 2010 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TradeViewController;

@interface AllMMViewController : UITableViewController {
	NSArray *marketMakers;
	TradeViewController *tradeViewController;
	NSArray *mmImages; // Pictures of MMs
}

@property(nonatomic, retain) NSArray *marketMakers;
@property(nonatomic, retain) TradeViewController *tradeViewController;
@property(nonatomic, retain) NSArray *mmImages;
@end
