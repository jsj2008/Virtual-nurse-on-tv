//
//  classMesureBPNew.m
//  PHCLite
//
//  Created by Avi Kulkarni on 05/08/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classMesureBPNew.h"
#import "PHCLiteNewAppDelegate.h"
#import "classWebServices.h"
#import "classHimoglobin.h"
#import "classSynkData.h"
#import "classLog.h"
#import "classSetting.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "classGlycoHemoglobin.h"
#import "remindMed.h"
#import "commanFunctions.h"
#import "classHome.h"


typedef int NSInteger;
typedef unsigned int NSUInteger;


NSMutableArray * arrayOfNumberInText;


AVAudioPlayer *objMesureHimoglobin;
@implementation classMesureBPNew
@synthesize lblDia;
@synthesize lblPulse;
@synthesize btnEnter;
@synthesize bppickerBackView;
@synthesize lblSys1;
@synthesize lblDia1;
@synthesize lblPulse1;
@synthesize btnReading4;
@synthesize btnReading3;
@synthesize BtnReading2;
@synthesize btnDoneTouch;
@synthesize delegate;
@synthesize btnmainReading;
@synthesize DatePickerBackView;
@synthesize DatePickerview;
@synthesize lblsysmes;
@synthesize lblDiames;
@synthesize lblpulsemes;
@synthesize btnDatetime;
@synthesize lblbpm;
@synthesize lblDiastolic;
@synthesize lblsystolic;
@synthesize btndiastolic;
@synthesize btnSystolic;
@synthesize btnReading;
@synthesize Pickerbackview;
@synthesize obj_BP;
@synthesize str_dia,str_pulse,str_sys;
@synthesize currentDate;
@synthesize myAudioPlayer;
@synthesize lblTotalBP;
@synthesize arrayFlags;
@synthesize aUser;
@synthesize btnTake;
@synthesize skip;
@synthesize pickerView;
@synthesize BPdelegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
     if (self) {
               // Custom initialization        
                   array_systolic=[[NSMutableArray alloc]init];
               //   [array_systolic addObject:@"0"];
                   int i;
                   for (i=50; i<=231; i++)
                    {
                      [array_systolic addObject:[NSString stringWithFormat:@"%d",i]];
            
                    }
       
                 int j;
        
                 array_diastolic=[[NSMutableArray alloc]init];
                //  [array_diastolic addObject:@"0"];
        
                    for(j=30;j<=140;j++)
                    {
                        [array_diastolic addObject:[NSString stringWithFormat:@"%d",j]];
            
                    }
       
                int k;
                array_pulse=[[NSMutableArray alloc]init];
                //   [array_pulse addObject:@"0"];
        
                    for(k=25;k<=130;k++)
                    {
            
                        [array_pulse addObject:[NSString stringWithFormat:@"%d",k]];
                        
                    }
       
        
                
         arrayOfNumberInText=[[NSMutableArray alloc] initWithObjects:@"zero",@"one",@"two",@"three",@"four",@"five",@"six",@"seven",@"eight",@"nine", nil];
         arrayofHundredNumberInText=[[NSMutableArray alloc]initWithObjects:@"zero",@"onehundred",@"twohundred",@"threehundred",@"fourhundred",@"fivehundred",@"sixhundred",@"sevenhundred",@"eighthundred",@"ninehundered", nil];
         
         arrayOfNumberInText1=[[NSMutableArray alloc] initWithObjects:@"zero",@"eleven",@"twelve",@"thirteen",@"fourteen",@"fifteen",@"sixteen",@"seventeen",@"eighteen",@"ninteen", nil];
         arrayOfNumberInText2=[[NSMutableArray alloc] initWithObjects:@"zero",@"ten",@"twenty",@"thiry",@"forty",@"fifty",@"sixty",@"seventy",@"eighty",@"ninety", nil];

                 componentOneValue=120;
                 componentTwoValue=80;
                 componentThreeValue=70;
                }
    
    return self;
}

- (void)dealloc
{
    [Pickerbackview release];
    [pickerView release];
    [btnReading release];
    [lblbpm release];
    [lblDiastolic release];
    [lblsystolic release];
    [btndiastolic release];
    [btnSystolic release];
    [lblsysmes release];
    [lblDiames release];
    [lblpulsemes release];
    [btnDatetime release];
    [setdateTime release];
    [DatePickerBackView release];
    [DatePickerview release];
    [btnmainReading release];
    [btnDoneTouch release];
    [BtnReading2 release];
    [btnReading3 release];
    [btnReading4 release];
    [lblSys1 release];
    [lblDia1 release];
    [lblPulse1 release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
         [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(IBAction)Cancle
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
     
    titleString=[[NSString alloc]init];
    self.title=@"BP";
    self.navigationController.tabBarItem.title=@"Tracker";
    
    
    UIBarButtonItem *barCancle=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(Cancle)];
    self.navigationItem.leftBarButtonItem=barCancle;            
       self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(DonePicker)] autorelease];         
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backGroundNew.png"]]];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault ;
    
    pickerView.frame=CGRectMake(0, 15,320, 80);

    [pickerView selectRow:70 inComponent:0 animated:YES];
    [pickerView selectRow:50 inComponent:1 animated:YES];
    [pickerView selectRow:45 inComponent:2 animated:YES];
    lblTotalBP.text=[NSString stringWithFormat:@"%d",120];
    lblDia.text=[NSString stringWithFormat:@"%d",80];
    lblPulse.text=[NSString stringWithFormat:@"%d",70];
    
    // Do any additional setup after loading the view from its nib.
    
       btnDoneTouch.hidden=YES;
        [self setDateTime1:[NSDate date]];

//   
  NSMutableArray *array=[[NSMutableArray alloc]init];    


    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    language=[userDefaults objectForKey:[NSString stringWithFormat:@"languageselected%d",self.aUser.userId]];
    audiosatus=[userDefaults objectForKey:[NSString stringWithFormat:@"audioStatus%d",aUser.userId]];
    
    if ([audiosatus isEqualToString: @"on"]) {
        if([language isEqualToString:@"1"])
        {
            [array addObject:@"PleaseMesureBpAndTapDone"];
        }
        else if([language isEqualToString:@"2"])
        {
            [array addObject:@"15"];
            
        }
        [myAudioPlayer playAudios:array];
        [array release];
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    NSString *strImg1=@"backImage1.png";
    NSString *strImg=[classDatabaseOperations getNurseImg:aUser.userId];
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:strImg];
    NSData *myData = [[[NSData alloc] initWithContentsOfFile:databasePath] autorelease];
    
    NSLog(@"%@image",strImg);
    
    if ([strImg isEqualToString:@"null"])
    {
        nurseImgeView.image=[UIImage imageNamed:strImg1];
    }
    else{
        NSLog(@"Nurse is %@",strImg);
        nurseImgeView.image=[UIImage imageWithData:myData];
    }
    [self.pickerView reloadAllComponents];
    
    
}

- (void)viewDidUnload
{
    [self setPickerbackview:nil];
    [self setPickerView:nil];
    [self setBtnReading:nil];
    [self setLblbpm:nil];
    [self setLblDiastolic:nil];
    [self setLblsystolic:nil];
    [self setBtndiastolic:nil];
    [self setBtnSystolic:nil];
    [self setLblsysmes:nil];
    [self setLblDiames:nil];
    [self setLblpulsemes:nil];
    [self setBtnDatetime:nil];
    [self setDatePickerBackView:nil];
    [self setDatePickerview:nil];
    [self setBtnmainReading:nil];
    [self setBtnDoneTouch:nil];
    [self setBtnReading2:nil];
    [self setBtnReading3:nil];
    [self setBtnReading4:nil];
    [self setLblSys1:nil];
    [self setLblDia1:nil];
    [self setLblPulse1:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)saveBPInformation
{
  //  NSString * memberId=[(PHCLiteNewAppDelegate *) [[UIApplication sharedApplication]delegate]memberId];
    //  NSLog(@"%@",memberId);
    
    str_sys=[NSString stringWithFormat:@"%d",componentOneValue];
    str_dia=[NSString stringWithFormat:@"%d",componentTwoValue];
    str_pulse=[NSString stringWithFormat:@"%d",componentThreeValue];
    
    NSString *memberId =aUser.memberId;
    int userid=aUser.userId;
    
    
    NSLog(@"member id is %@",memberId);
    NSLog(@"userid is %d",userid);
    // NSString *currentDate=self.btndateTime.titleLabel.text;    //get current date
    NSDate *picker_date= [NSDate date];
    NSDateFormatter *dateformator=[[NSDateFormatter alloc]init];
    [dateformator setDateFormat:@"MM/dd/yyyy HH:mm:ss "];
    NSString *Date=[dateformator stringFromDate:picker_date];
    [dateformator setDateFormat:@" HH:mm:ss"];
    NSString *currentTime=[dateformator stringFromDate:picker_date];
    NSLog(@"today is.......%@\n",Date); //show Date MM/dd/yyyy HH:mm:ss format.
    NSLog(@"today is.......%@\n",currentTime);
    NSString *bpString=[NSString stringWithFormat:@" %@/%@/%@",str_sys,str_dia,str_pulse];
    NSString *query=[NSString stringWithFormat:@"insert into healthydata (userid,memberid,date,time,type,unit,value1)values(%d,'%@','%@','%@','BP','mmHg','%@')",userid,memberId,Date,currentTime,bpString];
    NSLog(@"\n\n\n\nqueryis...%@",query);
    
    [classDatabaseOperations addData:query];
    
//    query=[NSString stringWithFormat:@"insert into healthydata (userid,memberid,date,time,type,unit,value1)values(%d,'%@','%@','%@','BPdia','mmHg',%@)",userid,memberId,Date,currentTime,str_dia ];
//    NSLog(@"\n\n\n\nqueryis...%@",query);
//    [classDatabaseOperations addData:query];
//
//    query=[NSString stringWithFormat:@"insert into healthydata (userid,memberid,date,time,type,unit,value1)values(%d,'%@','%@','%@','pulse','ppm',%@)",userid,memberId,Date,currentTime,str_pulse ];
//    NSLog(@"\n\n\n\nqueryis...%@",query);
//    [classDatabaseOperations addData:query];
    if(![memberId isEqualToString:@""])
     {
    NSString *SoapMsg=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
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
                       "</soap:Envelope>",memberId,@"",@"SPB502",@"NVX9686BT",@"B",@"",str_dia,str_pulse,str_sys,@"iPhone",@"Web",@"",@"",@"",@"",Date];
    
    NSLog(@"%@",SoapMsg);
    //url for webservice method
    NSString * url=@"http://pancare.panhealth.com/test/Service.asmx";
    
    // and soap aciton of webservice method
    NSString *soapAction=@"http://tempuri.org/UpdatePhr";
    
    // create the object of webservice class, this class contian all code for webservice and parsing
    classWebServices * objWebService=[[classWebServices alloc]init];
    objWebService.delegate=self;
    
    // call the method and pass all info i.e. body, url and soapaction
    [objWebService callWebService:SoapMsg url:url soapAction:soapAction ];
    
    [objWebService release];
     }
}

-(void)resultAfterParsing:(NSMutableArray *)soapResult
{
    
    NSLog(@"Error in webServices");
}


-(void)connectionDidFailWithError
{
    
    
}






-(void)setDateTime1:(NSDate *)selectdateTime
{
    self.obj_BP.date=selectdateTime;
    
    NSDateFormatter *formator=[[NSDateFormatter alloc]init];
    [formator setDateFormat:@"EE, MMMM dd,yyyy,h:mm a"];
    
    [self.btnDatetime setTitle:[formator stringFromDate:selectdateTime] forState:UIControlStateNormal];
    
    NSLog(@"%@",[formator stringFromDate:selectdateTime]);
    
}
- (IBAction)setDateTime:(id)sender 
{
    pickerView.hidden=YES;
    lblDia1.hidden=YES;
    lblSys1.hidden=YES;
    lblPulse1.hidden=YES;


    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.8];
    
    CGPoint point;
    point=self.DatePickerBackView.center;
    
    point.y=332;
    
    self.DatePickerBackView.center=point;
    
    //self.DatePickerBackView.center=point;
    
    [UIView commitAnimations];
    
}

- (IBAction)TouchDonePicker:(id)sender 
{
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.8];
    
    CGPoint point;
    point=self.DatePickerBackView.center;
    
    point.y=586;
    
    self.DatePickerBackView.center=point;
    
    [self setDateTime1:[self.DatePickerview date]];
    
    [UIView commitAnimations];
    
    
}
- (IBAction)selectReading:(id)sender 
{
    pickerView.hidden=NO;
    lblPulse1.hidden=NO;
    lblSys1.hidden=NO;
    lblDia1.hidden=NO;
    
    [self TouchDonePicker:nil];
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.8];
    
    CGPoint point;
    point=self.Pickerbackview.center;
    
    point.y=332;
    
    self.Pickerbackview.center=point;
    
    [UIView commitAnimations];
    
}
//Pickers datasource method
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{  
    if(component==0)
    {
        return [array_systolic count];
        
    }
    else if(component==1)
    {
        return[array_diastolic count];
        
    }
    else if(component==2)
    {
        return [array_pulse count];
        
    }
    return 0;      
}
//Pickers Delegate Method for all pickers;
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{  
    if(component==0)
    {
        return [array_systolic objectAtIndex:row];
    }
    else if(component==1)
    {
        return [array_diastolic objectAtIndex:row];
        
    }
    else if(component==2)
    {
        
        return [array_pulse objectAtIndex:row];
    }
	
    return @"abc";
}
-(void)pickerView:(UIPickerView *)pickerView1 didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
        
    NSMutableArray * array;
    
    
    if(component==0)
    {
        
        componentOneValue=[[array_systolic objectAtIndex:row] intValue];
        // create array
        array=[[NSMutableArray alloc] init];
        
        [array addObject:@"systolic1"];
        if(componentOneValue<100)
        {
            
            int a=componentOneValue/10;
            
            int b=componentOneValue%10;
            NSLog(@"value of a=%d b=%d",a,b);
            if (a==1) {
                [array addObject:[arrayOfNumberInText1 objectAtIndex:b]];

            }
            else
            {
              [array addObject:[arrayOfNumberInText2 objectAtIndex:a]];
                if (b>0) {
                    [array addObject:[arrayOfNumberInText objectAtIndex:b]];

                }
            }
            
        }
        else  if(componentOneValue>=100)
            
        {
            int tempVal1=componentOneValue; 
            
            int a=tempVal1/100;
            
            tempVal1=tempVal1%100;
            
            int   b=tempVal1/10;
            
            int c=tempVal1%10;
            NSLog(@"value of a=%d b=%d c=%d",a,b,c);

            [array addObject:[arrayofHundredNumberInText objectAtIndex:a]];
                if (b==0) {
                    if (c>0)
                        [array addObject:[arrayOfNumberInText objectAtIndex:c]];
                }
            if (b==1) {
                if(c==0)
                    [array addObject:[arrayOfNumberInText2 objectAtIndex:b]];
                if (c>0) {
                    [array addObject:[arrayOfNumberInText1 objectAtIndex:c]];

                }

            }
                else
                {
                    [array addObject:[arrayOfNumberInText2 objectAtIndex:b]];
                    if (c>0) {
                        [array addObject:[arrayOfNumberInText objectAtIndex:c]];
                        
                    }
                    
                }
                
                        
        }
        
    }
    else
        if(component==1)
        {
            
            componentTwoValue=[[array_diastolic objectAtIndex:row] intValue];
            // create array
            array=[[NSMutableArray alloc] init];
            
            [array addObject:@"diastolic1"];
            if(componentTwoValue<100)
            {
                
                int a=componentTwoValue/10;
                
                int b=componentTwoValue%10;
                
                [array addObject:[arrayOfNumberInText objectAtIndex:a]];
                [array addObject:[arrayOfNumberInText objectAtIndex:b]];
                
                
            }
            else  if(componentTwoValue>=100)
                
            {
                int tempVal2=componentTwoValue; 
                
                int a=tempVal2/100;
                
                tempVal2=tempVal2%100;
                
                int   b=tempVal2/10;
                
                int c=tempVal2%10;     
                
                
                [array addObject:[arrayOfNumberInText objectAtIndex:a]];
                [array addObject:[arrayOfNumberInText objectAtIndex:b]];
                [array addObject:[arrayOfNumberInText objectAtIndex:c]];
            }
            

        }
        else
            if(component==2)
            {
                
                componentThreeValue=[[array_pulse objectAtIndex:row] intValue];
                // create array
                array=[[NSMutableArray alloc] init];
                
                [array addObject:@"pulse1"];
                if(componentThreeValue<100)
                {
                    
                    int a=componentThreeValue/10;
                    
                    int b=componentThreeValue%10;
                    
                    [array addObject:[arrayOfNumberInText objectAtIndex:a]];
                    [array addObject:[arrayOfNumberInText objectAtIndex:b]];
                    
                    
                }
                else  if(componentThreeValue>=100)
                    
                {
                    int tempVal3=componentThreeValue; 
                    
                    int a=tempVal3/100;
                    
                    tempVal3=tempVal3%100;
                    
                    int   b=tempVal3/10;
                    
                    int c=tempVal3%10;     
                    
                    
                    [array addObject:[arrayOfNumberInText objectAtIndex:a]];
                    [array addObject:[arrayOfNumberInText objectAtIndex:b]];
                    [array addObject:[arrayOfNumberInText objectAtIndex:c]];
                    
                    
                }
                
            }
    
    
    
    [self setBPFromComponent1:componentOneValue Component2:componentTwoValue Component3:componentThreeValue];
    
    [array release];
    
    
    
}
- (IBAction)selectSystolic:(id)sender 
{
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.8];
    
    CGPoint point;
    point=self.Pickerbackview.center;
    
    point.y=332;
    
    self.Pickerbackview.center=point;
    
    [UIView commitAnimations];
    
}
- (IBAction)selectdiastolic:(id)sender
{
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.8];
    
    CGPoint point;
    point=self.Pickerbackview.center;
    
    point.y=332;
    
    self.Pickerbackview.center=point;
    
    [UIView commitAnimations];
    
}
-(void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)SelectDiaReading:(id)sender
{
    pickerView.hidden=NO;
    
    
}
-(IBAction)selectPulseReading:(id)sender
{
    pickerView.hidden=NO;
    
}

-(void)setSys:(NSString *)selectedSys
{
    
    [self.btnReading setTitle:selectedSys forState:UIControlStateNormal];
    
    str_sys=selectedSys;
    
}
-(void)setDia:(NSString *)selectedDia
{
    
      [self.btnReading4 setTitle:selectedDia forState:UIControlStateNormal];
    
    str_dia=selectedDia;
    
}
-(void)setPulse:(NSString *)selectedPulse
{
    [self.btnReading3 setTitle:selectedPulse forState:UIControlStateNormal];
    
    str_pulse=selectedPulse; 
    
}






- (IBAction)selectBtnEnter:(id)sender 
{
    // GlucosePicker.hidden=NO;
    btnEnter.hidden=YES;
    skip.hidden=YES;
    [self TouchDonePicker:nil];
   [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.bppickerBackView.center;
    
    // set new cordinate
    point.y=302;
    
    //assigne new cordinate
    self.bppickerBackView.center=point;
    [UIView commitAnimations];
    
}

- (void)doneBPEntering
{
    //[txtGlucoseReading resignFirstResponder];
    
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.28];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.bppickerBackView.center;
    
    // set new cordinate
    point.y=586;
    
    //assigne new cordinate
    self.bppickerBackView.center=point;
    
    
    [UIView commitAnimations];
    
    btnEnter.hidden=NO;
    skip.hidden=NO;

    
}






-(IBAction)skipPressed:(id)sender
{
    
    [self checkFlag];
    NSMutableArray *array=[[NSMutableArray alloc]init];

    if ([audiosatus isEqualToString: @"on"]) {
        if([language isEqualToString:@"1"])
        {
            [array addObject:@"skipped"];
        }
        else if([language isEqualToString:@"2"])
        {
            [array addObject:@"9.1"];
            
        }
        [myAudioPlayer playAudios:array];
        [array release];
    }
      [self.BPdelegate BPskipFlag];
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{    
    
    
    if(alertView.tag==168)
    {
        
        
      if(buttonIndex==0)// done
        {
            
            // play audio to mesure weight
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"EnterBPReading"];
            [myAudioPlayer playAudios:array];
            [array release];
            
        }
        else if(buttonIndex==1)// skip
            
        {
            [self checkFlag];         /*
           classHimoglobin *obj_himoglobin=[[classHimoglobin alloc]initWithNibName:@"classHimoglobin" bundle:nil];
            //UINavigationController *navC1=[[UINavigationController alloc]initWithRootViewController:obj_himoglobin];
            obj_himoglobin.delegate=self;
            obj_himoglobin.tabBarItem.title=@"Add";
            obj_himoglobin.aUser
            obj_himoglobin.myAudioPlayer=self.myAudioPlayer;
            [self.navigationController pushViewController:obj_himoglobin animated:YES];
            [obj_himoglobin release];*/
            
        }
        
        
    }
    else if(alertView.tag==111)
    {
        
        
        if(buttonIndex==0)// ok
        {
            
            
            
            [self checkFlag];
            //[self.navigationController popToRootViewControllerAnimated:NO ];

          /* classHimoglobin *obj_himoglobin=[[classHimoglobin alloc]initWithNibName:@"classHimoglobin" bundle:nil];
           // UINavigationController *navC1=[[UINavigationController alloc]initWithRootViewController:obj_himoglobin];
            obj_himoglobin.delegate=self;
            obj_himoglobin.myAudioPlayer=self.myAudioPlayer;
            obj_himoglobin.tabBarItem.title=@"Add";
            [self.navigationController pushViewController:obj_himoglobin animated:YES];
            //[self presentModalViewController:navC1 animated:YES];
            [obj_himoglobin release];*/
            
        }
        
        
        
    }
    
    else if(alertView.tag==116)
    {
        if(buttonIndex==0)
        {
            [self.navigationController popToRootViewControllerAnimated:NO ];
        }
    }
    
    
    
}
-(void)PickerButtonPress{
	
	UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UILabel *pickerTitleLabel=[[UILabel alloc]init];
    [pickerTitleLabel setFrame:CGRectMake(150,5, 100, 40)];

   
    //[pickerTitleLabel setBackgroundColor:[UIColor clearColor]];
    [pickerTitleLabel setTextColor:[UIColor blueColor]];
     [pickerTitleLabel setText:titleString];
	[cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [actionSheetObj addSubview:pickerTitleLabel];

	//[cancelBtn setImage:[UIImage imageNamed:@"bt_cancel_action.png"] forState:UIControlStateNormal];
	[cancelBtn setFrame:CGRectMake(10,5, 60, 40)];
	[cancelBtn addTarget:self action:@selector(cancelBtnPress) forControlEvents:UIControlEventTouchUpInside];
	[actionSheetObj addSubview:cancelBtn];
	UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	//[doneBtn setImage:[UIImage imageNamed:@"bt_done_action.png"] forState:UIControlStateNormal];
	[doneBtn setTitle:@"Done" forState:UIControlStateNormal];
	[doneBtn setFrame:CGRectMake(210,5, 60, 40)];
    [doneBtn addTarget:self action:@selector(doneBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [actionSheetObj addSubview:doneBtn];
	[actionSheetObj addSubview:pickerView];
	[actionSheetObj showInView:self.view];
	[actionSheetObj sendSubviewToBack:pickerView];
    [actionSheetObj setBounds:CGRectMake(0,0,320, 460)];

	[pickerView setFrame:CGRectMake(10, 50, 300, 350)];
}

-(void)cancelBtnPress
{
	[actionSheetObj dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)doneBtnPress{
	
	
}



-(IBAction)measureBtnPressed:(id)sender
{
    
    
    UIButton *btn=(UIButton*)sender;
	if (btn.tag==0) {
        [self PickerButtonPress];
        titleString=@"Systolic";
    }
	if (btn.tag==1)
	{
        [self PickerButtonPress];
        titleString=@"Diastolic";


    }
    if (btn.tag==2) {
        [self PickerButtonPress];
        titleString=@"Pulse";


	}

}

-(IBAction)DonePicker
{   
    
    if(componentOneValue ==0 || componentTwoValue ==0 || componentThreeValue ==0)
    {
        
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Empty Reading" message:@"Please enter your BP Reading" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        
        [self doneBPEntering];
       [self saveBPInformation];
        
     //   [btnmainReading setTitle:[NSString stringWithFormat:@"%d / %d mmHg          %d bpm",componentOneValue,componentTwoValue,componentThreeValue] forState:UIControlStateNormal];
        
       if(![aUser.memberId isEqualToString:@""])
       {
        UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:[NSString stringWithFormat:@"Your BP Reading Systolic: %d, Diastolic: %d, Pulse: %d has been entered Successfully", componentOneValue,componentTwoValue,componentThreeValue] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
           alertReading.transform = CGAffineTransformMakeTranslation( 0, -100);
    
        [alertReading show];
          alertReading.tag=111;
        [alertReading release]; 
           [self.BPdelegate BPdoneFlag];

       }
        
        else
        {
            UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"MemberId Not Found!" message:[NSString stringWithFormat:@"Your BP Reading Systolic: %d, Diastolic: %d, Pulse: %d has been entered Successfully on local Database", componentOneValue,componentTwoValue,componentThreeValue] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
            alertReading.transform = CGAffineTransformMakeTranslation( 0, -100);

            [alertReading show];
            alertReading.tag=111;
            [alertReading release];
            [self.BPdelegate BPdoneFlag];

        }
        NSMutableArray * array=[[NSMutableArray alloc] init];        
        if ([audiosatus isEqualToString: @"on"]) {
            if([language isEqualToString:@"1"])
            {
                // play audio to mesure weight
                [array addObject:@"yourbloodPressureReading"];
                [array addObject:@"systolic1"];
                if(componentOneValue<100)
                {
                    
                    int a=componentOneValue/10;
                    
                    int b=componentOneValue%10;
                    NSLog(@"value of a=%d b=%d",a,b);
                    if(b>0 && a>1)
                    {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:a]];
                        [array addObject:[arrayOfNumberInText objectAtIndex:b]];
                    }
                    if (a==1 && b>0) {
                        [array addObject:[arrayOfNumberInText1 objectAtIndex:b]];
                    }
                    if (a==1 && b==0) {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:a]];
                    }
                    if (a>1 && b==0) {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:a]];
                        
                    }
                }
                else if(componentOneValue>=100)
                    
                {
                    int tempVal1=componentOneValue;
                    
                    int a=tempVal1/100;
                    
                    tempVal1=tempVal1%100;
                    
                    int   b=tempVal1/10;
                    
                    int c=tempVal1%10;
                    NSLog(@"value of a=%d b=%d c=%d",a,b,c);
                    if(a>0)
                    {
                        [array addObject:[arrayofHundredNumberInText objectAtIndex:a]];
                        if (b==0) {
                            if (c>0)
                                [array addObject:[arrayOfNumberInText objectAtIndex:c]];
                        }
                        if (b==1) {
                            if (c>0)
                                [array addObject:[arrayOfNumberInText1 objectAtIndex:c]];
                            if (c==0)
                                [array addObject:[arrayOfNumberInText2 objectAtIndex:b]];
                        }
                        if(b>1)
                        {
                            [array addObject:[arrayOfNumberInText2 objectAtIndex:b]];
                            if (c>0) {
                                [array addObject:[arrayOfNumberInText objectAtIndex:c]];
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                [array addObject:@"diastolic1"];
                if(componentTwoValue<100)
                {
                    
                    int a=componentTwoValue/10;
                    
                    int b=componentTwoValue%10;
                    NSLog(@"value of a=%d b=%d",a,b);
                    
                    if(b>0 && a>1)
                    {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:a]];
                        
                        [array addObject:[arrayOfNumberInText objectAtIndex:b]];
                    }
                    if (a==1 && b>0) {
                        [array addObject:[arrayOfNumberInText1 objectAtIndex:b]];
                    }
                    if (a==1 && b==0) {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:a]];
                    }
                    if (a>1 && b==0) {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:a]];
                        
                    }
                    
                }
                else  if(componentTwoValue>=100)
                    
                {
                    int tempVal2=componentTwoValue;
                    
                    int a=tempVal2/100;
                    
                    tempVal2=tempVal2%100;
                    
                    int   b=tempVal2/10;
                    
                    int c=tempVal2%10;
                    NSLog(@"value of a=%d b=%d c=%d",a,b,c);
                    if(a>0)
                    {
                        [array addObject:[arrayofHundredNumberInText objectAtIndex:a]];
                        if (b==0) {
                            if (c>0)
                                [array addObject:[arrayOfNumberInText objectAtIndex:c]];
                        }
                        if (b==1) {
                            if (c>0)
                                [array addObject:[arrayOfNumberInText1 objectAtIndex:c]];
                            if (c==0)
                                [array addObject:[arrayOfNumberInText2 objectAtIndex:b]];
                        }
                        if(b>1)
                        {
                            [array addObject:[arrayOfNumberInText2 objectAtIndex:b]];
                            if (c>0) {
                                [array addObject:[arrayOfNumberInText objectAtIndex:c]];
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                [array addObject:@"pulse1"];
                if(componentThreeValue<100)
                {
                    
                    int a=componentThreeValue/10;
                    
                    int b=componentThreeValue%10;
                    NSLog(@"value of a=%d b=%d",a,b);
                    
                    if(b>0 && a>1)
                    {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:a]];
                        
                        [array addObject:[arrayOfNumberInText objectAtIndex:b]];
                    }
                    if (a==1 && b>0) {
                        [array addObject:[arrayOfNumberInText1 objectAtIndex:b]];
                    }
                    if (a==1 && b==0) {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:a]];
                    }
                    if (a>1 && b==0) {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:a]];
                        
                    }
                }
                else  if(componentThreeValue>=100)
                    
                {
                    int tempVal3=componentThreeValue; 
                    
                    int a=tempVal3/100;
                    
                    tempVal3=tempVal3%100;
                    
                    int   b=tempVal3/10;
                    
                    int c=tempVal3%10;     
                    if(a>0)
                    {
                        [array addObject:[arrayofHundredNumberInText objectAtIndex:a]];
                        if (b==0) {
                            if (c>0)
                                [array addObject:[arrayOfNumberInText objectAtIndex:c]];
                        }
                        if (b==1) {
                            if (c>0)
                                [array addObject:[arrayOfNumberInText1 objectAtIndex:c]];
                            if (c==0)
                                [array addObject:[arrayOfNumberInText2 objectAtIndex:b]];
                        }
                        if(b>1)
                        {
                            [array addObject:[arrayOfNumberInText2 objectAtIndex:b]];
                            if (c>0) {
                                [array addObject:[arrayOfNumberInText objectAtIndex:c]];
                                
                            }
                            
                        }
                        
                    }
                }
                
                
                [array addObject:@"BPhasBeenEntered"];
            }
            else if([language isEqualToString:@"2"])
            {
                // play audio to mesure weight
                [array addObject:@"16.0"];
                
                if(componentOneValue<100)
                {
                    
                    int a=componentOneValue/10;
                    int b=componentOneValue%10;
                    NSArray *numberArray=[[NSArray alloc] init];
                    
                    numberArray=[classCommanFunctions marathiAudioMethod:0 :a :b];
                    for (int i=0; i<[numberArray count]; i++) {
                        [array addObject:[numberArray objectAtIndex:i]];
                    }

                }
                else if(componentOneValue>=100)
                    
                {
                    int tempVal1=componentOneValue;
                    
                    int a=tempVal1/100;
                    
                    tempVal1=tempVal1%100;
                    
                    int   b=tempVal1/10;
                    
                    int c=tempVal1%10;
                    NSArray *numberArray=[[NSArray alloc] init];
                    numberArray=[classCommanFunctions marathiAudioMethod:a :b :c];
                    for (int i=0; i<[numberArray count]; i++) {
                        [array addObject:[numberArray objectAtIndex:i]];
                    }
                }
                [array addObject:@"16.1"];
                if(componentTwoValue<100)
                {
                    
                    int a=componentTwoValue/10;
                    
                    int b=componentTwoValue%10;
                    NSArray *numberArray=[[NSArray alloc] init];
                    
                    numberArray=[classCommanFunctions marathiAudioMethod:0 :a :b];
                    for (int i=0; i<[numberArray count]; i++) {
                        [array addObject:[numberArray objectAtIndex:i]];
                    }
                    
                }
                else  if(componentTwoValue>=100)
                    
                {
                    int tempVal2=componentTwoValue;
                    
                    int a=tempVal2/100;
                    
                    tempVal2=tempVal2%100;
                    
                    int   b=tempVal2/10;
                    
                    int c=tempVal2%10;
                    NSArray *numberArray=[[NSArray alloc] init];
                    
                    numberArray=[classCommanFunctions marathiAudioMethod:a :b :c];
                    for (int i=0; i<[numberArray count]; i++) {
                        [array addObject:[numberArray objectAtIndex:i]];
                    }
                    
                }
                
                [array addObject:@"16.2"];
                if(componentThreeValue<100)
                {
                    
                    int a=componentThreeValue/10;
                    
                    int b=componentThreeValue%10;
                    NSArray *numberArray=[[NSArray alloc] init];
                    
                    numberArray=[classCommanFunctions marathiAudioMethod:0 :a :b];
                    for (int i=0; i<[numberArray count]; i++) {
                        [array addObject:[numberArray objectAtIndex:i]];
                    }
                }
                else  if(componentThreeValue>=100)
                    
                {
                    int tempVal3=componentThreeValue; 
                    
                    int a=tempVal3/100;
                    
                    tempVal3=tempVal3%100;
                    
                    int   b=tempVal3/10;
                    
                    int c=tempVal3%10;     
                    NSArray *numberArray=[[NSArray alloc] init];
                    
                    numberArray=[classCommanFunctions marathiAudioMethod:a :b :c];
                    for (int i=0; i<[numberArray count]; i++) {
                        [array addObject:[numberArray objectAtIndex:i]];
                    }

                }
                
                
                [array addObject:@"17"];
                
            }
    }
               
       [myAudioPlayer playAudios:array];
        [array release];
    }
        
}



-(void)setBPFromComponent1:(int)value1 Component2:(int)value2 Component3:(int)value3
{
    
    NSString *totalWight=[NSString stringWithFormat:@"%d",value1];
    
    lblTotalBP.text=totalWight;
    lblDia.text=[NSString  stringWithFormat:@"%d", value2];
     lblPulse.text=[NSString  stringWithFormat:@"%d", value3];
}

-(void)mesuringBloodPressureDidCancel
{
    
    [self dismissModalViewControllerAnimated:YES];
    
    
}


-(void)mesuringBloodPressureComplete
{
    
    
    
    
}







-(void)checkFlag
{
    
    [myAudioPlayer stopAudio];   
    
        NSString *str4= [arrayFlags objectAtIndex:4];
      NSString *str5= [arrayFlags objectAtIndex:5];
    NSString *str6= [arrayFlags objectAtIndex:6];
     if([str4 isEqualToString:@"YES"])    
     {
        classHimoglobin *obj_himoglobin=[[classHimoglobin alloc]initWithNibName:@"classHimoglobin" bundle:nil];
        obj_himoglobin.myAudioPlayer=myAudioPlayer;
        obj_himoglobin.tabBarItem.title=@"Add";
        obj_himoglobin.aUser=self.aUser;
        obj_himoglobin.arrayFlags=self.arrayFlags;      
        [self.navigationController pushViewController:obj_himoglobin animated:YES];
        //[self presentModalViewController:navC1 animated:YES];
        [obj_himoglobin release];
        
        //arrayofControllers=[[NSMutableArray alloc]initWithObjects:navC,nil];
        
        
        
        
        
    }
    else if( [str5 isEqualToString:@"YES"])
    {
        
        classGlycoHemoglobin *obj_glyco=[[classGlycoHemoglobin alloc]initWithNibName:@"classGlycoHemoglobin" bundle:nil];
        //navC=[[UINavigationController alloc]initWithRootViewController:obj_glyco];
        // obj_glyco.delegate=self;
        obj_glyco.myAudioPlayer=self.myAudioPlayer;
        obj_glyco.aUser=aUser;
        obj_glyco.arrayFlags=arrayFlags;
        obj_glyco.tabBarItem.title=@"Add";
        [self.navigationController pushViewController:obj_glyco animated:YES];                
        [obj_glyco release];
        
        // arrayofControllers=[[NSMutableArray alloc]initWithObjects:navC,nil];
        
        
        
        
    }
   else if([str6 isEqualToString:@"YES"]) 
    {
        
        
        remindMed *obj_med;
        [myAudioPlayer stopAudio];
        
        NSDate* currenDate = [NSDate date];
        NSString *CurrentTime =[currenDate description];
        int i=[commanFunctions getTimeSpanOfTime:CurrentTime];
        NSMutableArray  *med= [commanFunctions getMedicineIndexForTimeSpan:i forUser:aUser];
        NSMutableArray *medArray=[classDatabaseOperations generateMedicineListForTime:med:aUser];
        
        NSLog(@"Error%d",med.count);
        obj_med=[[remindMed alloc]initWithNibName:@"remindMed" bundle:nil];
        obj_med.tabBarItem.title=@"Take Med";
        obj_med.tabBarItem.image=[UIImage imageNamed:@"synk.png"];
        obj_med.medArray= medArray;
        obj_med.arrayFlags=arrayFlags;
        obj_med.myAudioPlayer=self.myAudioPlayer;
        obj_med.aUser=aUser;
        
        if (medArray.count==0) {
            
            [self.navigationController pushViewController:obj_med animated:YES];           
            
            [obj_med release];
        }
        else
        {
            classMedicine *medicine=[medArray objectAtIndex:0];
            obj_med.med_obj=medicine;
            [self.navigationController pushViewController:obj_med animated:YES];             
            [obj_med release];
        }
        
    }
   
    
    else{
        
        classHome *classHomeObj=[[classHome alloc]initWithNibName:@"classHome" bundle:nil];


        if (classHomeObj.BPBool==FALSE) {
            
            [self.navigationController popToRootViewControllerAnimated:NO ];
            
        }
        else{
        UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:@"All readings entered successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        //[alertReading show];
        alertReading.tag=116;
        [alertReading release]; 


        }



    }
    
    
}

-(void)showMesureBpAlert
{
    
}



@end
