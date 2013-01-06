//
//  ClassRefillMedicine.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/14/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "ClassRefillMedicine.h"
#import "classDatabaseOperations.h"
#import "classMedicine.h"
#import "classUser.h"
#import "classAudio.h"

@implementation ClassRefillMedicine

@synthesize delegate=_delegate;
@synthesize txtReroderLevel;
@synthesize txtTotalPillQuantity;
@synthesize btnSubmit;

@synthesize objMedicine;
@synthesize objUser;

@synthesize myAudioPlayer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
       
    }
    return self;
}

- (void)dealloc
{
    [txtReroderLevel release];
    [txtTotalPillQuantity release];
    [btnSubmit release];
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
    // Do any additional setup after loading the view from its nib.
    
    self.title=objMedicine.medicineName;
    
    // set current reorder level and quatity
    self.txtReroderLevel.text=[NSString stringWithFormat:@"%d",objMedicine.reorderLevel];
    //self.txtTotalPillQuantity .text=[NSString stringWithFormat:@"%.1f",objMedicine.totalPillQuantity];
    
    if(self.objUser.audioStatus==YES)
    {
    [self playAudio]; 
    }
}

- (void)viewDidUnload
{
    [self setTxtReroderLevel:nil];
    [self setTxtTotalPillQuantity:nil];
    [self setBtnSubmit:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)submit:(id)sender 
{
    if([ClassRefillMedicine validate:txtReroderLevel.text]==YES)
    {
    
        if([ClassRefillMedicine validate:txtTotalPillQuantity.text]==YES)
        {  
        
            // set new reorder level
            
            objMedicine.reorderLevel=[txtReroderLevel.text intValue];
            
            // update total quantity
             objMedicine.totalPillQuantity= objMedicine.totalPillQuantity+[txtTotalPillQuantity.text floatValue];
             [classDatabaseOperations updateMedicine:objMedicine forMemberId:objUser.memberId];
            
            // also update medicine List
            [self.delegate medicineReffilingDidComplete];
            
            UIAlertView *alerterror=[[UIAlertView alloc]initWithTitle:@"Medicine refilled succesfully !" message:[NSString stringWithFormat:@"Total quantiy after reffiling is: %.1f",objMedicine.totalPillQuantity] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];	
            alerterror.tag=100;
            [alerterror show];	
            [alerterror release];
           
            if(objUser.audioStatus==YES)
            {
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"refilledSuccesscully"];    
            [myAudioPlayer playAudios:array];
            [array release];
            }

            
        }
        else
        {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Invalid quantity" message:@"Please enter +ve integer value e.g. 30" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];

            
            
        }
    }
    else
    {
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Invalid reorder level" message:@"Please enter +ve integer value e.g. 5" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];  
        
        
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    
    if(alertView.tag==100)
    {
        
        if(buttonIndex==0)
        {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        
        
    }
    
    
}


+(BOOL)validate:(NSString *)value
{
    BOOL validValue;
    validValue=YES;
    
    
    
    
    
    
    if([value length]!=0)
	{
		
		
		NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];		
		NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[value stringByReplacingOccurrencesOfString:@"." withString:@""]];
		
        // if NO- means string contains charachters like a,b, c, etc i.e. it is not avalid number
		validValue = [alphaNums isSupersetOfSet:inStringSet];		
		
        
    } 
    
    
    
    
    return validValue;
}



-(void)playAudio
{
    
    
    NSMutableArray * array=[[NSMutableArray alloc] init];
    [array addObject:@"refillMessage"];    
    [myAudioPlayer playAudios:array];
    [array release];

    
   
    
    
}


@end
