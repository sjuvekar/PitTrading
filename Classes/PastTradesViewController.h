//
//  PastTradesViewController.h
//  PitTrading
//
//  Created by Sudeep Juvekar on 3/5/10.
//  Copyright 2010 UC Berkeley. All rights reserved.
//
#define kFilePath @"/allTrades.plist"

#import <UIKit/UIKit.h>


@interface PastTradesViewController : UITableViewController 
<UITableViewDelegate, UITableViewDataSource> {
	NSArray *pastTrades;
}

@property(nonatomic, retain) NSArray *pastTrades;

-(NSString *)dataFilePath;
-(void)reloadFromPlist;
@end
