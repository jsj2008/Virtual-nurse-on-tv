//
//  classHome.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 4/7/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "vcUserList.h"
#import "classUser.h"
#import "classDatabaseOperations.h"
#import "classNewUser.h"
#import "classDeleteMember.h"
#import "classAudio.h"
#import "classLog.h"
#import "classSynkData.h"
#import "classSetting3.h"
#import "classMesureGlucose1.h"
#import "classMesureWeight2.h"
#import "classGlycoHemoglobin.h"
#import "tvcMedicineList.h"
#import "remindMed.h"
#import "classHome.h"
#import "classAnimation.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

static int curveValues[] = {
  UIViewAnimationOptionCurveEaseInOut,
  UIViewAnimationOptionCurveEaseIn,
  UIViewAnimationOptionCurveEaseOut,
  UIViewAnimationOptionCurveLinear };
int timespan;
NSMutableArray *timetotext;
@implementation classHome
@synthesize btnTracker;
@synthesize audioPlayer;
@synthesize btnMed;
@synthesize btnLogs;
@synthesize btnSetting;
@synthesize aUser;
@synthesize userName;
@synthesize arrayFlags;
@synthesize myAudioPlayer;
@synthesize arrayofControllers;
@synthesize navC;
@synthesize notification;
@synthesize userImage;
@synthesize weightBtn;
@synthesize weightBool,hemoBool,glucoseBool,glycoHemoBool,BPBool;
@synthesize counter;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
       timetotext=[[NSMutableArray  alloc]initWithObjects:@"Morning",@"Afternoon",@"Evening",@"night", nil];
        
    }
    return self;
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

    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];

    selectedCurveIndex = 0;
    counter=0;
    doneCounter=0;
    skipCounter=0;
         clUser=[[classUser alloc]init ];
    self.navigationController.navigationBar.hidden=YES;
    clUser = aUser;
    i=0;
     NSLog(@"  \n\n\n cluser userid in setting is  %d", clUser.userId);
    
    NSString *strImg1=@"backImage1.png";
    strImg=[classDatabaseOperations getNurseImg:aUser.userId];
    
    if ([strImg isEqualToString:@"null"])
    {
        nurseImage.image=[UIImage imageNamed:strImg1];
        strImg=strImg1;
    }
    else{
        NSLog(@"Nurse is %@",strImg);
        nurseImage.image=[UIImage imageNamed:strImg];
    }
      
  
    //[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector( alertDisplay) userInfo:nil repeats:NO];
    
     
    NSLog(@"\n\n\n\ntimespan for this time is   %d\n\n\n",timespan);

         
    if(notification)
      {
        UIBarButtonItem *barLogout=[[UIBarButtonItem alloc]initWithTitle:@"exit" style:UIBarButtonItemStyleDone target:self action:@selector(Exit)];
        
        self.navigationItem.leftBarButtonItem=barLogout;  
      }
    else
    {  
     UIBarButtonItem *barLogout=[[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(Logout)];
        
    self.navigationItem.leftBarButtonItem=barLogout;
        
    }
    userName.text=[NSString stringWithFormat:@" %@  %@", aUser.firstName,aUser.lastName];
    self.title=@"Home";
   self.navigationController.tabBarItem.title=@"Home";
    timespan=[classCommanFunctions timeSpanInInteger];
    NSLog(@"Time SPan === %d",timespan);
    aUser.language=[classDatabaseOperations getLanuageStatus:aUser.userId];
    NSLog(@"aUser.language= %d",aUser.language);
     language=[userDefaults objectForKey:[NSString stringWithFormat:@"languageselected%d",self.aUser.userId]];
     audiosatus=[userDefaults objectForKey:[NSString stringWithFormat:@"audioStatus%d",self.aUser.userId]];
    NSLog(@"Audio status %@",audiosatus);
  if ([audiosatus isEqualToString: @"on"]) {
           
       if([language isEqualToString:@"1"])
        {
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"welcome"];
            switch (timespan) {
                case 1:
                    [array addObject:@"goodMorning"];
                    break;
                case 2:
                    [array addObject:@"goodAfternoon"];
                    break;
                case 3:
                    
                    [array addObject:@"goodEvening"];
                    break;
                case 4:
                    [array addObject:@"goodNight"];
                    break;
            }
            [array addObject:@"thisisyourvirtualnurse"];
            [array addObject:@"guide&selfcare"];
            [self.myAudioPlayer playAudios:array];
              }
        
        else if([language isEqualToString:@"2"])
        {
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"1"];
            switch (timespan) {
                case 1:
                    [array addObject:@"2"];
                    break;
                case 2:
                    [array addObject:@"3"];
                    break;
                case 3:
                    
                    [array addObject:@"4"];
                    break;
                case 4:
                    [array addObject:@"5"];
                    break;
            }
            [array addObject:@"6"];
            [array addObject:@"7"];
            [self.myAudioPlayer playAudios:array];
                   }
    

  }
       
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==100) {
        if (buttonIndex==0) {
            [self gotoTracker];
        }
        if (buttonIndex==1) {
            
        }
    }
}
- (void)spinLayer:(CALayer *)inLayer duration:(CFTimeInterval)inDuration
        direction:(int)direction
{
    CABasicAnimation* rotationAnimation;
    
    // Rotate about the z axis
    rotationAnimation =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // Rotate 360 degress, in direction specified
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * direction];
    
    // Perform the rotation over this many seconds
    rotationAnimation.duration = inDuration;
    
    // Set the pacing of the animation
    rotationAnimation.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // Add animation to the layer and make it so
    [inLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    NSMutableArray *array=[[NSMutableArray alloc]init];
    [array addObject:@"button"];
    [myAudioPlayer playAudios:array];
}

-(IBAction)addButtonClick:(id)sender
{

    UIButton* button= (UIButton*)sender;
    [self spinLayer:button.layer duration:3 direction:1];
   


    if (i==1) {

        [btn1 moveTo:CGPointMake(213,162) duration:1.0 option:curveValues[selectedCurveIndex]];
        [btn2 moveTo:CGPointMake(213,162) duration:1.0 option:curveValues[selectedCurveIndex]];
        [btn3 moveTo:CGPointMake(213,162) duration:1.0 option:curveValues[selectedCurveIndex]];
        [btn4 moveTo:CGPointMake(213,162) duration:1.0  option:curveValues[selectedCurveIndex]];
        [btn5 moveTo:CGPointMake(213,162) duration:1.0 option:curveValues[selectedCurveIndex]];

        i=0;

        selectedCurveIndex = 0;
       
       // [button setImage:[UIImage imageNamed:@"close_icon.png"] forState:UIControlStateNormal];
      

    }

   else if(i==0)
   {

  
    [btn1 moveTo:CGPointMake(150,167) duration:1.0 option:curveValues[selectedCurveIndex]];
    [btn2 moveTo:CGPointMake(159,119) duration:1.0 option:curveValues[selectedCurveIndex]];
    [btn3 moveTo:CGPointMake(209,99)  duration:1.0 option:curveValues[selectedCurveIndex]];
    [btn4 moveTo:CGPointMake(258,119) duration:1.0 option:curveValues[selectedCurveIndex]];
    [btn5 moveTo:CGPointMake(268,167) duration:1.0 option:curveValues[selectedCurveIndex]];
   
       i=1;
       selectedCurveIndex = 1;
      // [button setImage:[UIImage imageNamed:@"plus_icon.png"] forState:UIControlStateNormal];

       btn1.hidden=NO;
       btn2.hidden=NO;
       btn3.hidden=NO;
       btn4.hidden=NO;
       btn5.hidden=NO;
       
   }
    [self spinLayer:btn1.layer duration:3 direction:1];
    [self spinLayer:btn2.layer duration:3 direction:1];
    [self spinLayer:btn3.layer duration:3 direction:1];
    [self spinLayer:btn4.layer duration:3 direction:1];
    [self spinLayer:btn5.layer duration:3 direction:1];

    }
-(void)weightdoneFlag
{
    weightBtn.userInteractionEnabled=FALSE;
    weightBool=TRUE;
    doneFlag=TRUE;
    skipFlag=FALSE;
    counter=counter+1;
    NSLog(@"Counter %d",counter);
    [self allRedingsMethod];
    [weightBtn setImage:[UIImage imageNamed:@"weight_iconnewcheck1"] forState:UIControlStateNormal];
  
}
-(void)allRedingsMethod
{
    if (counter==5) {
        UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:@"All readings entered successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertReading show];
        [alertReading release];
    }
    else
    {
       // [self numberAlert];
        
    }
//    NSMutableArray * array=[[NSMutableArray alloc] init];
//
//if ([audiosatus isEqualToString: @"on"]) {
//    
//    
//    if([language isEqualToString:@"1"])
//    {
//        [array addObject:@"allReadingsEntered"];
//        
//        
//    }
//    
//    else if([language isEqualToString:@"2"])
//    {
//        [array addObject:@"allReadingsEntered"];
//        
//        }
//    [self.myAudioPlayer playAudios:array];
//    [array release];
//            
//        
//        
//        
//        
//    }
}
-(void)weightskipFlag
{
    weightBtn.userInteractionEnabled=TRUE;
    doneFlag=FALSE;
    skipFlag=TRUE;
    [weightBtn setImage:[UIImage imageNamed:@"weight_cross_icon"] forState:UIControlStateNormal];
    //[self numberAlert];

}
-(void)BPdoneFlag
{
    btn3.userInteractionEnabled=FALSE;
    BPBool=TRUE;
    doneFlag=TRUE;
    skipFlag=FALSE;
    counter=counter+1;
    NSLog(@"Counter %d ",counter);
    [btn3 setImage:[UIImage imageNamed:@"bpmeter_iconnewcheck5"] forState:UIControlStateNormal];
    [self allRedingsMethod];
    
}
-(void)BPskipFlag
{
    btn3.userInteractionEnabled=TRUE;
    BPBool=TRUE;
    doneFlag=FALSE;
    skipFlag=TRUE;

    [btn3 setImage:[UIImage imageNamed:@"bp_cross_icon"] forState:UIControlStateNormal];
    //[self numberAlert];

    
}
-(void)glucosedoneFlag
{
    btn2.userInteractionEnabled=FALSE;
    glucoseBool=TRUE;
    doneFlag=TRUE;
    skipFlag=FALSE;

    NSLog(@"Glucose %d",glucoseBool);
    counter=counter+1;
    NSLog(@"Counter %d ",counter);

    [btn2 setImage:[UIImage imageNamed:@"glucose_iconnewcheck5"] forState:UIControlStateNormal];
    [self allRedingsMethod];
}
-(void)glucoseskipFlag
{
    btn2.userInteractionEnabled=TRUE;
    glucoseBool=TRUE;
    NSLog(@"Glucose %d",glucoseBool);
    doneFlag=FALSE;
    skipFlag=TRUE;

    [btn2 setImage:[UIImage imageNamed:@"glucose_cross_icon"] forState:UIControlStateNormal];
    //[self numberAlert];

    
}
-(void)hemoglobinDoneFlag
{
    btn4.userInteractionEnabled=FALSE;
    hemoBool=TRUE;
    doneFlag=TRUE;
    skipFlag=FALSE;
    counter=counter+1;
    NSLog(@"Counter %d ",counter);

    [btn4 setImage:[UIImage imageNamed:@"hemoglobin_iconnewcheck2"] forState:UIControlStateNormal];
    [self allRedingsMethod];

}
-(void)hemoglobinskipFlag
{
    btn4.userInteractionEnabled=TRUE;
    hemoBool=TRUE;

    [btn4 setImage:[UIImage imageNamed:@"hemoglobin_cross_icon"] forState:UIControlStateNormal];
    doneFlag=FALSE;
    skipFlag=TRUE;
   // [self numberAlert];


}
-(void)glycohemoglobinDoneFlag
{
    btn5.userInteractionEnabled=FALSE;
    glycoHemoBool=TRUE;
    counter=counter+1;
    NSLog(@"Counter %d ",counter);
    doneFlag=TRUE;
    skipFlag=FALSE;
    [btn5 setImage:[UIImage imageNamed:@"glycohemoglobin_iconnewcheck3"] forState:UIControlStateNormal];
    [self allRedingsMethod];
    
}
-(void)glycohemoglobinskipFlag
{
    btn5.userInteractionEnabled=TRUE;
    glycoHemoBool=TRUE;
    [btn5 setImage:[UIImage imageNamed:@"glycohemoglobin_cross_icon"] forState:UIControlStateNormal];
    doneFlag=FALSE;
    skipFlag=TRUE;

   // [self numberAlert];


}
-(void)numberAlert
{
    

    if (doneFlag==TRUE) {
        doneCounter=doneCounter+1;
    }
    if (skipFlag==TRUE) {
        skipCounter=skipCounter+1;
    }
    UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:[NSString stringWithFormat:@" Your have taken %d readings and %d skipped.",doneCounter,skipCounter] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertReading show];
    [alertReading release];
    
//    NSMutableArray * array=[[NSMutableArray alloc] init];
//    if ([audiosatus isEqualToString: @"on"]) {
//        
//        if([language isEqualToString:@"1"])
//        {
//            [array addObject:@"youhavetaken"];
//            switch (doneCounter) {
//                case 0:
//                    [array addObject:@"zero"];
//                    break;
//                case 1:
//                    [array addObject:@"one"];
//                    break;
//                case 2:
//                    [array addObject:@"two"];
//                    break;
//                case 3:
//                    [array addObject:@"three"];
//                    break;
//                case 4:
//                    [array addObject:@"four"];
//                    break;
//                case 5:
//                    [array addObject:@"five"];
//                    break;
//            }
//            [array addObject:@"readings"];
//            
//            switch (skipCounter) {
//                case 0:
//                    [array addObject:@"zero"];
//                    break;
//                case 1:
//                    [array addObject:@"one"];
//                    break;
//                case 2:
//                    [array addObject:@"two"];
//                    break;
//                case 3:
//                    [array addObject:@"three"];
//                    break;
//                case 4:
//                    [array addObject:@"four"];
//                    break;
//                case 5:
//                    [array addObject:@"five"];
//                    break;
//            }
//            [array addObject:@"skipped"];
//
//        }
//        else if([language isEqualToString:@"2"])
//        {
//            [array addObject:@"31.0"];
//
//            switch (doneCounter) {
//                case 0:
//                    [array addObject:@"1.0"];
//                    break;
//                case 1:
//                    [array addObject:@"1.1"];
//                    break;
//                case 2:
//                    [array addObject:@"1.2"];
//                    break;
//                case 3:
//                    [array addObject:@"1.3"];
//                    break;
//                case 4:
//                    [array addObject:@"1.4"];
//                    break;
//                case 5:
//                    [array addObject:@"1.5"];
//                    break;
//            }
//            [array addObject:@"31.1"];
//
//            
//            switch (skipCounter) {
//                case 0:
//                    [array addObject:@"1.0"];
//                    break;
//                case 1:
//                    [array addObject:@"1.1"];
//                    break;
//                case 2:
//                    [array addObject:@"1.2"];
//                    break;
//                case 3:
//                    [array addObject:@"1.3"];
//                    break;
//                case 4:
//                    [array addObject:@"1.4"];
//                    break;
//                case 5:
//                    [array addObject:@"1.5"];
//                    break;
//            }
//            [array addObject:@"31.2"];
//
//        }
//    }
//    [self.myAudioPlayer playAudios:array];
//    [array release];
 }
-(IBAction)buttonTap:(id)sender
{
    UIButton* button= (UIButton*)sender;
    if (button.tag==0) {
        classMesureWeight2 *objWeight=[[classMesureWeight2 alloc]initWithNibName:@"classMesureWeight2" bundle:nil];
        objWeight.navigationController.tabBarItem.title=@"Tracer";
        objWeight.audioPlayer=self.myAudioPlayer;
        objWeight.aUser=aUser;
        objWeight.delegate=self;
        [self.navigationController pushViewController:objWeight animated:YES];

        [objWeight release];
        
        }
    else if (button.tag==1)
    {

        classMesureGlucose1  *objMesureGlucose=[[classMesureGlucose1 alloc]initWithNibName:@"classMesureGlucose1" bundle:nil];
        objMesureGlucose.myAudioPlayer=self.myAudioPlayer;
      // objMesureGlucose.arrayFlags=arrayFlags;
        objMesureGlucose.aUser=aUser;
        
        objMesureGlucose.glucosedelegate=self;
        [self.navigationController pushViewController:objMesureGlucose animated:YES];
        [objMesureGlucose release];
        

    }
    else if (button.tag==2)
    {
        classMesureBPNew *obj_BP=[[classMesureBPNew alloc]initWithNibName:@"classMesureBPNew" bundle:nil];
        navC=[[UINavigationController alloc]initWithRootViewController:obj_BP];
        //  obj_BP.delegate=self;
        obj_BP.myAudioPlayer=self.myAudioPlayer;
        obj_BP.tabBarItem.title=@"Tracer";
        //obj_BP.arrayFlags=arrayFlags;
        obj_BP.aUser=aUser;
        obj_BP.BPdelegate=self;
        [self.navigationController pushViewController:obj_BP animated:YES];
        [obj_BP release];

     

    }
    else if (button.tag==3)
    {
        classHimoglobin *obj_himoglobin=[[classHimoglobin alloc]initWithNibName:@"classHimoglobin" bundle:nil];
        navC=[[UINavigationController alloc]initWithRootViewController:obj_himoglobin];
        // obj_himoglobin.delegate=self;
        obj_himoglobin.myAudioPlayer=self.myAudioPlayer;
        obj_himoglobin.tabBarItem.title=@"Add";
        obj_himoglobin.aUser=aUser;
        //obj_himoglobin.arrayFlags=arrayFlags;
        obj_himoglobin.hemoglobindelegate=self;
        [self.navigationController pushViewController:obj_himoglobin animated:YES];
        [obj_himoglobin release];
        


    }
    else if (button.tag==4)
    {
        classGlycoHemoglobin *obj_glyco=[[classGlycoHemoglobin alloc]initWithNibName:@"classGlycoHemoglobin" bundle:nil];
        // obj_glyco.delegate=self;
        //obj_glyco.arrayFlags=arrayFlags;
        obj_glyco.myAudioPlayer=self.myAudioPlayer;
        obj_glyco.tabBarItem.title=@"Add";
        obj_glyco.aUser=aUser;
        obj_glyco.glycohemoglobindelegate=self;
        [self.navigationController pushViewController:obj_glyco animated:YES];
        [obj_glyco release];
        
                
        
    }

}


-(IBAction)Exit
{
    exit(0);
}
- (void)viewDidUnload
{
   
    [btnSetting release];
    btnSetting = nil;
    [btnLogs release];
    btnLogs = nil;
    [super viewDidUnload];
   
}


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];

    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString * databasePath = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",aUser.firstName,aUser.lastName]];
    self.navigationController.navigationBar.hidden=YES;

    NSData *myData = [[[NSData alloc] initWithContentsOfFile:databasePath] autorelease];
    if(myData==nil)
    {
        userImage.image = [ UIImage imageNamed:@"userImage.png"];
    }
    else
        userImage.image=[UIImage imageWithData:myData];
    

    
         userName.text=[NSString stringWithFormat:@" %@  %@", aUser.firstName,aUser.lastName];
    
    
    NSLog(@"\n\n\nusername after update %@ %@",aUser.firstName,aUser.lastName);
    NSString *strImg1=@"backImage1.png";
    strImg=[classDatabaseOperations getNurseImg:aUser.userId];
    documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    documentsDir = [documentPaths objectAtIndex:0];
    databasePath = [documentsDir stringByAppendingPathComponent:strImg];
    myData = [[[NSData alloc] initWithContentsOfFile:databasePath] autorelease];
    NSLog(@"%@image",strImg);
    
    if ([strImg isEqualToString:@"null"])
    {
        nurseImage.image=[UIImage imageNamed:strImg1];
    }
    else{
        NSLog(@"Nurse is %@",strImg);
        nurseImage.image=[UIImage imageWithData:myData];
    }
   
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)viewDidAppear:(BOOL)animated
{
    
}

-(void )showTimespanAlert
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Empty Reading" message:@"Please enter your Glycohemoglobin Reading" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release]; 
}

-(IBAction)gotoTracker
{
   /* classAnimation *animate=[[classAnimation alloc] initWithNibName:@"classAnimation" bundle:nil ];
       animate.myAudioPlayer =   self.myAudioPlayer;
    [self.navigationController  pushViewController:animate animated:YES];
    [animate release];   
    */   
    
    //  NSLog(@"\n%@",arrayFlags);
    arrayFlags=[[NSMutableArray alloc] initWithArray:[classDatabaseOperations getFlags:aUser.userId :timespan]];
    if([arrayFlags count ]!=0)
    {
        str1= [arrayFlags objectAtIndex:1];
    str2= [arrayFlags objectAtIndex:2];
    str3= [arrayFlags objectAtIndex:3];
    str4= [arrayFlags objectAtIndex:4];
    str5= [arrayFlags objectAtIndex:5];
    str6= [arrayFlags objectAtIndex:6];
    NSLog(@"\n%@",str1);
    
    if ([str1 isEqualToString: @"YES"])
    {
        
        classMesureWeight2 *objWeight=[[classMesureWeight2 alloc]initWithNibName:@"classMesureWeight2" bundle:nil];
        objWeight.navigationController.tabBarItem.title=@"Tracer";
      objWeight.audioPlayer=self.myAudioPlayer;
        objWeight.arrayFlags=arrayFlags;
        objWeight.aUser=aUser;
         [self.navigationController pushViewController:objWeight animated:YES];
       // navC=[[[UINavigationController alloc]initWithRootViewController:objWeight]autorelease];
        //navC.tabBarItem.title=@"Tracer";
        [objWeight release];
        
       // arrayofControllers=[[NSMutableArray alloc]initWithObjects:navC,nil];
        
        
        
        
        
        arrayofControllers=[[NSMutableArray alloc]initWithObjects:navC,nil];
    }   
    
    else                  
        if ([str2 isEqualToString:@"YES" ])
        {
            // navigate to mesure BG
 classMesureGlucose1  *objMesureGlucose=[[classMesureGlucose1 alloc]initWithNibName:@"classMesureGlucose1" bundle:nil];
            objMesureGlucose.myAudioPlayer=self.myAudioPlayer;   
            objMesureGlucose.arrayFlags=arrayFlags;
            objMesureGlucose.aUser=aUser;
            NSMutableArray * array=[[NSMutableArray alloc] init];     //Adding audio to alert...
            [array addObject:@"MesureGlucoseAudio1"];
            // [myAudioPlayer playAudios:array];
            [array release];      
            
            navC=[[[UINavigationController alloc] initWithRootViewController:objMesureGlucose]autorelease];
            // objMesureGlucose.delegate=self;
            //  objMesureGlucose.myAudioPlayer=self.myAudioPlayer;
            objMesureGlucose.tabBarItem.title=@"Glucose";
            objMesureGlucose.tabBarItem.image=[UIImage imageNamed:@"10-medical.png"];       
            [self.navigationController pushViewController:objMesureGlucose animated:YES];
            [objMesureGlucose release];
            
            
            
            
            //arrayofControllers=[[NSMutableArray alloc]initWithObjects:navC,nil];
            
            
        }
    
        else if([str3 isEqualToString:@"YES"])   
            
        {
            
            classMesureBPNew *obj_BP=[[classMesureBPNew alloc]initWithNibName:@"classMesureBPNew" bundle:nil];
            navC=[[UINavigationController alloc]initWithRootViewController:obj_BP];
            //  obj_BP.delegate=self;
            obj_BP.myAudioPlayer=self.myAudioPlayer;
            obj_BP.tabBarItem.title=@"Tracer";
            obj_BP.arrayFlags=arrayFlags;
            obj_BP.aUser=aUser;
             [self.navigationController pushViewController:obj_BP animated:YES];                
            [obj_BP release];
            
            
           // arrayofControllers=[[NSMutableArray alloc]initWithObjects:navC,nil];
            
            
            
            
            
        }  
        else  if([str4 isEqualToString:@"YES"])    
            
        {
            
            
            
            classHimoglobin *obj_himoglobin=[[classHimoglobin alloc]initWithNibName:@"classHimoglobin" bundle:nil];
            navC=[[UINavigationController alloc]initWithRootViewController:obj_himoglobin];
            // obj_himoglobin.delegate=self;
            obj_himoglobin.myAudioPlayer=self.myAudioPlayer;
            obj_himoglobin.tabBarItem.title=@"Add";
            obj_himoglobin.aUser=aUser;
            obj_himoglobin.arrayFlags=arrayFlags;
             [self.navigationController pushViewController:obj_himoglobin animated:YES];
          // [self presentModalViewController:navC1 animated:YES];
            [obj_himoglobin release];
            
            //arrayofControllers=[[NSMutableArray alloc]initWithObjects:navC,nil];
            
            
            
            
            
        }
        else if([str5 isEqualToString:@"YES"]) 
        {
            
            classGlycoHemoglobin *obj_glyco=[[classGlycoHemoglobin alloc]initWithNibName:@"classGlycoHemoglobin" bundle:nil];
            navC=[[UINavigationController alloc]initWithRootViewController:obj_glyco];
            // obj_glyco.delegate=self;
            obj_glyco.arrayFlags=arrayFlags;
            obj_glyco.myAudioPlayer=self.myAudioPlayer;
            obj_glyco.tabBarItem.title=@"Add";
            obj_glyco.aUser=aUser;
            [self.navigationController pushViewController:obj_glyco animated:YES];                
            [obj_glyco release];
            
            //arrayofControllers=[[NSMutableArray alloc]initWithObjects:navC,nil];
            
            
            
            
        }
        else if([str6 isEqualToString:@"YES"]) 
        {
            
            
            remindMed *obj_med=[[remindMed alloc]initWithNibName:@"remindMed" bundle:nil];
            navC=[[UINavigationController alloc]initWithRootViewController:obj_med];
            obj_med.selectedTime=timespan;
            // obj_glyco.delegate=self;
            //obj_med.myAudioPlayer=self.myAudioPlayer;
            obj_med.arrayFlags=arrayFlags;
            obj_med.tabBarItem.title=@"Add";
            obj_med.aUser=aUser;
             [self.navigationController pushViewController:obj_med animated:YES];                
            [obj_med release];
            
          //  arrayofControllers=[[NSMutableArray alloc]initWithObjects:navC,nil];
            
            
            
            
            
        }
        else
        {
            NSString *message=[timetotext objectAtIndex:timespan-1];
            UIAlertView *noReminder=[[UIAlertView alloc]initWithTitle:@"No Reminder" message:[NSString stringWithFormat:@"You have not selected reminder for %@ ",message] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [noReminder show];
            [noReminder release];
            
        }  
        
        

        
    }    
        
        else
        {
            NSString *message=[timetotext objectAtIndex:timespan-1];
            UIAlertView *noReminder=[[UIAlertView alloc]initWithTitle:@"No Reminder" message:[NSString stringWithFormat:@"You have not selected reminder for %@ ",message] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [noReminder show];
            [noReminder release];
            
        }  
    
    
}   


-(IBAction)gotoMedicine:(id)sender
{
    tvcMedicineList * objMedicineList=[[tvcMedicineList alloc] initWithStyle:UITableViewStyleGrouped];    
    objMedicineList.objUser=aUser;
    objMedicineList.myAudioPlayer=self.myAudioPlayer;
    objMedicineList.objUser.medicineList=[classDatabaseOperations getMedicineListForUser:aUser];
    objMedicineList.title=@"Medication";
    objMedicineList.tabBarItem.image=[UIImage imageNamed:@"synk.png"];
    [self.navigationController pushViewController:objMedicineList animated:YES];
}

- (IBAction)goSetiing:(id)sender {
    
    classSetting3 *objSetting=[[classSetting3 alloc]initWithNibName:@"classSetting3" bundle:nil];
    objSetting.tabBarItem.title=@"Setting";
    objSetting.tabBarItem.image=[UIImage imageNamed:@"setting.png"];
    objSetting.aUser=aUser;
    objSetting.myAudioPlayer=self.myAudioPlayer;

    objSetting.arrayFlags=arrayFlags;
    [self.navigationController pushViewController:objSetting animated:YES];

    
}

- (IBAction)goLogs:(id)sender {
    
    
    classLog *objLog=[[classLog alloc]initWithNibName:@"classLog" bundle:nil];
    objLog.tabBarItem.title=@"Log";
    objLog.aUser=self.aUser;
    objLog.tabBarItem.image=[UIImage imageNamed:@"log.png"];
    [self.navigationController pushViewController:objLog animated:YES];
    

    }

-(IBAction)Logout{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)dealloc {
    
    [btnSetting release];
    [btnLogs release];
    [super dealloc];
}

+(void)setUser:(classUser *)aUser
 {
     clUser = aUser;
 }
@end
