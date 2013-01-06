//
//  audioSetting.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 3/12/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "audioSetting.h"
#import "classDatabaseOperations.h"
#import "classSetting3.h"
@implementation audioSetting
@synthesize audioTable;
@synthesize switchAudio;
@synthesize aUser;
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
    
    
   self.title=@"Audio Setting";
    
    UIBarButtonItem *barSave=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(Save)];
    self.navigationItem.rightBarButtonItem=barSave;
    [barSave release];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];

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

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    // Configure the cell...
    
    switchAudio=[[UISwitch alloc]initWithFrame:CGRectMake( 200,10,80,30 ) ];
    
    
    if(aUser.audioStatus==YES) 
    {
        NSLog(@"\n\n\naudio status ON");   
        switchAudio.on=YES;
    }
    else if(aUser.audioStatus==NO)
    {
        
        NSLog(@"\n\n\naudio status OFF");   
        
        switchAudio.on=NO;
    }
    else
    {
        switchAudio.on=YES;
    }


    cell.textLabel.text=@"Audio";
   [cell.contentView addSubview:switchAudio ];
     [switchAudio  release];
    
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
- (void)Save
{
    NSString *audioStatus;
    if(switchAudio.on==YES)
    {
        aUser.audioStatus=YES;
         audioStatus=@"YES";
     
    
    NSString *query=[NSString stringWithFormat:@"update user set audiostatus='%@' where userid=%d",audioStatus,aUser.userId];
      [classDatabaseOperations addData:query];
       
    }
    else
    {
        
        aUser.audioStatus=NO;
         audioStatus=@"NO";
  
    
        
        
        NSString *query=[NSString stringWithFormat:@"update user set audiostatus='%@' where userid=%d",audioStatus,aUser.userId];
        
        [classDatabaseOperations addData:query];
        

    }
    
    
    
    classSetting3 *parent=[self.navigationController.viewControllers objectAtIndex:0];                            
    
     parent.aUser=aUser;
    [audioStatus release];
    [self.navigationController popViewControllerAnimated:YES];    
}

#pragma mark - Table view delegate
-(IBAction)audioStatusChanged:(id)sender
 
 {
  
     if(switchAudio.on==YES)
     {
        
         aUser.audioStatus=YES;
     }
     else
     {
         aUser.audioStatus=NO;
     }
     
 }
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
