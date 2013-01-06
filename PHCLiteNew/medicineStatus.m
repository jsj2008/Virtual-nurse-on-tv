//
//  medicineStatus.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 3/26/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "medicineStatus.h"
#import "remindMed.h"
#import "classMedicine.h"
#import "classDatabaseOperations.h"
@implementation medicineStatus
@synthesize takenArray;
@synthesize skipArray;
@synthesize laterArray;
@synthesize obj_user;
@synthesize med_obj;
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
    self.title=@"Medicine Log";
      
    self.navigationController.navigationBar.hidden=NO;
    NSLog(@"%d",obj_user.userId);
    
    UIBarButtonItem *barCancle=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(Cancle)];
    self.navigationItem.leftBarButtonItem=barCancle;   
    takenArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getStatus:@"taken" :obj_user.userId]];
      skipArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getStatus:@"skip" :obj_user.userId]];
   laterArray=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getStatus:@"remindlater" :obj_user.userId]];
    NSLog(@"Taken  %@",takenArray);
    NSLog(@"Skip %@",skipArray);
    NSLog(@"Remind Later %@",laterArray);

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
-(void)Cancle
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 3;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if(section==0)
	{
		return @"Medicines Taken";
        
	}
	if(section==1)
	{
		return @"Medicines Skipped";
        
	}
    if(section==2)
	{
		return @"Medicines to be remind later";
        
	}
	return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
		if (takenArray.count==0) {
            return 1;
        }
    
        else{   return takenArray.count;}
      
		
    }
    else if(section==1)
    {
        if (skipArray.count==0) {
            return 1;
        }
        
        else{ 
       
            return skipArray.count;
        
    }
        return 1;
    }  
    else if(section==2)
    {	if (laterArray.count==0) {
        return 1;
    }
        
    else{ 
      
            return laterArray.count;
        
         }
    }
	return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(indexPath.section==0)
    {
        return 50;
    }
    
    
    
    if(indexPath.section==1)
    {
        return 50;
    }
    
    if(indexPath.section==2)
    {
        return 50;
    }
    
    

    
    return 55;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        cell.textLabel.font=[UIFont fontWithName:@"Futura" size:14.0f];
        cell.detailTextLabel.font=[UIFont fontWithName:@"Futura" size:12.0f];
        cell.textLabel.textColor=[UIColor blackColor];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryView=nil;
        
     
            
                       
    // Configure the cell...
    
    if(indexPath.section==0)
    {
        if(takenArray.count==0)
        {
            cell.textLabel.text=@"You have not Taken any medicine";
        }
    else
    {cell.textLabel.text = [self.takenArray objectAtIndex:indexPath.row];
            }
    }
    if(indexPath.section==1)
    {
        if(skipArray.count==0)
        {
            cell.textLabel.text=@"You have not Skipped any medicine";
        }
        else
        {          
       cell.textLabel.text = [self.skipArray objectAtIndex:indexPath.row];
           
    }
    }
    if(indexPath.section==2)
    {
        if(laterArray.count==0)
        {
            cell.textLabel.text=@"You have not select any for later reminder";
        }
        else
        { 
        
        cell.textLabel.text = [self.laterArray objectAtIndex:indexPath.row];    
    } 
    }
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}
@end
