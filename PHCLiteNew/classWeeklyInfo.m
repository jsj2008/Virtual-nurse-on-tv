//
//  classWeeklyInfo.m
//  PHCLiteNew
//
//  Created by Avi Kulkarni on 19/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classWeeklyInfo.h"


@implementation classWeeklyInfo
@synthesize PickerWeek;
@synthesize tableviewWeek;
@synthesize BackSideView;
@synthesize PickerTab;
@synthesize aUser;
@synthesize label;
@synthesize array_Weekname;
@synthesize arrayHours,aarayMinute,arrayName;
int i;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        array_Weekname=[[NSArray alloc]initWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
        arrayHours=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
        arrayMinute=[[NSMutableArray alloc]init];
        
        for (i=1; i<60; i++)
        {
            [arrayMinute addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        arrayName=[[NSMutableArray alloc]initWithObjects:@"AM",@"PM", nil];
        
    }
    return self;
}
- (void)dealloc
{
    [tableviewWeek release];
    [BackSideView release];
    [PickerTab release];
    [PickerWeek release];
    [label release];
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
    tempLebel.text=[[NSString alloc]initWithFormat:@"%@ Weekly Reminder:",label];
    tempLebel.font=[UIFont fontWithName:@"Futura" size:14.0f];
    [label release];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableviewWeek:nil];
    [self setBackSideView:nil];
    [self setPickerTab:nil];
    [self setPickerWeek:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section==0)
    {
        return 4;
    }
    
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 40;
        
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
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text=@"First Week";
            break;
        case 1:
            cell.textLabel.text=@"Second Week";
            break;
        case 2:
            cell.textLabel.text=@"Third Week";
            break;
        case 3:
            cell.textLabel.text=@"Last Week";
            break;
                    
        default:
            break;
    }
    
    // Configure the cell...
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if(indexPath.section==0)
    {
        [UIView beginAnimations:@"BringPickerOut" context:nil];
        [UIView setAnimationDuration:0.5];
        
        // declate a cgpoint variable
        CGPoint point;
        
        //get the old cordinate
        point=self.BackSideView.center;
        
        // set new cordinate
        point.y=322;
        
        //assigne new cordinate
        self.BackSideView.center=point;
        
        [UIView commitAnimations];  
    
    }


}
#pragma mark picker methodes
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView==PickerWeek)
    {
        return 1;
    }
    else if(pickerView==PickerTab)
    {
	 return 3;
    }
    
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if (pickerView==PickerWeek) 
    {
         return [array_Weekname count];
    }
    else if(pickerView==PickerTab)
    {
         if(component==0)
        {
            
            return [arrayHours count];
        }
        else if(component==1)
        {
            return [arrayMinute count];
            
        }
        else if(component==2)
        {
            return [arrayName count];
            
        }

    
    
    
    }
        
       
    return 0;
	
	
}    

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    if (pickerView==PickerWeek)
    {
        return [array_Weekname objectAtIndex:row];
    }
    else if(pickerView==PickerTab)
    {
        
         if(component==0)
        {
            return [arrayHours objectAtIndex:row];
            
        }
        else if(component==1)
        {
            return [arrayMinute objectAtIndex:row];
            
        }
        else if(component==2)
        {
            return [arrayName objectAtIndex:row];
            
        }
        
   }
	
       return 0;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
  	
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
