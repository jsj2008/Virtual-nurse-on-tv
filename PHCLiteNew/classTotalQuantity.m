//
//  classTotalQuantity.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/6/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classTotalQuantity.h"
#import "classUser.h"
#import "classAudio.h"
#import "classMedicine.h"
#import "classMedicineTime.h"


@implementation classTotalQuantity
@synthesize delegate=_delegate;

@synthesize txtTotalQuantity;
@synthesize txtReorderLevel;
@synthesize  objMedicine;
@synthesize myAudioPlayer;
@synthesize objUser;


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
    [txtTotalQuantity release];
    [txtReorderLevel release];
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
    
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)] autorelease];
    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)] autorelease];
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    
    if(objMedicine.totalPillQuantity<=0)
    {
        
        txtTotalQuantity.text=@"30";
        
    }
    else
    {
        
        self.txtTotalQuantity.text=[ NSString stringWithFormat:@"%.1f" ,objMedicine.totalPillQuantity];
 
        
    }
    
    
    if(objMedicine.totalPillQuantity<=0)
    {
        
        txtReorderLevel.text=@"5";
    } 
    
    else
    {
        
        self.txtReorderLevel.text=[ NSString stringWithFormat:@"%d" , objMedicine.reorderLevel ];
        
        
    }
    
    if(objUser.audioStatus==YES)
    {
//if(objUser.language==1)
//{
    NSMutableArray * array=[[NSMutableArray alloc] init];
    [array addObject:@"totalPillQuantityMessage"];
    [myAudioPlayer playAudios:array];
    [array release];
//}
//        else if(objUser.language==2)
//        {
//            
//            NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"2EnterMedQtyInHand", nil];
//            [myAudioPlayer playAudios:array];
//            [array release];
//            
//            
//            
//        }

    
    
    
    }

    
}



- (void)viewDidUnload
{
    [self setTxtTotalQuantity:nil];
    [self setTxtReorderLevel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


+(BOOL)validate:(NSString *)value
{
    BOOL validValue;
    validValue=YES;
    
   
    
    
 
    
    if([value length]!=0)
	{
		
		
		NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];		
		NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[value stringByReplacingOccurrencesOfString:@"." withString:@""]];
		
        // if Yes- means string contains charachters like a,b, c, etc i.e. it is not avalid number
		validValue = [alphaNums isSupersetOfSet:inStringSet];		
		
				
    } 
    
    
    
    
    return validValue;
}


-(void)cancel
{
    
    [self.delegate cancelTotalQuantityEntering];   
    
    
}

-(void)done
{
    
    
    if([classTotalQuantity validate:txtTotalQuantity.text]==YES)
    {
        
        
        if([classTotalQuantity validate:txtReorderLevel.text]==YES)
        {
            
            
            self.objMedicine.totalPillQuantity=[txtTotalQuantity.text floatValue];
            self.objMedicine.reorderLevel=[txtReorderLevel.text intValue];
            
            // call delegate method to notifiy patent class about-quantity is entered
            [self.delegate doneTotalQuantityEntering];
        }

        else
        {
            
                UIAlertView * alertError=[[UIAlertView alloc] initWithTitle:@"Invalid value for Reorder level" message:@"Please enter valid +ve number." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                
                [alertError show];
                [alertError release];
            
        }
        
        
        
    }
    else
    {
        
        UIAlertView * alertError=[[UIAlertView alloc] initWithTitle:@"Invalid value for quantity in hand" message:@"Please enter valid +ve number." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alertError show];
        [alertError release];
        
    }
    
}

@end
