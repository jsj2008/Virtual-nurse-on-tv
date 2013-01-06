//
//  classBayMedicationList.m
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 29/11/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classBayMedicationList.h"
#import "classCompartmentData.h"

#import "classDatabaseOperations.h"
#import "classUser.h"
#import "classAudio.h"
@implementation classBayMedicationList
@synthesize arrayMed;
@synthesize objMed;
@synthesize strSpan;
@synthesize userid;
@synthesize bayno;
@synthesize objUser;
@synthesize myAudioPlayer;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        
        
        self.modalTransitionStyle =UIModalPresentationPageSheet;
        
        self.title=@"Medicine List" ;
        
       
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
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
   
  
    UIBarButtonItem *rightbtn =[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem=rightbtn;
    arrayMed=[classDatabaseOperations getBayMedicineListForUser:userid :bayno];

    [self.tableView reloadData];
    
    
    
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

    if(self.objUser.audioStatus==YES)
    {
        if(self.objUser.language==1)
        {
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"curmedlist"];
            
            [self.myAudioPlayer playAudios:array];
            [array release];
        }
        
        else if(self.objUser.language==2)
        {
            
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"2MedLIst"];
            
            [self.myAudioPlayer playAudios:array];
            [array release];
            
            
        }
        
    }


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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section==0)
    {
        return [arrayMed count];
    }
    return 0 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }


       
    
    objMed=[arrayMed objectAtIndex:indexPath.row];
    
    
    
    cell.textLabel.text=objMed.bayMedName;
        
        cell.detailTextLabel.textColor=[UIColor purpleColor];    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"Qty:- %.1f",objMed.bayMedQty];
    
        if(objMed.state==1)
        {
            
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            
            
            
            
            
        }
        
        else
        {  
            cell.accessoryType=UITableViewCellAccessoryNone;
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

-(void)done
{
    
    [self dismissModalViewControllerAnimated:YES];
    
}




@end