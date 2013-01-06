//
//  classCompartmentSelection.m
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 11/12/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classCompartmentSelection.h"
#import "classTakePill.h"
#import "classUser.h"
#import "classMedicineVerification.h"


#define morning 1
#define afternoon 2
#define evening 3
#define night 4


@implementation classCompartmentSelection

@synthesize objUser;
@synthesize bayno;
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
@synthesize btnCommon;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        objUser=[[classUser alloc]init];
    }
    return self;
}

- (void)dealloc
{
    [btn1 release];
    [btn2 release];
    [btn3 release];
    [btn4 release];
    [btn5 release];
    [btn6 release];
    [btn7 release];
    [btn8 release];
    [btn9 release];
    [btn10 release];
    [btn11 release];
    [btn12 release];
    [btn13 release];
    [btn14 release];
    [btn15 release];
    [btn16 release];
    [btn17 release];
    [btn18 release];
    [btn19 release];
    [btn20 release];
    [btn21 release];
    [btn22 release];
    [btn23 release];
    [btn24 release];
    [btn25 release];
    [btn26 release];
    [btn27 release];
    [btn28 release];
    [imgPillbox release];
    [lbltoday release];
    [lblDayDate release];

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
    
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    //[df setDateFormat:@"EEEE dd MMMM, yyyy"];
    [df setDateFormat:@"EEEE hh:mm a"];
    NSLog(@"date %@ =",[df stringFromDate:myDate]);
    
    
    lblDayDate.text=[df stringFromDate:myDate];
    
    
      
    
    
    [df release ];     

    
    [self methodToHilightCompartment];
    // Do any additional setup after loading the view from its nib.
}

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

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)methodToHilightCompartment
{
   /* 
    //for monday
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(blink) userInfo:nil repeats:YES];
    if([self getDayInInteger]==1)
    {
        if([classCompartmentSelection timeSpanInInteger]==morning)
        {
            
            [btn1 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
           // [btn1 setBackgroundColor:[UIColor orangeColor]];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
            bayno=1;
            btnCommon=btn1;
            [self blink];
            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==afternoon)
        {
            
            
            [btn8 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            //[btn8 setBackgroundColor:[UIColor redColor ]];
            [btn8 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
                       
            bayno=8;
            
            btnCommon=btn8;
            [self blink];

        
        }
        
        if([classCompartmentSelection timeSpanInInteger]==evening)
        {
            [btn15 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            
            //[btn15 setBackgroundColor:[UIColor orangeColor]];
            [btn15 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
            bayno=15;
            
            
            btnCommon=btn15;
            [self blink];
        }
        
        
        
        
        if([classCompartmentSelection timeSpanInInteger]==night)
        {
            
            //[btn22 setBackgroundColor:[UIColor orangeColor]];
            [btn22 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
            
            [btn22 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=22;
            btnCommon=btn22;
            [self blink];
        }
        
        
        
        
        
    }
    
    
    //for tue
    
    
    
    else if([self getDayInInteger]==2)
    {
        if([classCompartmentSelection timeSpanInInteger]==morning)
        {
            
           // [btn2 setBackgroundColor:[UIColor orangeColor]];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
            
            [btn2 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=2;
            btnCommon=btn2;
            [self blink];
        }
        
        if([classCompartmentSelection timeSpanInInteger]==afternoon)
        {
            //[btn9 setBackgroundColor:[UIColor orangeColor]];
            [btn9 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
            
            [btn9 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=9;
            btnCommon=btn9;
            [self blink];
            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==evening)
        {
            
            //[btn16 setBackgroundColor:[UIColor orangeColor]];
            [btn16 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
            
            [btn16 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=16;
            btnCommon=btn16;
            [self blink];
            
            
        }
        
        
        
        
        if([classCompartmentSelection timeSpanInInteger]==night)
        {
            
            
            //[btn23 setBackgroundColor:[UIColor orangeColor]];
            [btn23 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
            [btn23 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=23;
            btnCommon=btn23;
            [self blink];
            
        }
        
        
        
        
        
    }
    
    
    
    
    //for wed
    
    
    else if ([self getDayInInteger]==3)
        
    {
        
        if([classCompartmentSelection timeSpanInInteger]==morning)      
        {
            
            
            //[btn3 setBackgroundColor:[UIColor orangeColor]];
            [btn3 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            
            [btn3 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=3;
            btnCommon=btn3;
            [self blink];
            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==afternoon)
        {
            
            //[btn10 setBackgroundColor:[UIColor orangeColor]];
            [btn10 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            
            [btn10 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=10;

            btnCommon=btn10;
            [self blink];
        }
        
        if([classCompartmentSelection timeSpanInInteger]==evening)
        {
            
            
            //[btn17 setBackgroundColor:[UIColor orangeColor]];
            [btn17 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn17 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=17;
            btnCommon=btn17;
            [self blink];
        }
        
        
        
        
        if([classCompartmentSelection timeSpanInInteger]==night)
        {
            
            
            //[btn24 setBackgroundColor:[UIColor orangeColor]];
            [btn24 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn24 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=24;
            btnCommon=btn24;
            [self blink];
            
        }
        
        
        
        
        
    }
    
    //for thu 
    
    
    
    else if([self getDayInInteger]==4)
    {
        if([classCompartmentSelection timeSpanInInteger]==morning)
        {
            
            
          //  [btn4 setBackgroundColor:[UIColor orangeColor]];
            [btn4 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn4 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=4;
            
            btnCommon=btn4;
            [self blink];
            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==afternoon)
        {
            
            
           // [btn11 setBackgroundColor:[UIColor orangeColor]];
            [btn11 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn11 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=11;
            btnCommon=btn11;
            [self blink];
            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==evening)
        {
            
           // [btn18 setBackgroundColor:[UIColor orangeColor]];
            [btn18 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            
            [btn18 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=18;
            
            btnCommon=btn18;
            [self blink];
        }
        
        
        
        
        if([classCompartmentSelection timeSpanInInteger]==night)
        {
            
            //[btn25 setBackgroundColor:[UIColor orangeColor]];
            [btn25 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn25 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=25;
            btnCommon=btn25;
            [self blink];
            
        }
        
        
        
        
        
    }
    
    //for fri
    
    
    
    else if([self getDayInInteger]==5)
    {
        if([classCompartmentSelection timeSpanInInteger]==morning)
        {
            
            
           // [btn5 setBackgroundColor:[UIColor orangeColor]];
            [btn5 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn5 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=5;
            btnCommon=btn5;
            [self blink];
        }
        
        if([classCompartmentSelection timeSpanInInteger]==afternoon)
        {
            
            
            //[btn12 setBackgroundColor:[UIColor orangeColor]];
            [btn12 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn12 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=12;
            btnCommon=btn12;
            [self blink];
            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==evening)
        {
            
            
            //[btn19 setBackgroundColor:[UIColor orangeColor]];
            [btn19 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn19 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=19;
            
            btnCommon=btn19;
            [self blink];
        }
        
        
        
        
        if([classCompartmentSelection timeSpanInInteger]==night)
        {
            
            
            //[btn26 setBackgroundColor:[UIColor orangeColor]];
            [btn26 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn26 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=26;
            
            btnCommon=btn26;
            [self blink];
            
        }
        
        
        
        
        
    }
    
    //for sat 
    
    
    
    else if([self getDayInInteger]==6)
    {
        if([classCompartmentSelection timeSpanInInteger]==morning)
        {
            
            
            //[btn6 setBackgroundColor:[UIColor orangeColor]];
            [btn6 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            
            [btn6 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=6;

            btnCommon=btn6;
            [self blink];        
        
        }
        
        if([classCompartmentSelection timeSpanInInteger]==afternoon)
        {
            
            
          //  [btn13 setBackgroundColor:[UIColor orangeColor]];
            [btn13 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn13 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=13;
            
            
            btnCommon=btn13;
            [self blink];
            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==evening)
        {
            
           // [btn20 setBackgroundColor:[UIColor orangeColor]];
            [btn20 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            
            [btn20 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=20;
            btnCommon=btn20;
            [self blink];
            
        }
        
        
        
        
        if([classCompartmentSelection timeSpanInInteger]==night)
        {
            
            
            
           // [btn27 setBackgroundColor:[UIColor orangeColor]];
            [btn27 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn27 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=27;
        
            btnCommon=btn27;
            [self blink];
            
            
        }
        
        
        
        
        
    }
    
    //for sun 
    
    
    
    else if([self getDayInInteger]==7)
    {
        if([classCompartmentSelection timeSpanInInteger]==morning)
        {
            
            
            //[btn7 setBackgroundColor:[UIColor orangeColor]];
            [btn7 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];            
            [btn7 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=7;
            btnCommon=btn7;
            [self blink];
        }
        
        if([classCompartmentSelection timeSpanInInteger]==afternoon)
        {
            //[self mthodBtnGlow:btn14];
          //  [btn14 setBackgroundColor:[UIColor orangeColor]];
            [btn14 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn14 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=14;
            btnCommon=btn14;
            [self blink];
            
            
        }
        
        if([classCompartmentSelection timeSpanInInteger]==evening)
        {
            //[self mthodBtnGlow:btn28];
                [ btn21 setBackgroundColor:[UIColor orangeColor]];
                [btn21 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
        
            [btn21 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            bayno=21;
            btnCommon=btn21;
            [self blink];
        }
        
        
        
        
        if([classCompartmentSelection timeSpanInInteger]==night)
        {
            //[self mthodBtnGlow:btn28];
           //[btn28 setBackgroundColor:[UIColor orangeColor]];
            [btn28 setBackgroundImage:[UIImage imageNamed:@"liht.png"] forState:UIControlStateNormal];
            [btn28 addTarget:self action:@selector(methodTakeMedicine) forControlEvents:UIControlEventTouchUpInside];
            
            bayno=28;
            btnCommon=btn28;
            [self blink];
            
        }
        
        
        
        
        
    }
    
    
    
     */
    
}


+(int)timeSpanInInteger
{
    
    
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy:MM:dd"];   
    
    
    // current Time
    NSString * currentDate=[dateFormatter stringFromDate:[NSDate date]];
    
    // date formater for full datetime
    NSDateFormatter * dateTimeFormatter=[[NSDateFormatter alloc] init];
    [dateTimeFormatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];   
    
    // morning,afternoon,evening,night start and end time wieth todays date
    
    NSDate * morningStartTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 0:00:01",currentDate]];
    NSDate * morningEndTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 11:59:59",currentDate]];
    
    NSDate * afternoonStartTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 12:00:00",currentDate]];
    NSDate * afternoonEndTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 16:59:59",currentDate]];
    
    NSDate * eveningStartTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 17:00:00",currentDate]];
    NSDate * eveningEndTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 19:59:59",currentDate]];
    
    
    NSDate * nightStartTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 20:00:00",currentDate]];
    NSDate * nightEndTime=[dateTimeFormatter dateFromString:[NSString stringWithFormat:@"%@ 23:00:00",currentDate]];
    
    [dateFormatter release];
    [dateTimeFormatter release];
    
    if([morningStartTime compare:[NSDate date]]==NSOrderedAscending  && [morningEndTime compare:[NSDate date]]==NSOrderedDescending )
    {
        
        return 1;
        
        
    }
    
    
    else if([afternoonStartTime compare:[NSDate date]]==NSOrderedAscending  && [afternoonEndTime compare:[NSDate date]]==NSOrderedDescending )
    {
        
        return 2;
        
        
    }
    
    
    
    else if([eveningStartTime compare:[NSDate date]]==NSOrderedAscending && [eveningEndTime compare:[NSDate date]]==NSOrderedDescending)
    {
        
        return 3; 
        
    }
    
    
    
    else if([nightStartTime compare:[NSDate date]]==NSOrderedAscending && [nightEndTime compare:[NSDate date]]==NSOrderedDescending)
    {
        
        
        return 4;
        
    }
    
    
    
    
    return 0;    
   
    
}


+(int)getDayInInteger
{
    
    NSDate *date =[NSDate date];
    NSDateFormatter *df1 = [NSDateFormatter new];
    [df1 setDateFormat:@"EEEE"];  
    NSString *strDay=[df1 stringFromDate:date];
    NSLog(@"%@",strDay);
    
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
    
    
    
//    classTakePill *obj=[[classTakePill alloc]initWithNibName:@"classTakePill" bundle:nil];
//    
//    obj.userid=objUser.userId;
//    obj.bayno=bayno;
    
    classMedicineVerification *obj=[[classMedicineVerification alloc]initWithNibName:@"classMedicineVerification" bundle:nil];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:obj];
    
    [self presentModalViewController:nav animated:YES];
    
    
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





-(void)calculatebacklogs
{
    
    
    
    
    
    
    
    
    
    
    
}




@end
