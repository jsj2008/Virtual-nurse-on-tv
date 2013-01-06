//
//  classSelectedTime.m
//  i_strip
//
//  Created by Avi Kulkarni on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "classSelectedTime.h"
#import "commanFunctions.h"
#import "classMedicine.h"
#import "classMedicineTime.h"
#import "classTimeAndQuantityPicker.h"
#import "classAudio.h"
#import "classUser.h"

@implementation classSelectedTime
@synthesize objMedicine;
@synthesize objMedicineLocal;
@synthesize datePicker;
@synthesize myAudioPlayer;
@synthesize objUser;

- (id)initWithStyle:(UITableViewStyle)style
{
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) 	
	{
		self.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
		
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// set title for view	
	self.title=@"Medicine Dose Time";
	
	//hide back button
	self.navigationItem.hidesBackButton=YES;
	
	// add setting button to navigaion bar at right side
	
	self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)] autorelease];
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)] autorelease];	
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    [[self tableView] setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]]];
     self.tableView.separatorColor=[UIColor blackColor];

    //[self initializeLocalMedicineObject];
    
    if(objUser.audioStatus==YES)
    {
//
//        if(objUser.language==1)
//        {
    NSMutableArray * array=[[NSMutableArray alloc] init];
    [array addObject:@"TimeAndQuantityForEachDose"];
    [myAudioPlayer playAudios:array];
    [array release];
       // }
        
//        else if(objUser.language==2)
//        {
//            NSMutableArray * array=[[NSMutableArray alloc] init];
//            [array addObject:@"2Time&PillQty"];
//            [myAudioPlayer playAudios:array];
//            [array release];
//            
//            
//        }
    }
}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	[self.tableView reloadData];
}

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

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    
	
	
	if(section==0)
	{
		
		return objMedicine.medicineDosesFrequency;
	}
	
	return 0;
	
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //	if(section==0)
    //	{
    //		return [NSString stringWithFormat:@"Dose time"];
    //		
    //	}
	
	return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	if(section==0)
	{
		return @"Select time on which do you want to take these medicine dosage.";
        
	}
	
	return nil;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	
	
    cell.textLabel.font=[UIFont fontWithName:@"Futura" size:14.0f];
    cell.detailTextLabel.font=[UIFont fontWithName:@"Futura" size:13.0f];
	
	if (indexPath.section==0)
	{
		// get the selected tiem and pillquantity

        NSString *medicineTime=[(classMedicineTime *)[objMedicineLocal.medicineTimes objectAtIndex:indexPath.row ] times];
        float pillQuantity=[[objMedicineLocal.medicineTimes objectAtIndex:indexPath.row ] pillQuantity];
        
        
        
        if(medicineTime !=nil )
        {
            
            NSString * timeSpanInString= [commanFunctions convertIntTimeSpanToString:[commanFunctions getTimeSpanOfTime:medicineTime]];

            
        cell.textLabel.text=[NSString stringWithFormat:@"%@ %@",timeSpanInString,medicineTime]; 
        cell.detailTextLabel.text=[NSString stringWithFormat:@"Take %.1f pills of %@ on  %@ ",pillQuantity,objMedicineLocal.medicineName,medicineTime];
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
            
           
            
        }
        else // if time is not set
        {
            
            switch (indexPath.row) 
            {
                case 0:cell.textLabel.text=@"Select time & pill quantity for 1st dose";
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

                    
                    break;
                    
                case 1:cell.textLabel.text=@"Select time & pill quantity for 2nd dose";
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

                    
                    break;
                    
                case 2:cell.textLabel.text=@"Select time & pill quantity for 3rd dose";
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

                    
                    break;
                    
                default: cell.textLabel.text=[NSString stringWithFormat:@"Select time & pill quantity for %dth dose",indexPath.row+1];
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

                    
                    break;
                    
                    
            }
            
            
        }
		
		
        
        
        
		
		
	}//end of seciton0
	
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
       
    classTimeAndQuantityPicker * objTimeAndQuantityPicker=[[classTimeAndQuantityPicker alloc]initWithNibName:@"classTimeAndQuantityPicker" bundle:nil];
    objTimeAndQuantityPicker.timeNumber=indexPath.row;
    objTimeAndQuantityPicker.objMedicine=self.objMedicineLocal;
    objTimeAndQuantityPicker.myAudioPlayer=self.myAudioPlayer;
    objTimeAndQuantityPicker.objUser=self.objUser;
    
    UINavigationController * navC=[[UINavigationController alloc] initWithRootViewController:objTimeAndQuantityPicker];
    [self presentModalViewController:navC animated:YES];     
    [objTimeAndQuantityPicker release];
    [navC release];
    
    
	
    
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


-(void)initializeLocalMedicineObject
{
    
    
    
  self.objMedicineLocal= [commanFunctions createCopyOfMedicine:self.objMedicine];
    
 
    
    
}

-(void)done
{
    
    self.objMedicine.medicineTimes=nil;
    self.objMedicine.medicineTimes=[[[NSMutableArray alloc] init] autorelease];
    
    NSLog(@"%d",[objMedicine.medicineTimes count]);
    
    for(classMedicineTime * objMedTime in objMedicineLocal.medicineTimes)
    {
        
        [self.objMedicine.medicineTimes addObject:objMedTime];
        
        
    }
 
    
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void)cancel
{
    
    [self dismissModalViewControllerAnimated:YES];
}


-(void)showPicker
{
    
    UIView * viewWithPicker=[[UIView alloc] initWithFrame:CGRectMake(0, 586, 320, 333)];
    viewWithPicker.tag=100;
    viewWithPicker.backgroundColor=[UIColor blackColor];
    
    
    UIButton * btnDone=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnDone setBounds:CGRectMake(273, 18, 72, 32)];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(doneTimeAndQuantitySelection) forControlEvents:UIControlEventTouchUpInside];
    
    [viewWithPicker addSubview:btnDone];
    
    [self.view addSubview:viewWithPicker];
    
    [viewWithPicker release];
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=viewWithPicker.center;
    
    // set new cordinate
    point.y=333;
    point.x=160;    
    
    //assigne new cordinate
    viewWithPicker.center=point;
    
    
    [UIView commitAnimations];
    
    
    
}


-(void)doneTimeAndQuantitySelection
{
    
    
    UIView * viewWithPicker=[self.view viewWithTag:100];
    
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.8];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=viewWithPicker.center;
    
    // set new cordinate
    point.y=586;
    point.x=160;
    
    //assigne new cordinate
    viewWithPicker.center=point;
    //[viewWithPicker removeFromSuperview];
    
    [UIView commitAnimations];
    
    
    
    
}

-(void)resetPicker
{
    
    
    
    
    
}




- (void)dealloc 
{
	//[self.objMedicine release];
	
    [super dealloc];
}


@end

