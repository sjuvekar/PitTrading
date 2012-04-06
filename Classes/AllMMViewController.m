//
//  FirstViewController.m
//  PitTrading
//
//  Created by Sudeep Juvekar on 3/5/10.
//  Copyright UC Berkeley 2010. All rights reserved.
//

#import "AllMMViewController.h"
#import "TradeViewController.h"
#import "PitTradingAppDelegate.h"

@implementation AllMMViewController

@synthesize marketMakers;
@synthesize tradeViewController;
@synthesize mmImages;

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 if (self = [super initWithStyle:style]) {
 }
 return self;
 }
 */

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Initialize Market Makers
	NSBundle *bundle = [NSBundle mainBundle];
	
	NSString *plist = [bundle pathForResource:@"marketMakers" ofType:@"plist"];
	NSArray *array = [[NSArray alloc] initWithContentsOfFile:plist];
	self.marketMakers = array;
	[array release];
	
	NSString *imageFile = [bundle pathForResource:@"images" ofType:@"plist"];
	NSArray *imageArray = [[NSArray alloc] initWithContentsOfFile:imageFile];
	self.mmImages = imageArray;
	[imageArray release];
}

/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
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
	return NO;
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
	return UITableViewCellAccessoryDisclosureIndicator;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.marketMakers count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	NSUInteger row = [indexPath row];
	NSArray *detailArray = [self.marketMakers objectAtIndex:row];
	
	NSString *cellTitle = [detailArray objectAtIndex:0];
	cell.textLabel.text = cellTitle;
	
	NSString *detailTitle = [detailArray objectAtIndex:1];
	cell.detailTextLabel.text = detailTitle;
	
	UIImage *cellImage = [UIImage imageNamed:[self.mmImages objectAtIndex:row]];
	cell.imageView.image = cellImage;
	
	[cellTitle release];
	[detailTitle release];
	[cellImage release];
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSUInteger row = [indexPath row];
	TradeViewController *tempController = [[TradeViewController alloc] initWithNibName:@"TradeView" bundle:nil];
	self.tradeViewController = tempController;
	[tempController release];

		
	tradeViewController.mmNumber = row;
	tradeViewController.title = [[NSString alloc] initWithFormat:@"Trade for MM%d", row+1];
	
	PitTradingAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.pitTradingNavController pushViewController:tradeViewController animated:YES];
	
}

// Height of row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80.0;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


- (void)dealloc {
	[tradeViewController release];
    [super dealloc];
}


@end

