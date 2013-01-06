//
//  classdailyInf.m
//  PHCLite_New
//
//  Created by Avi Kulkarni on 08/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classdailyInf.h"
#import "classDiffTime.h"

@implementation classdailyInf
@synthesize tableView1;
@synthesize Picker_View;
@synthesize BackSideView;
@synthesize PickerBackView;
@synthesize PickerView1;
@synthesize lblName1;
@synthesize tableview1;
@synthesize obj_time;
@synthesize lbl1;
int i;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        array_name=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
        
        arryTime=[[NSMutableArray alloc]init];
        
        for (i=1; i<60; i++)
        {
            [arryTime addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        array_Time=[[NSArray alloc]initWithObjects:@"AM",@"PM", nil];
        
        lbl1=[[UILabel alloc]initWithFrame:CGRectMake(250,5,80, 30)];
        
        
    }
    return self;
}

- (void)dealloc
{
    [Picker_View release];
    [tableview1 release];
    [lblName1 release];
    [tableView1 release];
    [Picker_View release];
    [Picker_View release];
    [BackSideView release];
    [PickerBackView release];
    [PickerView1 release];
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
    
    UIBarButtonItem *barCancle=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    self.navigationItem.leftBarButtonItem=barCancle;
    
    UIBarButtonItem *barSave=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(Save)];
    self.navigationItem.rightBarButtonItem=barSave;
    [barCancle release];
    [barSave release];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPicker_View:nil];
    [self setTableview1:nil];
    [self setLblName1:nil];
    [self setTableView1:nil];
    [self setPicker_View:nil];
    [self setPicker_View:nil];
    [self setPicker_View:nil];
    [self setBackSideView:nil];
    [self setPickerBackView:nil];
    [self setPickerView1:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)cancle
{
    
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissModalViewControllerAnimated:YES];

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
        return 6;
    }
    
    
    return 0;
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
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text=@"Time 1";
            [cell.contentView addSubview:lbl1];
            
            break;
        case 1:
            cell.textLabel.text=@"Time 2";
            break;
        case 2:
            cell.textLabel.text=@"Time 3";
            break;
        case 3:
            cell.textLabel.text=@"Time 4";
            break;
        case 4:
            cell.textLabel.text=@"Time 5";
            break;
        case 5:
            cell.textLabel.text=@"Time 6";
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
        
        // declare a cgpoint variable
        CGPoint point;
        
        //get the old cordinate
        point=self.PickerBackView.center;
        
        // set new cordinate
        point.y=322;
        
        //assigne new cordinate
        self.PickerBackView.center=point;
        
        [UIView commitAnimations];            
    }
    
       
}

#pragma mark picker methodes
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if (component==0)
    {
        return [array_name count];
    }
    else if(component==1)
    {
    
        return [arryTime count];
    }
    else if(component==2)
    {
        return [array_Time count];
    
    }
    
    return 0;
	
	
}    

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
	if (component==0)
    {
        return [array_name objectAtIndex:row];
    }
    else if(component==1)
    {
        return [arryTime objectAtIndex:row];
    
    }
    else if(component==2)
    {
        return [array_Time objectAtIndex:row];
    
    }
    
    return 0;
     	
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
      
   lbl1.text=[arryTime objectAtIndex:row];
    
}
-(void)Save
{
    [self dismissModalViewControllerAnimated:YES];
    
   // [self.navigationController popViewControllerAnimated:YES];
   // [tableview1 reloadData];
 }



@end


