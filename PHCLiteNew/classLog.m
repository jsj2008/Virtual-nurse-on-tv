//
//  classLog.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 3/12/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "classLog.h"
#import "classWeightLog.h"
#import "vcUserList.h"
#import "MediLog.h"
#import "classAllLogs.h"
@implementation classLog
@synthesize logTable;
@synthesize aUser;
@synthesize myAudioPlayer;
@synthesize arrayOfLog;
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
    
    //self.parentViewController.view.backgroundColor = [UIColor  clearColor];
    self.parentViewController.view.alpha = 1.00;
    self.navigationController.navigationBar.hidden=NO;

    //--- set the tableview background as clear to view the backsplash
       
    
    
    [super viewDidLoad];
    arrayOfLog=[[NSArray alloc]initWithObjects:@"Weight",@"BloodGlucose",@"BloodPressure",@"Hemoglobin",@"GlycoHemoglobin",@"Medicine",@"All Logs", nil];
    
        self.title=@"Logs";
    
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
    NSString *strImg1=@"backImage1.png";
    self.navigationController.navigationBar.hidden=NO;

    UIImageView *logoView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:strImg1]];
    NSString *strImg=[classDatabaseOperations getNurseImg:aUser.userId];
    NSLog(@"%@image",strImg);
     NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:strImg];
    NSData *myData = [[[NSData alloc] initWithContentsOfFile:databasePath] autorelease];
    
    NSLog(@"%@image",strImg);
    
   
    if ([strImg isEqualToString:@"null"])
    {
        logoView.image=[UIImage imageNamed:strImg1];
    }
    else{
        NSLog(@"Nurse is %@",strImg);
        logoView.image=[UIImage imageWithData:myData];
    }
    
    
    logoView.frame = CGRectMake(220, 0, 43, 43);
    [logoView release];
    
   // [self.navigationController.navigationBar addSubview:logoView];
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

    // Return the number of sections.
    return  2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (section==0) {
        return 1;
    }
     if (section==1) {
    return [arrayOfLog count]-1;
     }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        

    }
    
    if (indexPath.section==0) {
        cell.textLabel.text= [arrayOfLog objectAtIndex:[arrayOfLog count]-1];
        cell.detailTextLabel.font=[UIFont fontWithName:@"Futura" size:13.0f];
    }
   else if (indexPath.section==1)
   {
       cell.textLabel.text= [arrayOfLog objectAtIndex:indexPath.row];
       cell.detailTextLabel.font=[UIFont fontWithName:@"Futura" size:13.0f];
   }

    // Configure the cell...
    
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
    NSLog(@"IndexPath.row= %d",indexPath.row);
    if(indexPath.row ==7)
    {
        MediLog *obj_med=[[MediLog alloc]initWithNibName:@"MediLog" bundle:nil];
        obj_med.aUser =aUser;
        [self.navigationController pushViewController:obj_med animated:YES];                
        [obj_med release]; 
        
        
    }
    if(indexPath.section ==0)
    {
        classAllLogs *classAllLogsObj=[[classAllLogs alloc]initWithNibName:@"classAllLogs" bundle:nil];
        classAllLogsObj.aUser =aUser;
        [self.navigationController pushViewController:classAllLogsObj animated:YES];
        [classAllLogsObj release];
        
        
    }
    else
    {
        // Navigation logic may go here. Create and push another view controller.
        classWeightLog *objWeight=[[classWeightLog alloc]initWithNibName:@"classWeightLog" bundle:nil];
        //  objInform.arrayFlags=arrayFlags;
        objWeight.aUser=aUser;
        objWeight.strName=[arrayOfLog objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:objWeight animated:YES];
        //[self.navigationController dismissModalViewControllerAnimated:YES];
        [objWeight release];
        
    }
    
    
    
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
