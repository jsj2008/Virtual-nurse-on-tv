//
//  classMonthlyDetails.m
//  PHCLiteNew
//
//  Created by Avi Kulkarni on 27/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classMonthlyDetails.h"


@implementation classMonthlyDetails
@synthesize table_view;
@synthesize Array_name;
@synthesize aUser;
@synthesize label;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        Array_name=[[NSMutableArray alloc]initWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"Octomber",@"November",@"December", nil];
        
        
        
    }
    return self;
}

- (void)dealloc
{
    [table_view release];
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
    UIBarButtonItem *barSave=[[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(Save)]autorelease];
    self.navigationItem.rightBarButtonItem=barSave;
    
    UIBarButtonItem *barCancle=[[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(Cancel)]autorelease];
    self.navigationItem.leftBarButtonItem=barCancle;
    UILabel * tempLebel=[[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 180, 30)]autorelease];
    tempLebel.text=[[NSString alloc]initWithFormat:@"%@ Monthly Reminder:",label];
  //  tempLebel.font=[UIFont fontWithName:@"Futura" size:14.0f];
    //[tempLebel release];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTable_view:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//--------------––––---------------------------------------------------------
//Table View methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;


}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 35;
        
    }
    
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
}
   
    cell.textLabel.font=[UIFont fontWithName:@"Futura" size:17];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text=[Array_name objectAtIndex:0];
            break;
        case 1:
            cell.textLabel.text=[Array_name objectAtIndex:1];
            break;
        case 2:
            cell.textLabel.text=[Array_name objectAtIndex:2];
            break;
        case 3:
            cell.textLabel.text=[Array_name objectAtIndex:3];
            break;
        case 4:
            cell.textLabel.text=[Array_name objectAtIndex:4];
            break;
        case 5:
            cell.textLabel.text=[Array_name objectAtIndex:5];
            break;
        case 6:
            cell.textLabel.text=[Array_name objectAtIndex:6];
            break;
        case 7:
            cell.textLabel.text=[Array_name objectAtIndex:7];
            break;
        case 8:
            cell.textLabel.text=[Array_name objectAtIndex:8];
            break; 
        case 9:
            cell.textLabel.text=[Array_name objectAtIndex:9];
            break;
        case 10:
            cell.textLabel.text=[Array_name objectAtIndex:10];
            break; 
        case 11:
            cell.textLabel.text=[Array_name objectAtIndex:11];
            break;
            
        default:
            break;
    }
    
    // Configure the cell...
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
}
-(void)Save
{
    
    [self dismissModalViewControllerAnimated:YES];
    
}
-(void)Cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
