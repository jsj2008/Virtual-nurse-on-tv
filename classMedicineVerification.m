//
//  classMedicineVerification.m
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 02/12/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classMedicineVerification.h"
#import "classTakePill.h"
#import "classUser.h"
#import "classCompartmentSelection.h"
#import "classBayMedicationList.h"
#import "classDatabaseOperations.h"
#import "classAudio.h"
#import "classCompartmentData.h"
#define morning 1
#define afternoon 2
#define evening 3
#define night 4



@implementation classMedicineVerification
@synthesize currentBay;
@synthesize objUser;
@synthesize bayno;
@synthesize lblNight;
@synthesize lblEvening;
@synthesize lblNoon;
@synthesize lblMorning;
@synthesize lblDayDate;
@synthesize lbltoday;
@synthesize imgPillbox;
@synthesize btn1;
@synthesize btn2;
@synthesize btn3;
@synthesize btn4;
@synthesize btn5;
@synthesize btn6;
@synthesize btn7;
@synthesize btn8;
@synthesize btn9;
@synthesize btn10;
@synthesize btn11;
@synthesize btn12;
@synthesize btn13;
@synthesize btn14;
@synthesize btn15;
@synthesize btn16;
@synthesize btn17;
@synthesize btn18;
@synthesize btn19;
@synthesize btn20;
@synthesize btn21;
@synthesize btn22;
@synthesize btn23;
@synthesize btn24;
@synthesize btn25;
@synthesize btn26;
@synthesize btn27;
@synthesize btn28;
@synthesize btnCommon,btnCommon1;
@synthesize btnClickedTag;
@synthesize myAudioPlayer;
@synthesize  imgvalue;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        self.title=@"Take Medicine";
        self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)] autorelease];  

    
    }
    return self;
}

- (void)dealloc
{
    [lblMorning release];
    [lblNoon release];
    [lblEvening release];
    [lblNight release];
    [super dealloc];
}

-(void)logout
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Are you sure? Logout?" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
    alert.tag=189;
    [alert show];
    [alert release];

  //  [self dismissModalViewControllerAnimated:YES];
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
    
    
      
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
       [df setDateFormat:@"EEEE hh:mm a"];
       
    lblDayDate.text=[df stringFromDate:myDate];
    
    [df release ];     

    [self methodSetTarget];
  // currentBay =[self methodToHilightCompartment];
//   [self getbacklogs:currentBay];
    
    NSLog(@"curr %d",currentBay);
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    NSString *queryString=[NSString stringWithFormat:@"select flag from ImageFlag where userid=%d",objUser.userId];
    imgvalue=[classDatabaseOperations get:queryString];
  
    [self getSelectedBoxImage];
    
    
            
    currentBay =[self methodToHilightCompartment];
    [self getbacklogs:currentBay];

    
    if(self.objUser.audioStatus==YES)
    {
        if(self.objUser.language==1)
        {
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"takecurrentmedicine"];
            
            [self.myAudioPlayer playAudios:array];
            [array release];
        }
        
        else if(self.objUser.language==2)
        {
            
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"2TakeCurrentMEd"];
            
            [self.myAudioPlayer playAudios:array];
            [array release];
            
            
        }
        
    }
    
    

}
#pragma mark - View lifecycle


- (void)viewDidUnload
{
    [self setBtn1:nil];
    [self setBtn2:nil];
    [self setBtn3:nil];
    [self setBtn4:nil];
    [self setBtn5:nil];
    [self setBtn6:nil];
    [self setBtn7:nil];
    [self setBtn8:nil];
    [self setBtn9:nil];
    [self setBtn10:nil];
    [self setBtn11:nil];
    [self setBtn12:nil];
    [self setBtn13:nil];
    [self setBtn14:nil];
    [self setBtn15:nil];
    [self setBtn16:nil];
    [self setBtn17:nil];
    [self setBtn18:nil];
    [self setBtn19:nil];
    [self setBtn20:nil];
    [self setBtn21:nil];
    [self setBtn22:nil];
    [self setBtn23:nil];
    [self setBtn24:nil];
    [self setBtn25:nil];
    [self setBtn26:nil];
    [self setBtn27:nil];
    [self setBtn28:nil];
    [self setImgPillbox:nil];
    [self setLbltoday:nil];
    [self setLblDayDate:nil];
    
    [self setLblMorning:nil];
    [self setLblNoon:nil];
    [self setLblEvening:nil];
    [self setLblNight:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(int)methodToHilightCompartment
{
    
    //for monday
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(blink) userInfo:nil repeats:YES];
    if([self getDayInInteger]==1)
    {
        if([classCompartmentSelection timeSpanInInteger]==morning)
        {
            
            [btn1 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            
            
            [btn1 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            // [btn1 setBackgroundColor:[UIColor orangeColor]];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
                        btnCommon=btn1;
            [self blink];
            return bayno=1;

            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==afternoon)
        {
            [btn8 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            
            [btn8 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            //[btn8 setBackgroundColor:[UIColor redColor ]];
            [btn8 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            
                     
            btnCommon=btn8;
            [self blink];
            
            return  bayno=8;

        }
        
        if([classCompartmentSelection timeSpanInInteger]==evening)
        {
            
            [btn15 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            
            [btn15 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            
            //[btn15 setBackgroundColor:[UIColor orangeColor]];
            [btn15 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
           
            
            
            btnCommon=btn15;
            [self blink];
            
            
           return  bayno=15;
            
        }
        
        
        
        
        if([classCompartmentSelection timeSpanInInteger]==night)
        {
            
            [btn22 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            
            
            //[btn22 setBackgroundColor:[UIColor orangeColor]];
            [btn22 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
            
            [btn22 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
                        btnCommon=btn22;
            [self blink];
            
            return  bayno=22;

            
        }
        
        
        
        
        
    }
    
    
    //for tue
    
    
    
    else if([self getDayInInteger]==2)
    {
        if([classCompartmentSelection timeSpanInInteger]==morning)
        {
            [btn2 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            // [btn2 setBackgroundColor:[UIColor orangeColor]];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
            
            [btn2 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            btnCommon=btn2;
            [self blink];
            
          return   bayno=2;

            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==afternoon)
        {
            //[btn9 setBackgroundColor:[UIColor orangeColor]];
            
            [btn9 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            [btn9 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
            
            [btn9 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            btnCommon=btn9;
            [self blink];
          return   bayno=9;

            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==evening)
        {
            [btn16 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            //[btn16 setBackgroundColor:[UIColor orangeColor]];
            [btn16 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
            
            [btn16 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            btnCommon=btn16;
            [self blink];
            return bayno=16;

            
        }
        
        
        
        
        if([classCompartmentSelection timeSpanInInteger]==night)
        {
            
            [btn23 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            //[btn23 setBackgroundColor:[UIColor orangeColor]];
            [btn23 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
            [btn23 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            btnCommon=btn23;
            [self blink];
            
           return  bayno=23;

            
        }
        
        
        
        
        
    }
    
    
    
    
    //for wed
    
    
    else if ([self getDayInInteger]==3)
        
    {
        
        if([classCompartmentSelection timeSpanInInteger]==morning)      
        {
            
            [btn3 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            //[btn3 setBackgroundColor:[UIColor orangeColor]];
            [btn3 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            
            [btn3 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            btnCommon=btn3;
            [self blink];
            
            return bayno=3;

            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==afternoon)
        {
            [btn10 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            //[btn10 setBackgroundColor:[UIColor orangeColor]];
            [btn10 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            
            [btn10 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=10;
            
            btnCommon=btn10;
            [self blink];
            return bayno;
        }
        
        if([classCompartmentSelection timeSpanInInteger]==evening)
        {
            [btn17 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            
            //[btn17 setBackgroundColor:[UIColor orangeColor]];
            [btn17 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn17 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=17;
            btnCommon=btn17;
            [self blink];
            return bayno;

            
        }
        
        
        
        
        if([classCompartmentSelection timeSpanInInteger]==night)
        {
            
            [btn24 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            //[btn24 setBackgroundColor:[UIColor orangeColor]];
            [btn24 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn24 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=24;
            btnCommon=btn24;
            [self blink];
            return bayno;

        }
        
        
        
        
        
    }
    
    //for thu 
    
    
    
    else if([self getDayInInteger]==4)
    {
        if([classCompartmentSelection timeSpanInInteger]==morning)
        {
            [btn4 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            
            //  [btn4 setBackgroundColor:[UIColor orangeColor]];
            [btn4 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn4 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=4;
            
            btnCommon=btn4;
            [self blink];
            
            
            return bayno;

            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==afternoon)
        {
            [btn11 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            
            // [btn11 setBackgroundColor:[UIColor orangeColor]];
            [btn11 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn11 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=11;
            btnCommon=btn11;
            [self blink];
            
            return bayno;

            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==evening)
        {
            [btn18 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            // [btn18 setBackgroundColor:[UIColor orangeColor]];
            [btn18 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            
            [btn18 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=18;
            
            btnCommon=btn18;
            [self blink];
            
            return bayno;

        }
        
        
        
        
        if([classCompartmentSelection timeSpanInInteger]==night)
        {
            [btn25 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            //[btn25 setBackgroundColor:[UIColor orangeColor]];
            [btn25 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn25 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=25;
            btnCommon=btn25;
            [self blink];
            return bayno;

        }
        
        
        
        
        
    }
    
    //for fri
    
    
    
    else if([self getDayInInteger]==5)
    {
        if([classCompartmentSelection timeSpanInInteger]==morning)
        {
            [btn5 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            
            // [btn5 setBackgroundColor:[UIColor orangeColor]];
            [btn5 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn5 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=5;
            btnCommon=btn5;
            [self blink];
            return bayno;

        }
        
        if([classCompartmentSelection timeSpanInInteger]==afternoon)
        {
            
            [btn12 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            //[btn12 setBackgroundColor:[UIColor orangeColor]];
            [btn12 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn12 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=12;
            btnCommon=btn12;
            [self blink];
            
            
            return bayno;

            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==evening)
        {
            [btn19 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            
            //[btn19 setBackgroundColor:[UIColor orangeColor]];
            [btn19 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn19 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=19;
            
            btnCommon=btn19;
            [self blink];
            
            
            return bayno;

        }
        
        
        
        
        if([classCompartmentSelection timeSpanInInteger]==night)
        {
            [btn26 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            
            //[btn26 setBackgroundColor:[UIColor orangeColor]];
            [btn26 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn26 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=26;
            
            btnCommon=btn26;
            [self blink];
            
            
            return bayno;

            
        }
        
        
        
        
        
    }
    
    //for sat 
    
    
    
    else if([self getDayInInteger]==6)
    {
        if([classCompartmentSelection timeSpanInInteger]==morning)
        {
            [btn6 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            
            //[btn6 setBackgroundColor:[UIColor orangeColor]];
            [btn6 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            
            [btn6 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=6;
            
            btnCommon=btn6;
            [self blink];
            
            
            return bayno;

            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==afternoon)
        {
            [btn13 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            
            //  [btn13 setBackgroundColor:[UIColor orangeColor]];
            [btn13 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn13 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=13;
            
            
            btnCommon=btn13;
            [self blink];
            
            
            return bayno;

            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==evening)
        {
            [btn20 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            // [btn20 setBackgroundColor:[UIColor orangeColor]];
            [btn20 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            
            [btn20 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=20;
            btnCommon=btn20;
            [self blink];
            
            return bayno;

        }
        
        
        
        
        if([classCompartmentSelection timeSpanInInteger]==night)
        {
            
            [btn27 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            
            // [btn27 setBackgroundColor:[UIColor orangeColor]];
            [btn27 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn27 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=27;
            
            btnCommon=btn27;
            [self blink];
            
            
            return bayno;

            
            
        }
        
        
        
        
        
    }
    
    //for sun 
    
    
    
    else if([self getDayInInteger]==7)
    {
        if([classCompartmentSelection timeSpanInInteger]==morning)
        {
            [btn7 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            
            //[btn7 setBackgroundColor:[UIColor orangeColor]];
            [btn7 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
            [btn7 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=7;
            btnCommon=btn7;
            [self blink];
            
            return bayno;

            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==afternoon)
        {
            
            
            [btn14 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            //[self mthodBtnGlow:btn14];
            //  [btn14 setBackgroundColor:[UIColor orangeColor]];
            [btn14 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn14 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=14;
            btnCommon=btn14;
            [self blink];
            
            return bayno;

            
            
            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==evening)
        {
            
            [btn21 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            //[self mthodBtnGlow:btn28];
          //  [ btn21 setBackgroundColor:[UIColor orangeColor]];
            [btn21 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            
            [btn21 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=21;
            btnCommon=btn21;
            [self blink];
            
            
            return bayno;

        }
        
        
        
        
        if([classCompartmentSelection timeSpanInInteger]==night)
        {
            //[self mthodBtnGlow:btn28];
            //[btn28 setBackgroundColor:[UIColor orangeColor]];
            [btn28 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];            

            
            [btn28 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn28 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=28;
            btnCommon=btn28;
            [self blink];
            
            return bayno;

            
        }
        
        
        
        
        
    }
    
    
    
    return bayno;

    
}
-(void)getSelectedBoxImage
{
    // NSString *queryString=[NSString stringWithFormat:@"select flag from ImageFlag where userid=%d",objUser.userId];
    //imgvalue=[classDatabaseOperations get:queryString];
    
    switch (imgvalue) {
        case 1:
        {
            [self.imgPillbox setImage:[UIImage imageNamed:@"Morning1.png"]];
            
          //  [self methodToHilightCompartment];
            
            [self methodToHideAfternoonCompartment];
            [self methodToHideEveningCompartment];
            [self methodToHideNightCompartment];
            
            lblNoon.hidden=YES;
            lblEvening.hidden=YES;
            lblNight.hidden=YES;
            break;
        } 
        case 2:
        {
            [self.imgPillbox setImage:[UIImage imageNamed:@"Afternoon1.png"]];
            //[self methodToHilightCompartment];
            
            [self methodToHideMorningCompartment];
            [self methodToHideEveningCompartment];
            [self methodToHideNightCompartment];
            
            lblMorning.hidden=YES;
            lblEvening.hidden=YES;
            lblNight.hidden=YES;
            
            break;
        } 
            
        case 3:
        {
            [self.imgPillbox setImage:[UIImage imageNamed:@"Evening1.png"]];
            
            
          //  [self methodToHilightCompartment];
            
            
            [self methodToHideMorningCompartment];
            [self methodToHideAfternoonCompartment];
            [self methodToHideNightCompartment];
            
            lblMorning.hidden=YES;
            lblNoon.hidden=YES;
            lblNight.hidden=YES;
            
            break;
        } 
        case 4:
        {
            [self.imgPillbox setImage:[UIImage imageNamed:@"Night1.png"]];
            //[self methodToHilightCompartment];
            
            [self methodToHideMorningCompartment];
            [self methodToHideAfternoonCompartment];
            [self methodToHideEveningCompartment];
            
            lblNoon.hidden=YES;
            lblEvening.hidden=YES;
            lblMorning.hidden=YES;
            
            
            break;
        } 
        case 5:
        {
            [self.imgPillbox setImage:[UIImage imageNamed:@"12.png"]];
           // [self methodToHilightCompartment];
            
            [self methodToHideEveningCompartment];
            [self methodToHideNightCompartment];
            
            //lblNoon.hidden=YES;
            lblEvening.hidden=YES;
            lblNight.hidden=YES;
            
            break;
        } 
        case 6:
        {
            [self.imgPillbox setImage:[UIImage imageNamed:@"1,3.png"]];
           // [self methodToHilightCompartment];
            
            
            [self methodToHideAfternoonCompartment];
            [self methodToHideNightCompartment];
            
            lblNoon.hidden=YES;
            // lblEvening.hidden=YES;
            lblNight.hidden=YES;
            
            break;
        } 
        case 7:
        {
            [self.imgPillbox setImage:[UIImage imageNamed:@"1,4.png"]];
            //[self methodToHilightCompartment];
            
            [self methodToHideAfternoonCompartment];
            [self methodToHideEveningCompartment];
            
            lblNoon.hidden=YES;
            lblEvening.hidden=YES;
            //lblNight.hidden=YES;
            
            
            break;
        } 
        case 8:
        {
            [self.imgPillbox setImage:[UIImage imageNamed:@"123.png"]];
            //[self methodToHilightCompartment];
            
            
            [self methodToHideNightCompartment];
            
            // lblNoon.hidden=YES;
            // lblEvening.hidden=YES;
            lblNight.hidden=YES;
            
            break;
        } 
        case 9:
        {
            [self.imgPillbox setImage:[UIImage imageNamed:@"124.png"]];
            //[self methodToHilightCompartment];
            
            [self methodToHideEveningCompartment];
            
            lblEvening.hidden=YES;
            
            
            break;
        } 
        case 10:
        {
            [self.imgPillbox setImage:[UIImage imageNamed:@"134.png"]];
           // [self methodToHilightCompartment];
            
            [self methodToHideAfternoonCompartment];
            lblNoon.hidden=YES;
            
            
            break;
        } 
        case 11:
        {
            [self.imgPillbox setImage:[UIImage imageNamed:@"pillbox.png"]];
            lblNight.hidden=NO;
            
           // [self methodToHilightCompartment];                      
            break;
        } 
        case 12:
        {
            [self.imgPillbox setImage:[UIImage imageNamed:@"23.png"]];
          //  [self methodToHilightCompartment];
            
            [self methodToHideMorningCompartment];
            [self methodToHideNightCompartment];
            
            lblMorning.hidden=YES;
            lblNight.hidden=YES;
            break;
        } 
        case 13:
        {
            [self.imgPillbox setImage:[UIImage imageNamed:@"24.png"]];
           // [self methodToHilightCompartment];
            
            
            [self methodToHideMorningCompartment];
            [self methodToHideEveningCompartment];
            
            lblMorning.hidden=YES;
            lblEvening.hidden=YES;
            
            
            break;
        } 
        case 14:
        {
            [self.imgPillbox setImage:[UIImage imageNamed:@"34.png"]];
            //[self methodToHilightCompartment];
            
            [self methodToHideMorningCompartment];
            [self methodToHideAfternoonCompartment];
            
            lblNoon.hidden=YES;
            lblMorning.hidden=YES;
            break;
        } 
        case 15:
        {
            [self.imgPillbox setImage:[UIImage imageNamed:@"2,3,4.png"]];
           // [self methodToHilightCompartment];
            
            [self methodToHideMorningCompartment];
            
            lblMorning.hidden=YES;
            break;
        } 
            
            
        default:
            break;
    }
}


-(void)methodToHideMorningCompartment
{
    btn1.hidden=YES;
    btn2.hidden=YES;
    btn3.hidden=YES;
    btn4.hidden=YES;
    btn5.hidden=YES;
    btn6.hidden=YES;
    btn7.hidden=YES;
    
    
}

-(void)methodToHideAfternoonCompartment
{
    btn8.hidden=YES;
    btn9.hidden=YES;
    btn10.hidden=YES;
    btn11.hidden=YES;
    btn12.hidden=YES;
    btn13.hidden=YES;
    btn14.hidden=YES;
    
}
-(void)methodToHideEveningCompartment
{
    // btn12.hidden=YES;
    btn15.hidden=YES;
    btn16.hidden=YES;
    btn17.hidden=YES;
    btn18.hidden=YES;
    btn19.hidden=YES;
    btn20.hidden=YES;
    btn21.hidden=YES;
}
-(void)methodToHideNightCompartment
{
    
    btn22.hidden=YES;
    btn23.hidden=YES;
    btn24.hidden=YES;
    btn25.hidden=YES;
    btn26.hidden=YES;
    btn27.hidden=YES; 
    btn28.hidden=YES;
    
}




-(int)getDayInInteger
{
    
    NSDate *date =[NSDate date];
    NSDateFormatter *df1 =  [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"EEEE"];  
    NSString *strDay=[df1 stringFromDate:date];
    NSLog(@"%@",strDay);
    [df1 release];
    //@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday"
    
    NSString *day1=@"Monday";
    NSString *day2=@"Tuesday";
    NSString *day3=@"Wednesday";
    NSString *day4=@"Thursday";
    NSString *day5=@"Friday";
    NSString *day6=@"Saturday";
    NSString *day7=@"Sunday";
    
    if([strDay isEqualToString:day1])
    {
        
        return 1;
        
        
    }
    
    if([strDay isEqualToString:day2])
    {
        
        return 2;
        
        
    }
    if([strDay isEqualToString:day3])
    {
        
        return 3;
        
        
    }
    if([strDay isEqualToString:day4])
    {
        
        return 4;
        
        
    }
    if([strDay isEqualToString:day5])
    {
        
        return 5;
        
        
    }
    if([strDay isEqualToString:day6])
    {
        
        return 6;
        
        
    }
    if([strDay isEqualToString:day7])
    {
        
        return 7;
        
        
    }
    
    return 0;
    
}


-(void)methodTakeMedicine
{
    
    
    NSLog(@"TAKE MED CAll");
    
    
    //[self methodMedcinelist:btn.tag];
    classTakePill *obj=[[classTakePill alloc]initWithNibName:@"classTakePill" bundle:nil];
    
    obj.objUser=objUser;
    obj.userid=objUser.userId;
    obj.myAudioPlayer=self.myAudioPlayer;
    obj.bayno=bayno;
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:obj];
    [obj release];
    [self presentModalViewController:nav animated:YES];
    [nav release];
    
    // self.modalTransitionStyle=ui
    
}



-(void)blink
{
    static int i=0;
    if(i%2)
    {
        [UIView animateWithDuration:0.5 animations:^(void){
            [btnCommon setHighlighted:YES];   
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^(void){
            [btnCommon setHighlighted:NO];   
        }];
    }
    
    i++;
}



-(void)blink1
{
    static int n=0;
    if(n%2)
    {
        [UIView animateWithDuration:0.5 animations:^(void){
            [btnCommon1 setHighlighted:YES];   
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^(void){
            [btnCommon1 setHighlighted:NO];   
        }];
    }
    
 n++;
}



-(void)methodMedcinelist:(UIButton *)btn
{
    btnClickedTag=btn.tag;
    UIActionSheet * actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Take Medicine" otherButtonTitles:@"Check Medicine", nil];
    [actionSheet setBackgroundColor:[UIColor clearColor]];
    
    
    [actionSheet showInView:self.view.window];
    [actionSheet release];

    
    

    
    
    
}





-(void)methodSetTarget
{
    
    [btn1 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];

    [btn2 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn5 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn6 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn7 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn8 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn9 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn10 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn11 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn12 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn13 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn14 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn15 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn16 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn17 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn18 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn19 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn20 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn21 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn22 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn23 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn24 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn25 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn26 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn27 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn28 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    
    
    
    
}





-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(buttonIndex==0)// Take med
    {
                
        int i=[classCompartmentSelection timeSpanInInteger] ;
              
        NSString *tspan=[classMedicineVerification convertIntTimeSpanToString:i];
        
       // @"Currently %@\nContinue to %@ medicines?",[commanFunctions timeSpanInString], [commanFunctions convertIntTimeSpanToString:selectedTime]]    
        
        
        
        classTakePill *obj=[[classTakePill alloc]initWithNibName:@"classTakePill" bundle:nil];
        obj.objUser=objUser;
        obj.myAudioPlayer=self.myAudioPlayer;
        
        obj.userid=objUser.userId;
        obj.bayno=btnClickedTag;
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:obj];
        
        [self presentModalViewController:nav animated:YES];
        [nav release];
        [obj release];
        
        
       NSString *selectedTimeSpan=[self methodSelectedBayTimeSpan];
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Are you sure ?? " message:[NSString stringWithFormat: @"Currently %@\nContinue to %@ medicines?",tspan,selectedTimeSpan] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alert.tag=100;
        [alert show];
        [alert release];
        
        [selectedTimeSpan release];
        
        
        
        

        
        
    }
    else if(buttonIndex==1)//checke med
        
    { 
         
        classBayMedicationList *objMedList=[[classBayMedicationList alloc]initWithStyle:UITableViewStyleGrouped];
        //objMedList.strSpan=lblSpan.text;
        //objMedList.arrayMed=arrayMed;
        objMedList.myAudioPlayer=self.myAudioPlayer;
        objMedList.userid=objUser.userId;
        objMedList.objUser=objUser;
        objMedList.bayno=btnClickedTag;
        
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:objMedList];
        [self presentModalViewController:nav animated:YES];
        [objMedList release];
        [nav release];

        
    }
    else if(buttonIndex==2)// cancel
    { 
        
        NSLog(@"2222");
        
    }
    
    
    
    
}


+(NSString *)convertIntTimeSpanToString:(int)timeSpan
{
    
    switch (timeSpan)
    {
        case 1: return @"Morning";
            
            break;
            
            
        case 2:return @"Afternoon";
            
            break;
            
            
        case 3:return @"Evening";
            
            break;
            
            
        case 4: return @"Night";
            
            break;
            
            
    }
    
    
    return @"- - - - ";
}

-(NSString *)methodSelectedBayTimeSpan
{
    
    if(btnClickedTag >=1 && btnClickedTag <=7 )
    
    {
        NSString *str= @"Morning";
        
        return str;
    }
    
    if(btnClickedTag>=8 && btnClickedTag <=14 )
        
    {
        NSString *str= @"Afternoon";
        
        return str;
    }

    
    if(btnClickedTag >=15 && btnClickedTag <=21 )
        
    {
        
        NSString *str= @"Evening";
        
        return str;   
    }

    
    if(btnClickedTag >=22 && btnClickedTag <=28)
        
    {
        
        NSString *str= @"Night";
        
        return str;
    }

    
    
    return @"---";
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    if(buttonIndex ==0)
    {
        
        
        [self dismissModalViewControllerAnimated:YES];
        
        
        
    }
    else
    {
        
        
        
        
    }
    
    if(alertView.tag==189 )
    {
        
        if(buttonIndex==1)
        {
            
            
            //[self.navigationController popViewControllerAnimated:YES];
            [self dismissModalViewControllerAnimated:YES];
            
        }
        
        
    }

    

    
}


-(void)getbacklogs:(int)currentBay1
{
    if(currentBay1==1||currentBay1==2 ||currentBay1==3 ||currentBay1==4 ||currentBay1==5||currentBay1==6||currentBay1==7)
    {
        
        if(currentBay1==1)
        {
        
            [self getbacklogsStatus:28];
            
        }
            
        
        
        if(currentBay1==2)
        {
            
            [self getbacklogsStatus:22];
            
        }

        
        
        if(currentBay1==3)
        {
            
            [self getbacklogsStatus:23];
            
        }

        
        
        if(currentBay1==4)
        {
            
            [self getbacklogsStatus:24];
            
        }
        
        if(currentBay1==5)
        {
            
            [self getbacklogsStatus:25];
            
        }
        
        if(currentBay1==6)
        {
            
            [self getbacklogsStatus:26];
            
        }
        
        if(currentBay1==7)
        {
            
            [self getbacklogsStatus:27];
            
        }

        
        
    }
    
    
    
    
  

      else
      {
        
        int prev=currentBay1-7;
    [self getbacklogsStatus:prev];
    
     
    
    
    
    int prev1=prev-7;
    [self getbacklogsStatus:prev1];


    
    
    
    int prev2=prev1-7;
    [self getbacklogsStatus:prev2];

      }
    
    
    

}

-(void)setImgback:(int)bay:(NSString *)img
{
    if(bay==1)
    {
        
        
        
        
        [btn1 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn1;
       // [self blink1];
        
    }
    
    if(bay==2)
    {
        
        
        
        
        [btn2 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn2;
       // [self blink1];
        
    }
    if(bay==3)
    {
        
        
        
        
        [btn3 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn3;
       // [self blink];
        
    }
    if(bay==4)
    {
        
        
        
        
        [btn1 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn4;
      //  [self blink1];
        
    }
    if(bay==5)
    {
        
        
        
        
        [btn5 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn5;
      //  [self blink1];
        
    }
    if(bay==6)
    {
        
        
        
        
        [btn6 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn6;
      //  [self blink1];
        
    }
    if(bay==7)
    {
        
        
        
        
        [btn7 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn7;
      //  [self blink1];
        
    }
    
    if(bay==8)
    {
        
        
        
        
        [btn8 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn8;
      //  [self blink1];
        
    }
    if(bay==9)
    {
        
        
        
        
        [btn9 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn9;
      //  [self blink1];
        
    }
    if(bay==10)
    {
        
        
        
        
        [btn10 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn10;
       // [self blink1];
        
    }
    if(bay==11)
    {
        
        
        
        
        [btn11 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn11;
      //  [self blink1];
        
    }
    if(bay==12)
    {
        
        
        
        
        [btn12 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn12;
      //  [self blink1];
        
    }
    if(bay==13)
    {
        
        
        
        
        [btn13 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn13;
       // [self blink1];
        
    }
    if(bay==14)
    {
        
        
        
        
        [btn14 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn14;
       // [self blink1];
        
    }
    if(bay==15)
    {
        
        
        
        
        [btn15 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn15;
      //  [self blink1];
        
    }
    if(bay==16)
    {
        
        
        
        
        [btn16 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn16;
      //  [self blink1];
        
    }
    if(bay==17)
    {
        
        
        
        
        [btn17 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn17;
       // [self blink1];
        
    }
    if(bay==18)
    {
        
        
        
        
        [btn18 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn18;
       // [self blink1];
        
    }
    if(bay==19)
    {
        
        
        
        
        [btn19 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn19;
       // [self blink1];
        
    }
    if(bay==20)
    {
        
        
        
        
        [btn20 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn20;
       // [self blink1];
        
    }
    if(bay==21)
    {
        
        
        
        
        [btn21 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn21;
       // [self blink1];
        
    }
    if(bay==22)
    {
        
        
        
        
        [btn22 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn22;
        //[self blink1];
        
    }
    if(bay==23)
    {
        
        
        
        
        [btn23 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn23;
       // [self blink1];
        
    }
    if(bay==24)
    {
        
        
        
        
        [btn24 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn24;
      //  [self blink1];
        
    }
    if(bay==25)
    {
        
        
        
        
        [btn25 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn25;
//[self blink1];
        
    }
    if(bay==26)
    {
        
        
        
        
        [btn26 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn26;
      //  [self blink1];
        
    }
    if(bay==27)
    {
        
        
        
        
        [btn27 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn27;
       // [self blink1];
        
    }
    if(bay==28)
    {
        
        
        
        
        [btn28 setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        btnCommon1=btn28;
      //  [self blink1];
        
    }
      
    
    
    
}

-(void)getbacklogsStatus:(int)currentPass
{
    
    
    
    int prev=currentPass;
    
    
    NSMutableArray * arrayMed=[classDatabaseOperations getBayMedicineListForUser:objUser.userId :prev];
    //  classCompartmentData *objMedi=[[classCompartmentData alloc]init];
    int count1=[arrayMed count];
    int j=0;    for (classCompartmentData *objMedi in arrayMed) 
    {
        
        if(objMedi.state==0)
        {
            
            [self setImgback:prev :@"rxred1.png"];  
            
            
            
        }
        
        else if(objMedi.state==1)
        {
            
            j++;
            
            
        }
        
        
        
        
    }
    
    if(count1==j)
    {
        NSLog(@"%d %d ",j,count1);
        [self setImgback:prev :@"bluerx.png"];  
        
        
    }
    
    
    
    
    
    
    
}






@end

