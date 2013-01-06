//
//  classDosageFrequency.m
//  i_strip
//
//  Created by Avi Kulkarni on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "classDosageFrequency.h"
#import "classMedicine.h"
#import "classMedicineTime.h"
#import "classAudio.h"
#import "classUser.h"

@implementation classDosageFrequency
@synthesize objMedicine,selectedDosageFrequency;

@synthesize myAudioPlayer;
@synthesize objUser;

- (id)initWithStyle:(UITableViewStyle)style 
{
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) 
	{
		
		        

		
    }
    return self;
}



- (void)viewDidLoad 
{
    [super viewDidLoad];
    
	
	self.title=@"Dosage frequency";
	
	
	//hide back button
	self.navigationItem.hidesBackButton=YES;
	
	// add setting button to navigaion bar at right side
	self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)] autorelease];	
	
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)] autorelease];	
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    [[self tableView] setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]]];

	// initialize the dosage frequency;
	selectedDosageFrequency=objMedicine.medicineDosesFrequency;
    
    // if initial dosage frequency is 0 then set default frequency
    if (selectedDosageFrequency==0)
    {
        selectedDosageFrequency=1;
    }
    
    if(objUser.audioStatus==YES)
    {

//        if(objUser.language==1)
//        {
    NSMutableArray * array=[[NSMutableArray alloc] init];
    [array addObject:@"selectMedicineFrequency"];
    [myAudioPlayer playAudios:array ];
    [array release];
//        }
//        else if(objUser.language==2)
//        {
//            NSMutableArray * array=[[NSMutableArray alloc] init];
//            [array addObject:@"2selecteManyTimesFrequency"];
//            [myAudioPlayer playAudios:array ];
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


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//	if(section==0)
//	{
//		return [NSString stringWithFormat:@"Frequency"];
//	
//	}
	
	return nil;
}


- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	if(section==0)
	{
		return @"Select how many times do you want to take this medicine in a day.";
        
	}
	
	return nil;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	
	if(section==0)
	{
		return 4;
	}
    
	return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	
    cell.textLabel.font=[UIFont fontWithName:@"Futura" size:14.0f];
    cell.detailTextLabel.font=[UIFont fontWithName:@"Futura" size:14.0f];
	cell.accessoryType=UITableViewCellAccessoryNone;
	cell.detailTextLabel.text=nil;
	
	
	 if(indexPath.section==0)
	{
		
		switch (indexPath.row)
		{
			case 0:cell.textLabel.text=@"One";		
				break;
				
			case 1:cell.textLabel.text=@"Two";		
				break;
				
			case 2:cell.textLabel.text=@"Three";		
				break;
				
			case 3:cell.textLabel.text=@"Four";		
				break;
				
			case 4:cell.textLabel.text=@"Five";		
				break;
				
			case 5:cell.textLabel.text=@"Six";		
				break;
				
		}	
		
		if(selectedDosageFrequency==indexPath.row+1 && indexPath.row==0)
		{
			
			cell.accessoryType=UITableViewCellAccessoryCheckmark;
			cell.detailTextLabel.text=[NSString stringWithFormat:@"Take %@ %d time in a day",objMedicine.medicineName, selectedDosageFrequency];
			
			
		}
      else  if(selectedDosageFrequency==indexPath.row+1 && indexPath.row>0)
		{
			
			cell.accessoryType=UITableViewCellAccessoryCheckmark;
			cell.detailTextLabel.text=[NSString stringWithFormat:@"Take %@ %d times in a day",objMedicine.medicineName, selectedDosageFrequency];
			
			
		}

		
		
	}

	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	// remove selection
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
	// remove previous selection	
    NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
    
    for (NSIndexPath *cellIndexPath in visiblePaths)
    {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:cellIndexPath];
        
        cell.detailTextLabel.text=nil;
        cell.accessoryType=UITableViewCellAccessoryNone;

        
    }
    
	
    // set the currently seleced frequecy    
    selectedDosageFrequency=indexPath.row+1;
    
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	
    if(selectedDosageFrequency==indexPath.row+1 && indexPath.row==0)
    {
        
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        cell.detailTextLabel.text=[NSString stringWithFormat:@"Take %@ %d time in a day",objMedicine.medicineName, selectedDosageFrequency];
        
        
    }
    else  if(selectedDosageFrequency==indexPath.row+1 && indexPath.row>0)
    {
        
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        cell.detailTextLabel.text=[NSString stringWithFormat:@"Take %@ %d times in a day",objMedicine.medicineName, selectedDosageFrequency];
        
        
    }
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


- (void)dealloc
{
	
	self.objMedicine=nil;
    [super dealloc];
}

-(void)done
{
	
    [myAudioPlayer stopAudio];
    
	// this following colde will erase time and quanity if you change dosage frequency
	// if you select dosage freq. 4 then sent time and qtty and before saveing chagne
	// frequency to 3 then 4th time and quantiy will be erased
	
	
    // finally set selected frequency to objMedicine
    self.objMedicine.medicineDosesFrequency= selectedDosageFrequency;
    
//    
//	if(objMedicine.medicineDosesFrequency==1)
//	{
//		
//		
//				
//		
//	}
//	if(objMedicine.medicineDosesFrequency==2)
//	{
//		
//		
//		
//		
//		
//	}
//	if(objMedicine.medicineDosesFrequency==3)
//	{
//		
//		
//		
//		
//	}
//	if(objMedicine.medicineDosesFrequency==4)
//	{
//		
//		
//				
//	}
//	
//	
//	if(objMedicine.medicineDosesFrequency==5)
//	{
//		
//		
//		
//	}
    
    // reset medicine time and quantity according to new frequency
    for(int i=selectedDosageFrequency; i<=5;i++)
    {
        
        classMedicineTime * objTime=[self.objMedicine.medicineTimes objectAtIndex:i];
        objTime.times=nil;
        objTime.pillQuantity=0;
        
    }
    
    
	
	[self dismissModalViewControllerAnimated:YES];
	//[self.navigationController popViewControllerAnimated:YES];

}


-(void)cancel
{
    
    
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void)playAudio
{
    
    NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"pleaseEnterMedicineName", nil];
    [myAudioPlayer playAudios:array];
    [array release];
    

    
}


@end

