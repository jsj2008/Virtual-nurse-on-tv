//
//  classTimeAndQuantityPicker.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/6/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classTimeAndQuantityPicker.h"
#import "classMedicineTime.h"
#import "classAudio.h"
#import "classUser.h"
#import "classMedicine.h"

//-- private variables
float selectedQuantity;


@implementation classTimeAndQuantityPicker
@synthesize objMedicine;
@synthesize timeNumber;
@synthesize arrayQuantityInNumber,arrayQuantityFormated;

@synthesize datePicker;
@synthesize simplePicker;
@synthesize lblDoseNumber;
@synthesize lblTime;
@synthesize lblPillQuantity;
@synthesize myAudioPlayer;
@synthesize objUser;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        
        
        myAudioPlayer=[[classAudio alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [datePicker release];
    [simplePicker release];
    [lblDoseNumber release];
    [lblTime release];
    [lblPillQuantity release];
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
    
    
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];

    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)] autorelease];
    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)] autorelease];

    // array as datasource of picker
	self.arrayQuantityInNumber=[[NSArray alloc]initWithObjects:@"0.5",@"1.0",@"1.5",@"2.0",@"2.5",@"3.0",@"3.5",@"4.0",@"4.5",@"5.0",@"5.5",@"6.0",@"6.5",@"7.0",@"7.5",@"8.0",@"8.5",@"9.0",@"9.5",@"10.0",nil];
	self.arrayQuantityFormated=[[[NSArray alloc]initWithObjects:@"0.5",@"1",@"1.5",@"2",@"2.5",@"3",@"3.5",@"4",@"4.5",@"5",@"5.5",@"6",@"6.5",@"7",@"7.5",@"8",@"8.5",@"9",@"9.5",@"10",nil] autorelease];
	
	
    //set default pill quantity
    selectedQuantity=0.5;

    if(objUser.audioStatus==YES)
    {

    [self playAudio];
    }
    self.title=[NSString stringWithFormat:@"Dose-%d",timeNumber+1];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:YES];
     [self resetPiker]; 
}

- (void)viewDidUnload
{
    [self setDatePicker:nil];
    [self setSimplePicker:nil];
    [self setLblDoseNumber:nil];
    [self setLblTime:nil];
    [self setLblPillQuantity:nil];
    [super viewDidUnload];
    
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



-(void)resetPiker
{
//------------- reset dateTime picker according to already selected value-------------
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;	
	[dateFormatter setDateFormat:@"h:mm:00 a"];	
	NSDate *myDateTime;     
    
    NSString *medicineTime=[((classMedicineTime*)[objMedicine.medicineTimes objectAtIndex:self.timeNumber]) times];

    
    if(medicineTime!=nil)        
    {
        myDateTime=[dateFormatter dateFromString:medicineTime];				
        [self.datePicker setDate: myDateTime animated:YES];
    }
    else
    {
        
        switch (timeNumber)
        {
            
                
            case 0:
                myDateTime=[dateFormatter dateFromString:@"08:00:00 AM"];				
                [self.datePicker setDate: myDateTime animated:YES];
                
                break;

                
            case 1:
                myDateTime=[dateFormatter dateFromString:@"01:00:00 PM"];				
                [self.datePicker setDate: myDateTime animated:YES];
                
                break;

                
            case 2:
                myDateTime=[dateFormatter dateFromString:@"04:00:00 PM"];				
                [self.datePicker setDate: myDateTime animated:YES];
                
                break;

                
            case 3:
                myDateTime=[dateFormatter dateFromString:@"08:00:00 PM"];				
                [self.datePicker setDate: myDateTime animated:YES];
                
                break;

        }
        
        
    }
    
	[dateFormatter release];	
    
    
//----------reset simplePicker-------------
    
    int index=0;
    
    //get the pillquantity
    float pillQuantity=[[self.objMedicine.medicineTimes objectAtIndex:self.timeNumber] pillQuantity];
    
    
    if(pillQuantity==0)
    {
        
        pillQuantity=1;// default show 1 
        
    }
    
    // also set this quantity to selectedQuantity vairable
    selectedQuantity=pillQuantity;
    
    // show time on label
  	//self.lblTime.text=[NSString stringWithFormat:@"Time: %@",medicineTime];
    
    // find the index of to animate picker view
    index=[self.arrayQuantityInNumber indexOfObject: [NSString stringWithFormat:@"%.1f",pillQuantity]];
    
	// animate the picker view
	[self.simplePicker selectRow:index inComponent:0 animated:YES ];
    
    if(pillQuantity>1)
    {
        lblPillQuantity.text=@"Pills on";
    }
    else
    {
        
        lblPillQuantity.text=@"Pill on";
        
    }
    self.lblDoseNumber.text=[NSString stringWithFormat:@"Select time & pill quantity to taken on dose-%d",timeNumber+1];
    
    
    
}



-(void)done
{
    
//------------ set selected time-------------  
    
	NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
	[timeFormat setDateFormat:@"h:mm:00 a"];
	
    // get the selected time form picekr
    NSString * selectedTime=[timeFormat stringFromDate:[datePicker date]];
	
    
    
    // chek whether time is already selected or not , user can not select same time twice    
    if( [self validateSelectedTime:selectedTime]==YES)
    {
        [(classMedicineTime*)[objMedicine.medicineTimes objectAtIndex:self.timeNumber] setTimes:selectedTime];
       // [(classMedicineTime*)[objMedicine.medicineTimes objectAtIndex:self.timeNumber] setTime:selectedTime];

    }
    
    
    else
    {
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please wait while scrolling and select different time for each dose." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    [timeFormat release];
    
    
//------------ set selected pill quantity-------------  
    
    [[objMedicine.medicineTimes objectAtIndex:self.timeNumber] setPillQuantity:selectedQuantity];

    
    
    
    
    [self dismissModalViewControllerAnimated:YES];
}

-(void)cancel
{
    
    [self dismissModalViewControllerAnimated:YES];
  
    
    
}

-(BOOL)validateSelectedTime:(NSString *)selectedTime
{
    
    
    return YES;
}


#pragma mark picker methodes
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
	if(component==0)
	{
		return 20;
	}
	
	return 0;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
	
	
	return [self.arrayQuantityFormated objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{	
	
	selectedQuantity= [[arrayQuantityInNumber objectAtIndex:row] floatValue];
    
    if(selectedQuantity>1)
    {
        
        lblPillQuantity.text=@"Pills on";
    }
    else
    {
        
        lblPillQuantity.text=@"Pill on";

        
    }
    
}


-(void)playAudio
{
    
    NSMutableArray * array=[[NSMutableArray alloc] init];
    
//    if(objUser.language==1)
//    {
    [array addObject:@"pleaseSelectTimeAndPillQuantityForDose"];
//    }
//    else if(objUser.language==2)
//    {
//        [array addObject:@"2pleaseSelectTimeAndPillQuantityForDose"];
//  
//        
//    }
//        
    switch (timeNumber)
    {
        
                    
        case 0:    
//            if(objUser.language==1)
//            {
                [array addObject:@"one"];
//            }
//            else if(objUser.language==2)
//            {
//                
//                [array addObject:@"2one"];
//            }
            break;
            
        case 1: 
//            if(objUser.language==1)
//            {
                [array addObject:@"two"];
//            }
//            else if(objUser.language==2)
//            {
//                [array addObject:@"2two"]; 
//            }
            
            break;
            
        case 2:    
//            if(objUser.language==1)
//            {
//                
                [array addObject:@"three"];  
                

            break;
            
        case 3: 
//            if(objUser.language==1)
//        {
            
            [array addObject:@"four"]; 
//        }
//        else if(objUser.language==2)
//        {
//            [array addObject:@"2four"]; 
//        } 
            
            break;
            
            
        case 4:   
//            if(objUser.language==1)
//        {
            [array addObject:@"five"]; 
//        }
//        else if(objUser.language==2)
//        {
//            [array addObject:@"2five"]; 
//        }
            break;
            
        case 5: 
//            if(objUser.language==1)
//            {
                
                [array addObject:@"six"]; 
                
//            }
//            else if(objUser.language==2)
//            {
//                [array addObject:@"2six"]; 
//            }
            break;

            
    }
    
    [self.myAudioPlayer playAudios:array];
    
    [array release];
    
}


@end
