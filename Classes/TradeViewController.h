//
//  TradeViewController.h
//  PitTrading
//
//  Created by Sudeep Juvekar on 3/5/10.
//  Copyright 2010 UC Berkeley. All rights reserved.
//
#define kFilePath @"/allTrades.plist"

#import <UIKit/UIKit.h>

@interface TradeViewController : UIViewController <UIActionSheetDelegate>{
	IBOutlet UITextField *price;
	IBOutlet UITextField *mmPassword;
	IBOutlet UISegmentedControl *bidAsk;
	IBOutlet UIButton *completeButton;
	
	NSUInteger mmNumber;
	NSString *passwordFromPlistFile;
	NSString *priceString;
	NSString *selected;
}

@property(nonatomic, retain) IBOutlet UITextField *price;
@property(nonatomic, retain) IBOutlet UITextField *mmPassword;
@property(nonatomic, retain) IBOutlet UISegmentedControl *bidAsk;
@property(nonatomic, retain) IBOutlet UIButton *completeButton;

@property(nonatomic) NSUInteger mmNumber;
@property(nonatomic, retain) NSString *passwordFromPlistFile;
@property(nonatomic, retain) NSString *priceString;
@property(nonatomic, retain) NSString *selected;

-(IBAction)completeTrade:(id)sender;
-(IBAction)textFieldDoneEditing:(id)sender;
-(IBAction)backgroundClick:(id)sender;
-(NSString *)dataFilePath;

@end
