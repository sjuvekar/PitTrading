//
//  PastTradesViewController.m
//  PitTrading
//
//  Created by Sudeep Juvekar on 3/5/10.
//  Copyright 2010 UC Berkeley. All rights reserved.
//

#import "PastTradesViewController.h"

@implementation PastTradesViewController
@synthesize pastTrades;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

-(NSString *)dataFilePath {
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *directory = [path objectAtIndex:0];
	return [directory stringByAppendingString:kFilePath];
}

-(void)reloadFromPlist {
	NSString *plist = [self dataFilePath];
	NSMutableArray *array;
	
	if([[NSFileManager defaultManager] fileExistsAtPath:plist]) {
		array = [[NSMutableArray alloc] initWithContentsOfFile:plist];
	}
	else {
		array = [[NSMutableArray alloc] init];
	}
	
	self.pastTrades = array;
	[array release];
	
}

- (void)viewDidLoad {
	self.title = @"Trade History";
	
	[self reloadFromPlist];
	[super viewDidLoad];
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self reloadFromPlist];
	
	self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
	[self.tableView reloadData];
	
	
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return YES;
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

#pragma mark Table View Delegate methods
-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView
		accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellAccessoryNone;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.pastTrades count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	NSUInteger row = [indexPath row];
	NSString *cellText = [pastTrades objectAtIndex:row];
	cell.textLabel.text = cellText;
	[cellText release];
	return cell;
}


- (void)dealloc {
    [super dealloc];
}


@end

