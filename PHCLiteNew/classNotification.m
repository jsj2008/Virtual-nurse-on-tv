//
//  classNotification.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 4/19/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "classNotification.h"
#import "classWeeklyInfo.h"
#import "classMonthlyDetails.h"
#import "classLocalNotificationSettings.h"
@implementation classNotification
@synthesize aUser;
@synthesize label;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel * tempLebel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 180, 30)];
    tempLebel.text=[[NSString alloc]initWithFormat:@"%@ time Reminder:",label];
    tempLebel.font=[UIFont fontWithName:@"Futura" size:14.0f];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
   
    cell.textLabel.font=[UIFont fontWithName:@"Futura" size:17];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text=@"Daily";
            break;
        case 1:
            cell.textLabel.text=@"Weekly";
            break;
        case 2:
            cell.textLabel.text=@"Monthly";
            break;
       
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        classLocalNotificationSettings * objNotificationSetting=[[classLocalNotificationSettings alloc] initWithStyle:UITableViewStyleGrouped];
        objNotificationSetting.label=self.label;
        objNotificationSetting.objUser=self.aUser;
        //      objNotificationSetting.myAudioPlayer=self.myAudioPlayer;
        objNotificationSetting.title=@"Daily Reminder";
        [self.navigationController pushViewController:objNotificationSetting animated:YES];
        [objNotificationSetting release];

        
    }
    else if(indexPath.row==1)
    {
        classWeeklyInfo * objNotificationSetting=[[classWeeklyInfo alloc] initWithNibName:@"classWeeklyInfo" bundle:nil];
         objNotificationSetting.label=self.label;
        objNotificationSetting.aUser=aUser;
        //      objNotificationSetting.myAudioPlayer=self.myAudioPlayer;
        objNotificationSetting.title=@" Weekly Reminder";
        [self.navigationController pushViewController:objNotificationSetting animated:YES];
        [objNotificationSetting release];
        

    }
    else if(indexPath.row==2)
    {
        classMonthlyDetails * objNotificationSetting=[[classMonthlyDetails alloc] initWithNibName:@"classMonthlyDetails" bundle:nil];        objNotificationSetting.label=self.label;
        objNotificationSetting.aUser=self.aUser;
        //      objNotificationSetting.myAudioPlayer=self.myAudioPlayer;
        objNotificationSetting.title=@"Monthly Reminder";
        [self.navigationController pushViewController:objNotificationSetting animated:YES];
        [objNotificationSetting release];
  
    }

}
@end
