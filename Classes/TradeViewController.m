//
//  TradeViewController.m
//  PitTrading
//
//  Created by Sudeep Juvekar on 3/5/10.
//  Copyright 2010 UC Berkeley. All rights reserved.
//

#import "TradeViewController.h"
#import "PitTradingAppDelegate.h"

@implementation TradeViewController

@synthesize price;
@synthesize mmPassword;
@synthesize bidAsk;
@synthesize completeButton;

@synthesize mmNumber;
@synthesize passwordFromPlistFile;
@synthesize priceString;
@synthesize selected;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	// Setting up normal button image
	UIImage *buttonImageNormal = [UIImage imageNamed:@"normal.png"]; 
	UIImage *strechableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[completeButton setBackgroundImage:strechableButtonImageNormal forState:UIControlStateNormal];
	
	// Setting up pressed button image
	UIImage *buttonImagePressed = [UIImage imageNamed:@"lightblue.png"]; 
	UIImage *strechableButtonImagePressed = [buttonImagePressed
											  stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[completeButton setBackgroundImage:strechableButtonImagePressed forState:UIControlStateHighlighted];
	
	//Retrieve password from file so that you don't have to do it repeatedly
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *plist = [bundle pathForResource:@"marketMakers" ofType:@"plist"];
	NSArray *array = [[NSArray alloc] initWithContentsOfFile:plist];
	
	NSArray *recordForMM = [array objectAtIndex:self.mmNumber];
	self.passwordFromPlistFile = [recordForMM objectAtIndex:2];
	[recordForMM release];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(NSString *)dataFilePath {
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *directory = [path objectAtIndex:0];
	return [directory stringByAppendingString:kFilePath];
}

-(IBAction)textFieldDoneEditing:(id)sender {
	[sender resignFirstResponder];
}


-(IBAction)completeTrade:(id)sender {
	
	// Check if price is empty
	self.priceString = [[self price] text];
	if(self.priceString == nil || [self.priceString length] == 0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Price!"
														message:@"Please set a price"
													   delegate:nil 
											  cancelButtonTitle:@"Ok"
											  otherButtonTitles:nil
							  ];
		[alert show];
		[alert release];
	}
	
	else {
		// Check if password is empty
		NSString *passwordString = [[self mmPassword] text];
		if(passwordString == nil || [passwordString length] == 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password!"
															message:@"Please enter a password"
														   delegate:nil 
												  cancelButtonTitle:@"Ok"
												  otherButtonTitles:nil
								  ];
			[alert show];
			[alert release];
		}
		
		else {
			// Check for password match
			if([self.passwordFromPlistFile compare:passwordString] != NSOrderedSame) {
				NSString *t = [[NSString alloc] initWithFormat:@"Password Mismatch!"];
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:t
																message:@"Password is incorrect. Please enter correct password"
															   delegate:nil 
													  cancelButtonTitle:@"Ok" 
													  otherButtonTitles:nil
									  ];
				[alert show];
				[alert release];
			}
			
			else {
				//Append the trage to the file
				if([bidAsk selectedSegmentIndex] == 0)
					self.selected = [[NSString alloc] initWithFormat:@"Bid"];
				else
					self.selected = [[NSString alloc] initWithFormat:@"Ask"];
				
				NSString *resultString = [[NSString alloc] 
										  initWithFormat:@"Market Maker:MM%d\nAction:%@\nPrice:%@", self.mmNumber+1, self.selected, self.priceString]; 
				
				UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:resultString
																		 delegate:self 
																cancelButtonTitle:@"Cancel"
														   destructiveButtonTitle:@"Ok"
																otherButtonTitles:nil];
				[actionSheet showInView:self.view];
				[actionSheet release];
				
			}
		}
		
	}
	
	
}

-(void)actionSheet:(UIActionSheet *)actionSheet
didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if(buttonIndex == [actionSheet destructiveButtonIndex]) {
		
		NSString *resultString = [[NSString alloc] initWithFormat:@"MM%d, %@, %@", self.mmNumber+1, self.selected, self.priceString]; 
		
		NSString *plist = [[self dataFilePath] retain];
		NSMutableArray *array;
		
		if([[NSFileManager defaultManager] fileExistsAtPath:plist]) {
			array = [[NSMutableArray alloc] initWithContentsOfFile:plist];
		}
		else {
			[[NSFileManager defaultManager] createFileAtPath:plist contents:nil attributes:nil];
			array = [[NSMutableArray alloc] init];
		}
		[array addObject:resultString];
		[array writeToFile:plist atomically:YES];
		
		PitTradingAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		[delegate.pitTradingNavController popViewControllerAnimated:YES];
		
	}
}

-(IBAction)backgroundClick:(id)sender {
	[price resignFirstResponder];
	[mmPassword resignFirstResponder];
}

- (void)dealloc {
	[price release];
	[mmPassword release];
	[bidAsk release];
	[completeButton release];
    [super dealloc];
}


@end
