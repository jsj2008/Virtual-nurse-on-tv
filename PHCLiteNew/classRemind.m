//
//  classRemind.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 4/26/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "classRemind.h"
#import "classInform.h"

@implementation classRemind
@synthesize tableView1;
@synthesize switchWeight;
@synthesize switchGlucose;
@synthesize switchBP;
@synthesize switchHeamo;
@synthesize switchHba1c;
@synthesize aUser;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        arrayName=[[NSMutableArray alloc]initWithObjects:@"Morning",@"Afternoon",@"Evening",@"Night", nil];
        Btnsave=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(TouchSave)];
      //  self.navigationItem.rightBarButtonItem=Btnsave;
        
    }
    return self;
}

- (void)dealloc
{
    [tableView1 release];
    [switchWeight release];
    [switchGlucose release];
    [switchBP release];
    [switchHeamo release];
    [switchHba1c release];
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
     self.title=@"Tracker Settings";

    //self.parentViewController.view.backgroundColor = [UIColor colorWithRed:0.2 green:0.6 blue:1 alpha:1.0] ;
        //--- set the tableview background as clear to view the backsplash
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableView1:nil];
    [self setSwitchWeight:nil];
    [self setSwitchGlucose:nil];
    [self setSwitchBP:nil];
    [self setSwitchHeamo:nil];
    [self setSwitchHba1c:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    return 4;
}

-(void)TouchSave
{
    
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
            cell.textLabel.text=[arrayName objectAtIndex:0];
            cell.detailTextLabel.text=@"";
            break;
        case 1:
            cell.textLabel.text=[arrayName objectAtIndex:1];
            cell.detailTextLabel.text=@"";
            break;
        case 2:
            cell.textLabel.text=[arrayName objectAtIndex:2];
            cell.detailTextLabel.text=@"";
            break;
        case 3:
            cell.textLabel.text=[arrayName objectAtIndex:3]; 
            cell.detailTextLabel.text=@"";
            break;
                  
            
    }
    
    // Configure the cell...
    
    return cell;
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
       
   }




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        
      /*  classDiffTime *objDiff=[[classDiffTime alloc]initWithNibName:@"classDiffTime" bundle:nil];
        objDiff.strName=[arrayName objectAtIndex:indexPath.row];
        objDiff.delegate=self;
        [self.navigationController pushViewController:objDiff animated:YES];*/     
        classInform *objInform=[[classInform alloc]initWithNibName:@"classInform" bundle:nil];
          objInform.aUser=aUser;
           objInform.timespan=indexPath.row+1;
        //  objInform.arrayFlags=arrayFlags;
        [self.navigationController pushViewController:objInform animated:YES];

        [objInform release];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
/*-(void)TouchSave
{
    
    classDiffTime *obj_Time=[[classDiffTime alloc]initWithNibName:@"classDiffTime" bundle:nil];
    
    UINavigationController * navC=[[UINavigationController alloc]initWithRootViewController:obj_Time];
    // user.delegate=self;
    obj_Time.delegate=self;
    
    // [self.navigationController presentModalViewController:navC animated:YES];
    [self presentModalViewController:navC animated:YES]; 
    // [self.tableView1 reloadData];
    [obj_Time release];  
    
}*/
-(void)selectCancle
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


@end