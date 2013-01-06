 //
//  classMesureWeight.m
//  PHCLite
//
//  Created by Avi Kulkarni on 8/3/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classMesureWeight.h"
#import "classMesureGlucose1.h"
#import "classHome1.h"
#import "classUserList.h"
#import "classOptions.h"
#import "classLog.h"
#import "classSetting.h"
#import "classSynk.h"
#import "classWebServices.h"
#import "commanFunctions.h"
#import <AVFoundation/AVAudioPlayer.h>

int optionIndex;
AVAudioPlayer *objMesureGlucoseAudio,*objReadingAudio;

int componentOneValue,componentTwoValue,componentThreeValue;

NSMutableArray * arrayOfNumberInText;


@implementation classMesureWeight
@synthesize pickerWeight;
@synthesize btnWeight3;
@synthesize btnWeight2;
@synthesize btnWeight1;
@synthesize WeightPickerBackView;
@synthesize btnWeightReading;
@synthesize btnDoneTouch;
@synthesize BacksideView;
@synthesize DatePickerbackView;
@synthesize txtWeight;
@synthesize DatePicker;
@synthesize btndatetime;
@synthesize delegate;
@synthesize my_weight;
@synthesize strWeightvalue;
@synthesize strTotalWeightValue,strTotalWeightValue1,strTotalWeightValue2;
@synthesize AllTotalWeightValue;
@synthesize currentDate;
@synthesize lblTotalWight;
@synthesize myAudioPlayer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        // Custom initialization
        
        arrayofWeight1=[[NSMutableArray alloc]init];
        int i;
        for (i=0; i<=9; i++)
        {
            [arrayofWeight1 addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        
        arrayofWeight50=[[NSMutableArray alloc]init];
        int j;
        for (j=0; j<=9; j++)
        {
            [arrayofWeight50 addObject:[NSString stringWithFormat:@"%d",j]];
            
        }
        arrayofWeight100=[[NSMutableArray alloc]init];
        int k;
        for (k=0; k<=9; k++)
        {
            [arrayofWeight100 addObject:[NSString stringWithFormat:@"%d",k]];
            
        }
               
    }
    
    return self;
}

- (void)dealloc
{
    [btndatetime release];
    [txtWeight release];
    [DatePickerbackView release];
    [DatePicker release];
    [selectDone release];
    [BacksideView release];
    [btnDoneTouch release];
    [selectTouchDone release];
    [btnWeightReading release];
    [WeightPickerBackView release];
    [btnWeight1 release];
    [btnWeight2 release];
    [btnWeight3 release];
    [pickerWeight release];
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
     myAudioPlayer=[[classAudio alloc]init];
    
    self.title=@"Weight";
    
     [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backGroundNew.png"]]];
      self.navigationController.navigationBar.barStyle = UIBarStyleDefault ;
    
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)]autorelease];
    
     self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(DonePicker)] autorelease]; 
     //set current date time
    [self setDateTime:[NSDate date]];
    
    //---------------------------------
    componentOneValue=0;
    componentTwoValue=0;
    componentThreeValue=0;
    
    //set initial weight    
    [self showMesureWightAlert];
    
    arrayOfNumberInText=[[NSMutableArray alloc] initWithObjects:@"zero",@"one",@"two",@"three",@"four",@"five",@"six",@"seven",@"eight",@"nine", nil];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    // reset
    componentOneValue=0;
    componentTwoValue=0;
    componentThreeValue=0;
    [self setweightFromComponent1:componentOneValue Component2:componentTwoValue Component3:componentThreeValue];
    [self.pickerWeight reloadAllComponents];

    
}


- (void)viewDidUnload
{
    [self setBtndatetime:nil];
    [self setTxtWeight:nil];
    [self setDatePickerbackView:nil];
    [self setDatePicker:nil];
    [self setBacksideView:nil];
    [self setBtnDoneTouch:nil];
    [self setBtnWeightReading:nil];
    [self setWeightPickerBackView:nil];
    [self setBtnWeight1:nil];
    [self setBtnWeight2:nil];
    [self setBtnWeight3:nil];
    [self setPickerWeight:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)saveWeightInformation
{
    NSString * memberId=[(PHCLiteAppDelegate *) [[UIApplication sharedApplication]delegate]memberId];
    
   AllTotalWeightValue=[NSString stringWithFormat:@"%d%d%d",componentOneValue,componentTwoValue,componentThreeValue];
    
    NSLog(@"%@",memberId);
    //get current date
    NSDate *picker_date= [NSDate date];
    NSDateFormatter *dateformator=[[NSDateFormatter alloc]init];
    [dateformator setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    currentDate=[dateformator stringFromDate:picker_date];
    NSLog(@"%@",currentDate); //show Date MM/dd/yyyy HH:mm:ss format.
    
//   if([self.DatePicker date])
//   {
//      NSDate *picker_date= [self.DatePicker date];
//      NSDateFormatter *dateformator=[[NSDateFormatter alloc]init];
//      [dateformator setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
//      currentDate=[dateformator stringFromDate:picker_date];
//      
//       NSLog(@"%@",currentDate); //show Date MM/dd/yyyy HH:mm:ss format.
//  }
    
    NSString * soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        "<soap:Body>"
                        "<UpdatePhr xmlns=\"http://tempuri.org/\">"
                        "<MemberID>%@</MemberID>"
                        "<DataType>%@</DataType>"
                        "<ComDeviceID>%@</ComDeviceID>"
                        "<ComDeviceSrNo>%@</ComDeviceSrNo>"
                        "<TstConFood>%@</TstConFood>"
                        "<Bg>%@</Bg>"
                        "<BPdia>%@</BPdia>"
                        "<BPpulse>%@</BPpulse>"
                        "<BPsys>%@</BPsys>"
                        "<Source>%@</Source>"
                        "<Method>%@</Method>"
                        "<Weight>%@</Weight>"
                        "<HG>%@</HG>"
                        "<hba1c>%@</hba1c>"
                        "<TstConExercise>%@</TstConExercise>"
                        "<dtReadingDT>%@</dtReadingDT>"
                        "</UpdatePhr>"
                        "</soap:Body>"
                        "</soap:Envelope>",memberId,@"WT",@"SPB502",@"NVX9686BT",@"B",@"",@"",@"",@"",@"iPhone",@"Web",self.AllTotalWeightValue,@"",@"",@"",self.currentDate];
    
    NSLog(@"%@",soapMsg);
    
    //url for webservice method
    NSString * url=@"http://pancare.panhealth.com/test/Service.asmx";
    // and soap aciton of webservice method
    NSString *soapAction=@"http://tempuri.org/UpdatePhr";
    // create the object of webservice class, this class contian all code for webservice and parsing
    classWebServices * objWebService=[[classWebServices alloc]init];
    objWebService.delegate=self;
    
    
    // call the method and pass all info i.e. body, url and soapaction
    [objWebService callWebService:soapMsg url:url soapAction:soapAction ];
    
    [objWebService release];
    
    
}
-(void)resultAfterParsing:(NSString *)soapResult
{
    
    NSLog(@"%@",soapResult);
    
}


-(void)cancel
{
    [objReadingAudio stop];
    [objMesureGlucoseAudio stop];
    //[self.navigationController popViewControllerAnimated:YES];
   [self dismissModalViewControllerAnimated:YES];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField    
{
    [self takeWeightReading];
    
}
-(void)takeWeightReading
{
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.28];
    
    CGPoint point;
    point=self.BacksideView.center;
    
    point.y=290;
    
    self.BacksideView.center=point;
    
    [UIView commitAnimations];
    
    
}
-(void)setDateTime:(NSDate *)selectdateTime
{
    self.my_weight.date=selectdateTime;
    
    NSDateFormatter *formator=[[NSDateFormatter alloc]init];
    [formator setDateFormat:@"EE, MMMM dd,yyyy,h:mm a"];
    
    [self.btndatetime setTitle:[formator stringFromDate:selectdateTime] forState:UIControlStateNormal];
    
    NSLog(@"%@",[formator stringFromDate:selectdateTime]);
    
}
- (IBAction)selectDateTime:(id)sender
{
    pickerWeight.hidden=YES;
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.8];
    
    CGPoint point;
    point=self.DatePickerbackView.center;
    
    point.y=332;
    
    self.DatePickerbackView.center=point;
    
    [UIView commitAnimations]; 
}

- (IBAction)Touchdone:(id)sender 
{
    [UIView beginAnimations:@"sendPickerback" context:nil];
    [UIView setAnimationDuration:0.8];
    
    CGPoint point;
    point=self.DatePickerbackView.center;
    
    point.y=586;
    
    self.DatePickerbackView.center=point;
    
    [UIView commitAnimations];
    
     [self setDateTime:[self.DatePicker date]];
    
}
- (IBAction)DoneBack:(id)sender {
    
    [txtWeight resignFirstResponder];
    //[self TouchDone:nil];
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.28];
    
    CGPoint point;
    point=self.BacksideView.center;
    
    point.y=590;
    
    self.BacksideView.center=point;
    
    [UIView commitAnimations]; 
    
}
#pragma mark myMethods
-(void)showWeightMessage
{
    
    UIAlertView * alertForWeight=[[UIAlertView alloc] initWithTitle:@"Mesure Weight" message:@"To mesure your weight please..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue",@"Skip", nil];
    alertForWeight.tag=1;
    [alertForWeight show];
    [alertForWeight release];
    
    // set optionIndex to zero
    optionIndex=0;
    
}
-(void)showGlucoseMessage
{
   
    classMesureGlucose1 *obj_glucose=[[classMesureGlucose1 alloc]initWithNibName:@"classMesureGlucose1" bundle:nil];
    UINavigationController *navC1=[[UINavigationController alloc]initWithRootViewController:obj_glucose];
    //obj_glucose.delegate=self;
    obj_glucose.tabBarItem.title=@"Add";
    obj_glucose.tabBarItem.image=[UIImage imageNamed:@"10-medical.png"];
    
    UIAlertView * alertForWeight=[[UIAlertView alloc] initWithTitle:@"Mesure Blood Glucose" message:@"Please,measur your Blood Glucose..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue",@"Skip", nil];
    [alertForWeight show];
    alertForWeight.tag=2;
    [alertForWeight release];
    
    // set optionIndex to 1
    optionIndex=1;
    //class log
    classLog * objLog=[[classLog alloc] initWithNibName:@"classLog" bundle:nil]; 
    UINavigationController * navC2=[[UINavigationController alloc] initWithRootViewController:objLog];    
    objLog.tabBarItem.title=@"Log";
    objLog.tabBarItem.image=[UIImage imageNamed:@"calender.png"];
    
    //synk
    classSynk * objSynk=[[classSynk alloc] initWithNibName:@"classSynk" bundle:nil];
    objSynk.tabBarItem.title=@"Synk";
    objSynk.tabBarItem.image=[UIImage imageNamed:@"56-cloud.png"];    
    UINavigationController * navC4=[[UINavigationController alloc] initWithRootViewController:objSynk];
    
    //setting
    classSetting * objSetting=[[classSetting alloc] initWithStyle:UITableViewStylePlain];    
    objSetting.tabBarItem.title=@"Setting";
    objSetting.tabBarItem.image=[UIImage imageNamed:@"setting.png"];
    UINavigationController * navC5=[[UINavigationController alloc] initWithRootViewController:objSetting];
    
    NSArray * arrayOfControllers=[[NSArray alloc] initWithObjects:navC1,navC2,navC4,navC5, nil];
    
    UITabBarController * tabBar=[[UITabBarController alloc] init];
    
    tabBar.viewControllers=arrayOfControllers;
    
    [self.navigationController  pushViewController:tabBar animated:YES];
    
}
-(void)showBpmessage
{
    
    UIAlertView * alertForWeight=[[UIAlertView alloc] initWithTitle:@"Mesure Blood pressure" message:@"To mesure your Blood pressure please..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    [alertForWeight show];
    alertForWeight.tag=3;
    [alertForWeight release];
    
    // set optionIndex to 2
    optionIndex=2;
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (alertView.tag==10)
//    {
//        if(buttonIndex==0)
//        {
//         [delegate mesuringWeightDidComplete];
//        
//        //[obj_Audio stop];
//        
//        classMesureGlucose1 *obj_glucose=[[classMesureGlucose1 alloc]initWithNibName:@"classMesureGlucose1" bundle:nil];
//        UINavigationController *navC1=[[UINavigationController alloc]initWithRootViewController:obj_glucose];
//        //obj_glucose.delegate=self;
//        obj_glucose.tabBarItem.title=@"Add";
//        obj_glucose.tabBarItem.image=[UIImage imageNamed:@"10-medical.png"];
//        
//        UIAlertView * alertForglucose=[[UIAlertView alloc] initWithTitle:@"Measure Blood Glucose" message:@"Please,measure your Blood Glucose..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done",@"Skip", nil];
//        alertForglucose.tag=1;
//        [alertForglucose show];
//        [alertForglucose release];
//        
//        NSString *pathAudio=[[NSBundle mainBundle]pathForResource:@"MesureGlucoseAudio1" ofType:@"aiff"];
//        objMesureGlucoseAudio=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:pathAudio] error:NULL];
//        [objMesureGlucoseAudio play];
//        
//        //class log
//        classLog * objLog=[[classLog alloc] initWithNibName:@"classLog" bundle:nil]; 
//        UINavigationController * navC2=[[UINavigationController alloc] initWithRootViewController:objLog];    
//        objLog.tabBarItem.title=@"Log";
//        objLog.tabBarItem.image=[UIImage imageNamed:@"calender.png"];
//        
//        //synk
//        classSynk * objSynk=[[classSynk alloc] initWithNibName:@"classSynk" bundle:nil];
//        objSynk.tabBarItem.title=@"Synk";
//        objSynk.tabBarItem.image=[UIImage imageNamed:@"56-cloud.png"];    
//        UINavigationController * navC4=[[UINavigationController alloc] initWithRootViewController:objSynk];
//        
//        //setting
//        classSetting * objSetting=[[classSetting alloc] initWithStyle:UITableViewStylePlain];    
//        objSetting.tabBarItem.title=@"Setting";
//        objSetting.tabBarItem.image=[UIImage imageNamed:@"setting.png"];
//        UINavigationController * navC5=[[UINavigationController alloc] initWithRootViewController:objSetting];
//        
//        NSArray * arrayOfControllers=[[NSArray alloc] initWithObjects:navC1,navC2,navC4,navC5, nil];
//        
//        UITabBarController * tabBar=[[UITabBarController alloc] init];
//        
//        tabBar.viewControllers=arrayOfControllers;
//        
//        [self presentModalViewController:tabBar animated:YES];
//        
//        }
//    }   
//    
//    switch (alertView.tag)
//    {
//        case 1: 
//            
//            if(buttonIndex==0)// done
//            {
//                
//                 [objMesureGlucoseAudio stop];
//                
//            }
//            else if(buttonIndex==1)// continue
//            {
//                [objMesureGlucoseAudio stop];
//               
//             classMesureGlucose1 * objMesureGlucose=[[classMesureGlucose1 alloc]initWithNibName:@"classMesureGlucose1" bundle:nil];
//               UINavigationController * navC=[[UINavigationController alloc] initWithRootViewController:objMesureGlucose];
//           //  objMesureGlucose.delegate=self;
//              [self presentModalViewController:navC animated:YES];                
//              [objMesureGlucose release];
//                
//           
//              NSString *path=[[NSBundle mainBundle]pathForResource:@"EnterGlucoseReading" ofType:@"aiff"];
//             objReadingAudio=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
//             [objReadingAudio play];
//               
//               
//            }
//            else if(buttonIndex==2)// skip
//            {
//                [objMesureGlucoseAudio stop];
//                [objReadingAudio stop];
//                [self showBpmessage];
//                
//            }
//            
//            break;
//            
//    }
    
    if(alertView.tag==168)
    {
        
        
        if(buttonIndex==0)// cancel
        {
            
            
        }
        else if(buttonIndex==1)// done
        {
            
            // play audio to mesure weight
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"EnterWeightReading"];
            [myAudioPlayer playAudios:array];
            [array release];
                   
        }
        else if(buttonIndex==2)// skip
            
        {
            
            classMesureGlucose1 * objMesureGlucose=[[classMesureGlucose1 alloc]initWithNibName:@"classMesureGlucose1" bundle:nil];
            //UINavigationController * navC=[[UINavigationController alloc] initWithRootViewController:objMesureGlucose];
            objMesureGlucose.delegate=self;
            objMesureGlucose.myAudioPlayer=self.myAudioPlayer;
            [self.navigationController pushViewController:objMesureGlucose animated:YES];                
            [objMesureGlucose release];
            

        }
        
    }
    else if(alertView.tag==111)
    {
        
        if(buttonIndex==0)// ok reading taken go to next view
        {
            
            // navigate to mesure BG
            classMesureGlucose1 * objMesureGlucose=[[classMesureGlucose1 alloc]initWithNibName:@"classMesureGlucose1" bundle:nil];
          //  UINavigationController * navC=[[UINavigationController alloc] initWithRootViewController:objMesureGlucose];
           // objMesureGlucose.delegate=self;
            objMesureGlucose.myAudioPlayer=self.myAudioPlayer;
            objMesureGlucose.tabBarItem.title=@"Glucose";
           objMesureGlucose.tabBarItem.image=[UIImage imageNamed:@"10-medical.png"];
            
           [self.navigationController pushViewController:objMesureGlucose animated:YES];
            [objMesureGlucose release];
            
            
        }
        
    }
    
}


- (IBAction)selectWeightReading:(id)sender 
{
   
    [self Touchdone:nil];
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.8];
    
    CGPoint point;
    point=self.WeightPickerBackView.center;
    
    point.y=332;
    
    self.WeightPickerBackView.center=point;
    
    [UIView commitAnimations]; 
    
    
}
-(void)setWeight:(NSString *)selectedWeight
{
    
    //self.my_weight.weightReading=[NSString stringWithFormat:@"%@", selectedWeight];
   // [self.btnWeightReading setTitle:selectedWeight forState:UIControlStateNormal];
    [self.btnWeight1 setTitle:selectedWeight forState:UIControlStateNormal];
    
    strWeightvalue=selectedWeight;
    
}
-(void)setWeight1:(NSString *)selectedWeight1
{
    [self.btnWeight2 setTitle:selectedWeight1 forState:UIControlStateNormal];
   
    strWeightValue1=selectedWeight1;
    
}
-(void)setWeight2:(NSString *)selectedWeight2
{
    //self.my_weight.weightReading=[NSString stringWithFormat:@"%@", selectedWeight];
    // [self.btnWeightReading setTitle:selectedWeight forState:UIControlStateNormal];
   [self.btnWeight3 setTitle:selectedWeight2 forState:UIControlStateNormal];
    strWeightValue2=selectedWeight2; 
       
}
//- (IBAction)TouchWeightDone:(id)sender 
//{
//    if(strWeightvalue==nil||[strWeightvalue length]==0&&strWeightValue1==nil||[strWeightValue1 length]==0&&strWeightValue2==nil||[strWeightValue2 length]==0)
//    {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Empty Reading" message:@"Please enter your Weight Reading" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        [alert release];
//        
//        NSString *path=[[NSBundle mainBundle]pathForResource:@"pleaseenter" ofType:@"aiff"];
//        AVAudioPlayer *obj_Audio=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
//        [obj_Audio play];
//        
//        [UIView beginAnimations:@"SendPickerback" context:nil];
//        [UIView setAnimationDuration:0.8];
//        
//        CGPoint point;
//        point=self.WeightPickerBackView.center;
//        
//        point.y=586;
//        
//        self.WeightPickerBackView.center=point;
//        
//        [UIView commitAnimations]; 
//        
//    }
//    else
//    {
//
//        [self saveWeightInformation];
//    
//    UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thanks" message:@"Enter your reading successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [alertReading show];
//    alertReading.tag=10;
//    [alertReading release];
//    
//    NSString *path=[[NSBundle mainBundle]pathForResource:@"EnterSuccess" ofType:@"aiff"];
//    AVAudioPlayer *obj_Audio=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
//    [obj_Audio play];
//    [path release];
//    
//    // strTotalWeightValue=[NSString  stringWithFormat:@"%@%@%@",strWeightvalue,strWeightValue1,strWeightValue2];
//    
//    [UIView beginAnimations:@"SendPickerback" context:nil];
//    [UIView setAnimationDuration:0.8];
//    
//    CGPoint point;
//    point=self.WeightPickerBackView.center;
//    
//    point.y=586;
//    
//    self.WeightPickerBackView.center=point;
//    
//    [UIView commitAnimations]; 
//  }  
//    
//}
//
//- (IBAction)selectTouchdone1:(id)sender 
//{
//    if(strWeightvalue==nil||[strWeightvalue length]==0&&strWeightValue1==nil||[strWeightValue1 length]==0&&strWeightValue2==nil||[strWeightValue2 length]==0)
//   
//    {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Empty Reading" message:@"Please enter your Weight Reading" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        [alert release];
//        
//        NSString *path=[[NSBundle mainBundle]pathForResource:@"pleaseenter" ofType:@"aiff"];
//        AVAudioPlayer *obj_Audio=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
//        [obj_Audio play];
//
//    }
//    else
//    {
//        [self saveWeightInformation];
//        
             
//        [delegate mesuringWeightDidComplete];
//        
//        //[obj_Audio stop];
//        
//        classMesureGlucose1 *obj_glucose=[[classMesureGlucose1 alloc]initWithNibName:@"classMesureGlucose1" bundle:nil];
//        UINavigationController *navC1=[[UINavigationController alloc]initWithRootViewController:obj_glucose];
//        //obj_glucose.delegate=self;
//        obj_glucose.tabBarItem.title=@"Add";
//        obj_glucose.tabBarItem.image=[UIImage imageNamed:@"10-medical.png"];
//        
//        UIAlertView * alertForglucose=[[UIAlertView alloc] initWithTitle:@"Mesure Blood Glucose" message:@"Please,measure your Blood Glucose..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done",@"Skip", nil];
//        alertForglucose.tag=1;
//        [alertForglucose show];
//        [alertForglucose release];
//        
//        NSString *pathAudio=[[NSBundle mainBundle]pathForResource:@"MesureYourGlucose" ofType:@"aiff"];
//        objMesureGlucoseAudio=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:pathAudio] error:NULL];
//        [objMesureGlucoseAudio play];
//        
//        //class log
//        classLog * objLog=[[classLog alloc] initWithNibName:@"classLog" bundle:nil]; 
//        UINavigationController * navC2=[[UINavigationController alloc] initWithRootViewController:objLog];    
//        objLog.tabBarItem.title=@"Log";
//        objLog.tabBarItem.image=[UIImage imageNamed:@"calender.png"];
//        
//        //synk
//        classSynk * objSynk=[[classSynk alloc] initWithNibName:@"classSynk" bundle:nil];
//        objSynk.tabBarItem.title=@"Synk";
//        objSynk.tabBarItem.image=[UIImage imageNamed:@"56-cloud.png"];    
//        UINavigationController * navC4=[[UINavigationController alloc] initWithRootViewController:objSynk];
//        
//        //setting
//        classSetting * objSetting=[[classSetting alloc] initWithStyle:UITableViewStylePlain];    
//        objSetting.tabBarItem.title=@"Setting";
//        objSetting.tabBarItem.image=[UIImage imageNamed:@"setting.png"];
//        UINavigationController * navC5=[[UINavigationController alloc] initWithRootViewController:objSetting];
//        
//        NSArray * arrayOfControllers=[[NSArray alloc] initWithObjects:navC1,navC2,navC4,navC5, nil];
//        
//        UITabBarController * tabBar=[[UITabBarController alloc] init];
//        
//        tabBar.viewControllers=arrayOfControllers;
//        
//        [self presentModalViewController:tabBar animated:YES];
//        

        
   // }   
        
//}
// PickerView Methods....
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    
    return 3;
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0)
    {
      return  [arrayofWeight1 count]; 
    
    }
    if(component==1)
    {
        return  [arrayofWeight50 count]; 
        
    }
    if(component==2)
    {
        return  [arrayofWeight100 count]; 
        
    }
    
       
    return 0;
    
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0)
    {
        return [arrayofWeight1 objectAtIndex:row];
        
    }
    if(component==1)
    {
        return [arrayofWeight50 objectAtIndex:row];
    
    }
    if(component==2)
    {
        return [arrayofWeight100 objectAtIndex:row];
    
    }
    
    return @"abc";
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    if (component==0)
//    {
//       // strWeightvalue=[arrayofWeight1 objectAtIndex:row];
//        [self setWeight:[arrayofWeight1 objectAtIndex:row]];
//    }
//    if (component==1)
//    {
//        //strWeightValue1=[arrayofWeight50 objectAtIndex:row];
//        [self setWeight1:[arrayofWeight50 objectAtIndex:row]];
//    }
//    if (component==2)
//    {
//        //strWeightValue2=[arrayofWeight100 objectAtIndex:row];
//        [self setWeight2:[arrayofWeight100 objectAtIndex:row]];
//    }
    
    
    NSMutableArray * array;
    
    if(component==0)
    {
        
        componentOneValue=[[arrayofWeight1 objectAtIndex:row] intValue];
        
        
            // create array
             array=[[NSMutableArray alloc] init];

            // add audio file for value of component two
            [array addObject:[arrayOfNumberInText objectAtIndex:componentOneValue]];
            
            [myAudioPlayer playAudios:array];
            [array release];
            
        
        
    }
    else
        if(component==1)
        {
            
            componentTwoValue=[[arrayofWeight50 objectAtIndex:row] intValue];
            
            // create array
            array=[[NSMutableArray alloc] init];
            
            // add audio file for value of component two
            [array addObject:[arrayOfNumberInText objectAtIndex:componentTwoValue]];
            
            [myAudioPlayer playAudios:array];
            [array release];


            
        }
        else
            if(component==2)
            {
                
                componentThreeValue=[[arrayofWeight100 objectAtIndex:row] intValue];
                
                // create array
                array=[[NSMutableArray alloc] init];
                
                // add audio file for value of component two
                [array addObject:[arrayOfNumberInText objectAtIndex:componentThreeValue]];
                
                [myAudioPlayer playAudios:array];
                [array release];

  
                
            }
    
    
    [self setweightFromComponent1:componentOneValue Component2:componentTwoValue Component3:componentThreeValue];
    strWeightvalue=[NSString stringWithFormat:@"%d",componentOneValue];
    strWeightValue1=[NSString stringWithFormat:@"%d",componentTwoValue];
    strWeightValue2=[NSString stringWithFormat:@"%d",componentTwoValue];
    
}

- (IBAction)selectWeight1:(id)sender 
{
    pickerWeight.hidden=NO;
    [self Touchdone:nil];
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.8];
    
    CGPoint point;
    point=self.WeightPickerBackView.center;
    
    point.y=332;
    
    self.WeightPickerBackView.center=point;
    
    [UIView commitAnimations]; 
    

    
}
- (IBAction)selectWeight2:(id)sender 
{
    pickerWeight.hidden=NO;
    [self Touchdone:nil];
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.8];
    
    CGPoint point;
    point=self.WeightPickerBackView.center;
    
    point.y=332;
    
    self.WeightPickerBackView.center=point;
    
    [UIView commitAnimations]; 
    
}
- (IBAction)selectWeight3:(id)sender 
{
    pickerWeight.hidden=NO;
    [self Touchdone:nil];
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.8];
    
    CGPoint point;
    point=self.WeightPickerBackView.center;
    
    point.y=332;
    
    self.WeightPickerBackView.center=point;
    
    [UIView commitAnimations]; 
}
-(void)DonePicker
{
    
    
    if(componentOneValue+componentTwoValue+componentThreeValue==0)
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Empty Reading" message:@"Please enter your Weight Reading" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];  
        
        // play audio to mesure weight
        NSMutableArray * array=[[NSMutableArray alloc] init];
        [array addObject:@"EnterWeightReading"];
        [myAudioPlayer playAudios:array];
        [array release];
        
    }
    else
    {
       // [self saveWeightInformation];
       // AllTotalWeightValue=[NSString stringWithFormat:@"%@%@%@",strWeightvalue,strWeightValue1,strWeightValue2];
        
        UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:[NSString stringWithFormat:@" Your weight of %@ kg has been entered Successfully",AllTotalWeightValue] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertReading show];
        alertReading.tag=111;
        [alertReading release]; 
        
        
        // play audio to mesure weight
        NSMutableArray * array=[[NSMutableArray alloc] init];
        [array addObject:@"yourWeightOf"];
        
        if(componentOneValue!=0)
        {
            
            // add audio file for value of component two
            [array addObject:[arrayOfNumberInText objectAtIndex:componentOneValue]];

        }
        
        // add audio file for value of component two
        [array addObject:[arrayOfNumberInText objectAtIndex:componentTwoValue]];
        
        // add audio file for value of component two
        [array addObject:[arrayOfNumberInText objectAtIndex:componentThreeValue]];

        
        [array addObject:@"KGHasbeenEntered"];
        
        [myAudioPlayer playAudios:array];
        [array release];
        
    }
    
}

//--------------------------------------------------------
-(void)setweightFromComponent1:(int)value1 Component2:(int)value2 Component3:(int)value3
{
    
    
    NSString *totalWight=[NSString stringWithFormat:@"%d%d%d",value1,value2,value3];
    
    lblTotalWight.text=totalWight;
    
}
//show mesure weight message..
-(void)showMesureWightAlert
{
    
    UIAlertView * alertForWeight=[[UIAlertView alloc] initWithTitle:@"Mesure Weight" message:@"Please,measure your Weight..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done",@"Skip", nil];
    [alertForWeight show];
    alertForWeight.tag=168;
    [alertForWeight release];
    
    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    [array addObject:@"Hello"];
    
    int timespan=[commanFunctions timeSpanInInteger];
    
    switch (timespan)
    {
        case 1:
            [array addObject:@"morning11"];
            break;
        case 2:
            [array addObject:@"afternoon1"];
            break;
        case 3:
            [array addObject:@"Evening1"];
            break;
        case 4:
            [array addObject:@"currentNight"];
            break;
            
    }
    
    
    // play audio to mesure weight  
    [array addObject:@"PleaseMeasureYourReadingAndTapDone"];
    [myAudioPlayer playAudios:array];
    NSLog(@"%@",myAudioPlayer);
    [array release];
}



@end
