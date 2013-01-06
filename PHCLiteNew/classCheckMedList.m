//
//  classCheckMedList.m
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 22/01/12.
//  Copyright 2012 PanHealth Inc. All rights reserved.
//

#import "classCheckMedList.h"
#import "classDatabaseOperations.h"
#import "classUser.h"
#import "classAudio.h"

@implementation classCheckMedList
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
@synthesize btn29;
@synthesize btn30;
@synthesize btn31;
@synthesize btnCommon;
@synthesize objUser;
@synthesize myAudioPlayer;
@synthesize btnClickedTag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization Number Shows Total Medicine in Each Compartment
    }
    return self;
}

- (void)dealloc
{
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
    [self methodSetTarget];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated
{
    if(self.objUser.audioStatus==YES)
    {
        if(self.objUser.language==1)
        {
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"CheckmedEng"];
            
            [self.myAudioPlayer playAudios:array];
            [array release];
        }
        
        else if(self.objUser.language==2)
        {
            
            NSMutableArray * array=[[NSMutableArray alloc] init];
           // [array addObject:@"CheckMed"];
            
           // [self.myAudioPlayer playAudios:array];
            [array release];
            
            
        }
        
    }

    
    [self methodSetTitle];

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


-(void)methodMedcinelist:(UIButton *)btn
{
       
    
    
}
-(void)methodSetTitle
{
    
    
    //[btn1 setTite:[NSString stringWithFormat:@"%@",[self getcount:1]] forState:UIControlStateNormal];
   // [btn1 addTarget:self action:@selector(methodMedcinelist:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:[NSString stringWithFormat:@"%@",[self getcount:1]] forState:UIControlStateNormal];
    [btn2 setTitle:[NSString stringWithFormat:@"%@",[self getcount:2]] forState:UIControlStateNormal];
    [btn3 setTitle:[NSString stringWithFormat:@"%@",[self getcount:3]] forState:UIControlStateNormal];
    [btn4 setTitle:[NSString stringWithFormat:@"%@",[self getcount:4]] forState:UIControlStateNormal];
    [btn5 setTitle:[NSString stringWithFormat:@"%@",[self getcount:5]] forState:UIControlStateNormal];
    [btn6 setTitle:[NSString stringWithFormat:@"%@",[self getcount:6]] forState:UIControlStateNormal];
    [btn7 setTitle:[NSString stringWithFormat:@"%@",[self getcount:7]] forState:UIControlStateNormal];
    [btn8 setTitle:[NSString stringWithFormat:@"%@",[self getcount:8]] forState:UIControlStateNormal];
    [btn9 setTitle:[NSString stringWithFormat:@"%@",[self getcount:9]] forState:UIControlStateNormal];
    [btn10 setTitle:[NSString stringWithFormat:@"%@",[self getcount:10]] forState:UIControlStateNormal];
    [btn11 setTitle:[NSString stringWithFormat:@"%@",[self getcount:11]] forState:UIControlStateNormal];
    [btn12 setTitle:[NSString stringWithFormat:@"%@",[self getcount:12]] forState:UIControlStateNormal];
    [btn13 setTitle:[NSString stringWithFormat:@"%@",[self getcount:13]] forState:UIControlStateNormal];
    [btn14 setTitle:[NSString stringWithFormat:@"%@",[self getcount:14]] forState:UIControlStateNormal];
    [btn15 setTitle:[NSString stringWithFormat:@"%@",[self getcount:15]] forState:UIControlStateNormal];
    [btn16 setTitle:[NSString stringWithFormat:@"%@",[self getcount:16]] forState:UIControlStateNormal];
    [btn17 setTitle:[NSString stringWithFormat:@"%@",[self getcount:17]] forState:UIControlStateNormal];
    [btn18 setTitle:[NSString stringWithFormat:@"%@",[self getcount:18]] forState:UIControlStateNormal];
    [btn19 setTitle:[NSString stringWithFormat:@"%@",[self getcount:19]] forState:UIControlStateNormal];
    [btn20 setTitle:[NSString stringWithFormat:@"%@",[self getcount:20]] forState:UIControlStateNormal];
    [btn21 setTitle:[NSString stringWithFormat:@"%@",[self getcount:21]] forState:UIControlStateNormal];
    [btn22 setTitle:[NSString stringWithFormat:@"%@",[self getcount:22]] forState:UIControlStateNormal];
    [btn23 setTitle:[NSString stringWithFormat:@"%@",[self getcount:23]] forState:UIControlStateNormal];
    [btn24 setTitle:[NSString stringWithFormat:@"%@",[self getcount:24]] forState:UIControlStateNormal];
    [btn25 setTitle:[NSString stringWithFormat:@"%@",[self getcount:25]] forState:UIControlStateNormal];
    [btn26 setTitle:[NSString stringWithFormat:@"%@",[self getcount:26]] forState:UIControlStateNormal];
    [btn27 setTitle:[NSString stringWithFormat:@"%@",[self getcount:27]] forState:UIControlStateNormal];
    [btn28 setTitle:[NSString stringWithFormat:@"%@",[self getcount:28]] forState:UIControlStateNormal];
    
    
    
    
    
    
    
    
}




-(NSString*)getcount:(int)bay
{
    
    NSString *query =[NSString stringWithFormat:@"select count (medicinename) from takemedicine where bayno=%d and userid=%d and state=0 ",bay,objUser.userId];  
    
  int cnt;
    
    cnt=[classDatabaseOperations get:query];
    
    
    
    return [NSString stringWithFormat:@"%d",cnt];
}







@end
