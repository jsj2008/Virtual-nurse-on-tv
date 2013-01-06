//
//  classNotificaitonTimePicker.m
//  i_Strips_Pro
//
//  Created by Sunil Bhosale on 8/31/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classNotificaitonTimePicker.h"
#import "classUser.h"
#import "classLocalNotification.h"
#import "classAudio.h"

#define Morning 1
#define Afternoon 2
#define Evening 3
#define Night 4


@implementation classNotificaitonTimePicker
@synthesize objUser;
@synthesize TimeSpan;
@synthesize pickerTime;
@synthesize lblTime;
@synthesize lblTimeSpan;
@synthesize delegate=_delegate;
@synthesize myAudioPlayer;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [pickerTime release];
    [lblTime release];
    [lblTimeSpan release];
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
    
    
    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)]autorelease];
    
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)]autorelease];
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];


    [self resetPickerAccrodingToOldTime];
    
    self.title=@"Time";
    
    
    NSLog(@" \n\n\nuser in notification picker  %d\n\n\n    ", objUser.userId);
    
}

- (void)viewDidUnload
{
    [self setPickerTime:nil];
    [self setLblTime:nil];
    [self setLblTimeSpan:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




-(void)setNewTime
{
    
    
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
	[timeFormat setDateFormat:@"h:mm:SS a"];	
    NSString * selectedTime=[timeFormat stringFromDate:[self.pickerTime date]];
    
    
    [timeFormat release];
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    
    if(TimeSpan==Morning) // hmmm 
    {
        
        [defaults setObject:selectedTime forKey:[NSString stringWithFormat:@"morningNotificationTime%d",objUser.userId]];
        [classLocalNotification cancelNotificationForTimeSpan:Morning forUser:objUser];

        
    }
    else if(TimeSpan==Afternoon)
    {
        
        [defaults setObject:selectedTime forKey:[NSString stringWithFormat:@"afternoonNotificationTime%d",objUser.userId]];
        [classLocalNotification cancelNotificationForTimeSpan:Afternoon forUser:objUser];

    }
    else if(TimeSpan==Evening)
    {
        
        [defaults setObject:selectedTime forKey:[NSString stringWithFormat:@"eveningNotificationTime%d",objUser.userId]];
        [classLocalNotification cancelNotificationForTimeSpan:Evening forUser:objUser];

    }
    else if(TimeSpan==Night)
    {
        
        [defaults setObject:selectedTime forKey:[NSString stringWithFormat:@"nightNotificationTime%d",objUser.userId]];
        [classLocalNotification cancelNotificationForTimeSpan:Night forUser:objUser];

    }
    
    // reset local notification
    [classLocalNotification setLocalNotificationForUser:objUser];
    
    [self.navigationController popViewControllerAnimated:YES];
  
    
    
}


-(void)resetPickerAccrodingToOldTime
{
    
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
	[timeFormat setDateFormat:@"h:mm:ss a"];	
    
    NSString * time;
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    
    if(TimeSpan==Morning)
    {
         time=[defaults objectForKey:[NSString stringWithFormat:@"morningNotificationTime%d",objUser.userId]];
        lblTime.text=@"Select time for morning reminder";
            lblTimeSpan.text=@"(12:00 AM to 11:59:59 PM)";

        if(objUser.audioStatus==YES)
        {
            if(objUser.language==1)
            {
        NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"selecteTimeForMorningReminder", nil];
        [self.myAudioPlayer playAudios:array];
        [array release];
            }
            else if(objUser.language==2)
            {
                NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"2MorningRemider", nil];
                [self.myAudioPlayer playAudios:array];
                [array release];
                
            }

            
        }
        
    
    }
    else if(TimeSpan==Afternoon)
    {
        
        time=[defaults objectForKey:[NSString stringWithFormat:@"afternoonNotificationTime%d",objUser.userId]];
        lblTime.text=@"Select time for afternoon reminder";
        lblTimeSpan.text=@"(12:00 PM to 04:59:59 PM)";
        
        if(objUser.audioStatus==YES)
        {
            if(objUser.language==1)
            {
        NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"selectTimeForAfternoonReminder", nil];
        [self.myAudioPlayer playAudios:array];
        [array release];
            }
            else if(objUser.language==2)
            {
                NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"2AfterRemider", nil];
                [self.myAudioPlayer playAudios:array];
                [array release];

            }
        }       
    }
    else if(TimeSpan==Evening)
    {
        
        time=[defaults objectForKey:[NSString stringWithFormat:@"eveningNotificationTime%d",objUser.userId]];
        lblTime.text=@"Select time for evening reminder";
        lblTimeSpan.text=@"(05:00 PM to 07:59:59 PM)";  
        
        if(objUser.audioStatus==YES)
        {
            if (objUser.language==1)
            {
            
        NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"selectTimeForEveningReminder", nil];
        [self.myAudioPlayer playAudios:array];
        [array release];
            }
            
            
            else if(objUser.language==2)
            {
                NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"2EvevingREm", nil];
                [self.myAudioPlayer playAudios:array];
                [array release];
                
            }

        }
            
    }
    else if(TimeSpan==Night)
    {
        
         time=[defaults objectForKey:[NSString stringWithFormat:@"nightNotificationTime%d",objUser.userId]];
        lblTime.text=@"Select time for night reminder";
        lblTimeSpan.text=@"(08:00 PM to 11:59:59 AM)";    
        
        if(objUser.audioStatus==YES)
        {
            if(objUser.language==1)
            {
        NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"selecteTimeForNightReminder", nil];
        [self.myAudioPlayer playAudios:array];
        [array release];
            }
            
            else if(objUser.language==2)
            {
                NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"2NightREm", nil];
                [self.myAudioPlayer playAudios:array];
                [array release];
                
            }

            
        }
    }
    
    
    
    NSDate *DateTime=[timeFormat dateFromString:time];    
    [pickerTime setDate:DateTime animated:YES];
 
    [timeFormat release];
    
}


-(void)cancel
{
    
    
    [self.delegate timeSelectionDidCancel];
    
    
    
}

-(void)done
{
    
    
    [self setNewTime];
    [self.delegate timeSelectionDidComplete];
    
}



@end
