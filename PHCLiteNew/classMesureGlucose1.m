//
//  classMesureGlucose1.m
//  PHCLite
//
//  Created by Avi Kulkarni on 8/2/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classMesureGlucose1.h"
#import "classMesureBPNew.h"
#import "classLog.h"
#import "classSynkData.h"
#import "classSetting.h"
#import "classWebServices.h"
#import "PHCLiteNewAppDelegate.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "classGlycoHemoglobin.h"
#import "classMesureBPNew.h"
#import "remindMed.h"
#import "commanFunctions.h"
#import "classHome.h"
NSArray * arrayOfTags;
AVAudioPlayer *objAudio,*objAudioReading;



//NSMutableArray * arrayOfNumberInText;

@implementation classMesureGlucose1
@synthesize glucosePickerView;
@synthesize arrayFlags;
@synthesize btnGlucose1;
@synthesize btnGlucose2;
@synthesize btnGlucose3;
@synthesize GlucosePickerBackView;
@synthesize GlucosePicker;
@synthesize btnGlucoseReading;
@synthesize btnReadingDone;
@synthesize delegate;
@synthesize btnTakeReading;
@synthesize btnDateTime;
@synthesize btnTag;
@synthesize txtGlucoseReading;
@synthesize pickerTag;
@synthesize pickerBackView;
@synthesize DateTimePickerBackView;
@synthesize dateTimePicker;
@synthesize keyboardBackView;
@synthesize myGlucose;
@synthesize strGlucoseValue;
@synthesize AllGlucoseValue;
@synthesize currentDate;
@synthesize myAudioPlayer;
@synthesize lblTotalGlucose;;
@synthesize aUser;
@synthesize btnTake;
@synthesize skip;
@synthesize  led;
@synthesize arrayOfNumberInText1,arrayOfNumberInText2,arrayOfNumberInText;
@synthesize audioPlayer;
@synthesize arraymeal;
@synthesize strMealTpye;
@synthesize glucosedelegate;



int i,j,k;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
        
      //  arrayofglucose=[[NSMutableArray alloc]init];
    arrayofglucose=[[NSMutableArray alloc]initWithObjects:@"0" ,@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
        arrayofglucose1=[[NSMutableArray alloc]initWithObjects:@"0" ,@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
        arrayofglucose2=[[NSMutableArray alloc]initWithObjects:@"0" ,@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
    arraymeal=[[NSMutableArray alloc]initWithObjects:@"Before Meal",@"After Meal", nil];
   /*     for (i=0; i<=9; i++)
        {
            [arrayofglucose addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
    // [arrayofglucose addObject:[NSString stringWithFormat:@"%d",0]];
        arrayofglucose1=[[NSMutableArray alloc]init];
         for (j=0; j<=9; j++)
        {
            [arrayofglucose1 addObject:[NSString stringWithFormat:@"%d",j]];
            
        }
        arrayofglucose2=[[NSMutableArray alloc]init];
        for (k=0; k<=9; k++)
        {
            [arrayofglucose2 addObject:[NSString stringWithFormat:@"%d",k]];
            
        }*/
        
    }
    
    return self;
}

- (void)dealloc
{
    [btnTakeReading release];
    [btnDateTime release];
    [btnTag release];
    [txtGlucoseReading release];
    [pickerTag release];
    [pickerBackView release];
    [DateTimePickerBackView release];
    [dateTimePicker release];
    [keyboardBackView release];
    [btnReadingDone release];
    [selectReadingDone release];
    [btnGlucoseReading release];
    [GlucosePickerBackView release];
    [GlucosePicker release];
    [btnGlucose1 release];
    [btnGlucose2 release];
    [btnGlucose3 release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)resultAfterParsing:(NSMutableArray *)soapResult
{
    
    NSLog(@"%@",soapResult);
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    led.animationImages=[NSArray arrayWithObjects:
                           
                           [UIImage  imageNamed:@"led1.jpg"],
                           [UIImage  imageNamed:@"led2.jpg"],
                           
                           
                           nil ];
    
    // [stick setAnimationRepeatCount:10];
    
    [led setAnimationDuration:1.0];
    [led startAnimating];

    
    
    
    [GlucosePicker selectRow:1 inComponent:0 animated:YES];
    [GlucosePicker selectRow:0 inComponent:1 animated:YES];
    [GlucosePicker selectRow:0 inComponent:2 animated:YES];
    self.title=@"Glucose";
    self.navigationController.tabBarItem.title=@"Tracker";
    UIBarButtonItem *barCancle=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(Cancle)];
    self.navigationItem.leftBarButtonItem=barCancle;      
    UIBarButtonItem * btnSkip1=[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(DonePicker)];         
    self.navigationItem.rightBarButtonItem=btnSkip1;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault ;
    


    
    lblTotalGlucose.text=@"100";

    arrayOfTags=[[NSArray alloc] initWithObjects:@"(No tag)",@"Pre-Breakfast",@"Post-Breakfast",@"Pre-Lunch",@"Post-Lunch",@"Pre-Dinner",@"Post-Dinner",@"Night", nil];

    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bloodglucose.jpg"]];
    
    
   
    // set the current date and time
    [self setDateTime:[NSDate date]];
    
    
           selectReadingDone.hidden=YES;
    
    
    // reset
    
// 
    componentOneValue=[[arrayofglucose objectAtIndex:1] intValue];
    
      componentTwoValue=[[arrayofglucose1 objectAtIndex:0] intValue];  
    
   componentTwoValue=[[arrayofglucose1 objectAtIndex:0] intValue];    
    
        [self setweightFromComponent1:componentOneValue Component2:componentTwoValue Component3:componentThreeValue];
    //-----------------------------------
   // [self showMesureGlucoseAlert];
    arrayofHundredNumberInText=[[NSMutableArray alloc]initWithObjects:@"zero",@"onehundred",@"twohundred",@"threehundred",@"fourhundred",@"fivehundred",@"sixhundred",@"sevenhundred",@"eighthundred",@"ninehundered", nil];
    arrayOfNumberInText=[[NSMutableArray alloc] initWithObjects:@"zero",@"one",@"two",@"three",@"four",@"five",@"six",@"seven",@"eight",@"nine", nil];
    arrayOfNumberInText1=[[NSMutableArray alloc] initWithObjects:@"zero",@"eleven",@"twelve",@"thirteen",@"fourteen",@"fifteen",@"sixteen",@"seventeen",@"eighteen",@"ninteen", nil];
    arrayOfNumberInText2=[[NSMutableArray alloc] initWithObjects:@"zero",@"ten",@"twenty",@"thiry",@"forty",@"fifty",@"sixty",@"seventy",@"eighty",@"ninety", nil];
//wait
    [NSThread sleepForTimeInterval:.6];
    
   //audio
    NSMutableArray *array=[[NSMutableArray alloc]init];

    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    language=[userDefaults objectForKey:[NSString stringWithFormat:@"languageselected%d",self.aUser.userId]];
    audiosatus=[userDefaults objectForKey:[NSString stringWithFormat:@"audioStatus%d",aUser.userId]];
    
    if ([audiosatus isEqualToString: @"on"]) {
        if([language isEqualToString:@"1"])
        {
            [array addObject:@"PleaeMeasureYourBooldGlucoseAndTapDone"];
        }
        else if([language isEqualToString:@"2"])
        {
            [array addObject:@"12"];
            
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



}

- (void)viewDidUnload
{
    [self setBtnTakeReading:nil];
    [self setBtnDateTime:nil];
    [self setBtnTag:nil];
    [self setTxtGlucoseReading:nil];
    [self setPickerTag:nil];
    [self setPickerBackView:nil];
    [self setDateTimePickerBackView:nil];
    [self setDateTimePicker:nil];
    [self setKeyboardBackView:nil];
    [self setBtnReadingDone:nil];
   // [self setSelectReadingDone:nil];
    [self setBtnGlucoseReading:nil];
    [self setGlucosePickerBackView:nil];
    [self setGlucosePicker:nil];
    [self setBtnGlucose1:nil];
    [self setBtnGlucose2:nil];
    [self setBtnGlucose3:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction)saveGlucoseInformation
{  
    //NSString * memberId=[(PHCLiteNewAppDelegate *) [[UIApplication sharedApplication]delegate]memberId];
    
  AllGlucoseValue=[NSString stringWithFormat:@"%d%d%d",componentOneValue,componentTwoValue,componentThreeValue];
    
        
    
    
    
    NSString *memberId =aUser.memberId;
    int userid=aUser.userId;
    
    
    NSLog(@"member id is %@",memberId);
    NSLog(@"userid is %d",userid);
    // NSString *currentDate=self.btndateTime.titleLabel.text;    //get current date
    NSDate *picker_date= [NSDate date];
    NSDateFormatter *dateformator=[[NSDateFormatter alloc]init];
    [dateformator setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSString *Date=[dateformator stringFromDate:picker_date];
    [dateformator setDateFormat:@" HH:mm:ss"];
    NSString *currentTime=[dateformator stringFromDate:picker_date];
    NSLog(@"today is.......%@\n",Date); //show Date MM/dd/yyyy HH:mm:ss format.
    NSLog(@"today is.......%@\n",currentTime);
    
    NSString *query=[NSString stringWithFormat:@"insert into healthydata (userid,memberid,date,time,type,unit,value1)values(%d,'%@','%@','%@','BG','mg/dl','%@')",userid,memberId,Date,currentTime,AllGlucoseValue ];
    NSLog(@"\n\n\n\nqueryis...%@",query);
    [classDatabaseOperations addData:query];

    
    
    if(![memberId isEqualToString:@""])
    {
    NSString *SoapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
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
                       "<PillBayNo>%@</PillBayNo>"
                       "<PillStatus>%@</PillStatus>"
                       "</UpdatePhr>"
                       "</soap:Body>"
                       "</soap:Envelope>",memberId,@"",@"SPB502",@"NVX8696SPB",@"A",self.AllGlucoseValue,@"",@"",@"",@"iPhone",@"Web",@"",@"",@"",@"",Date,@"",@""];
    
    NSLog(@"%@",SoapMsg);
    //url for webservice method
    NSString * url=@"http://pancare.panhealth.com/test/Service.asmx";
    
    // and soap aciton of webservice method
    NSString *soapAction=@"http://tempuri.org/UpdatePhr";
    
    // create the object of webservice class, this class contian all code for webservice and parsing
    classWebServices * objWebService=[[classWebServices alloc]init];
    objWebService.delegate=self;
    
    // call the method and pass all info i.e. body, url and soapaction
    //[objWebService callWebServiceWithBoday:SoapMsg url:url soapAction:soapAction];
    [objWebService callWebService:SoapMsg url:url soapAction:soapAction ];
    
    [objWebService release];
    }
}


-(void)connectionDidFailWithError
{


}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
  
    //show done on the top of keyboard
    [self takeGlucoseReading];
   
    
}

-(void)takeGlucoseReading
{
    
    [self doneTagSelection:nil];
    [self doneDateTimeSelection:nil];
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.28];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.pickerBackView.center;
    
    // set new cordinate
    point.y=180;
    
    //assigne new cordinate
    self.keyboardBackView.center=point;
    
    [UIView commitAnimations];

}

- (IBAction)doneReadingTaking:(id)sender 
{
    [txtGlucoseReading resignFirstResponder];
    
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.28];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.pickerBackView.center;
    
    // set new cordinate
    point.y=586;
    
    //assigne new cordinate
    self.keyboardBackView.center=point;
    
    
    [UIView commitAnimations];
    
    
}





- (void)doneGlucoseEntering 
{
    [txtGlucoseReading resignFirstResponder];
    
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.28];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.GlucosePickerBackView.center;
    
    // set new cordinate
    point.y=586;
    
    //assigne new cordinate
    self.GlucosePickerBackView.center=point;
    
    
    [UIView commitAnimations];
    
    
    btnGlucose3.hidden=NO;
    btnSkip.hidden=NO;

    
}



- (IBAction)selectDateTime:(id)sender
{
  
   // GlucosePicker.hidden=YES;
      [btnGlucose3 setHidden:YES];
    skip.hidden=YES;

    self.btnGlucose3.hidden=YES;
    [self doneTagSelection:nil];
//    [self doneGlucoseEntering];
    //[self TouchGlucoseDone:nil];
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.pickerBackView.center;
    
    // set new cordinate
    point.y=322;
    
    //assigne new cordinate
    self.DateTimePickerBackView.center=point;
    
    
    [UIView commitAnimations];
    
    
}

- (IBAction)doneDateTimeSelection:(id)sender 
{
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.pickerBackView.center;
    
    // set new cordinate
    point.y=586;
    
    //assigne new cordinate
    self.DateTimePickerBackView.center=point;
    
    [UIView commitAnimations];
    
    btnGlucose3.hidden=NO;
    skip.hidden=NO;


    [self setDateTime:[self.dateTimePicker date]];
}
- (IBAction)selectTag:(id)sender 
{
   // GlucosePicker.hidden=YES;
    btnGlucose3.hidden=YES;
    skip.hidden=YES;

    [self doneGlucoseEntering];
   [self doneDateTimeSelection:nil];
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.pickerBackView.center;
    
    // set new cordinate
    point.y=322;
    
    //assigne new cordinate
    self.pickerBackView.center=point;
    
    [UIView commitAnimations];
    
}

- (IBAction)doneTagSelection:(id)sender
{
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.pickerBackView.center;
    
    // set new cordinate
    point.y=586;
    
    //assigne new cordinate
    self.pickerBackView.center=point;
    
    
    [UIView commitAnimations];
btnGlucose3.hidden=NO;
    skip.hidden=NO;

}

// picker Datasource methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(pickerView==pickerTag)
    {
        return 1;
    
    }
     if(pickerView==GlucosePicker)
    {
       return 3;

    }
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView==pickerTag)
    {
         return  [arrayOfTags count];
    }
     if(pickerView==GlucosePicker)
    {
      
        if(component==0)
        {
                      return [arrayofglucose count];
        }
      else  if (component==1)
        {
                        return [arrayofglucose1 count];
        }
      else  if (component==2)
        {
                      return [arrayofglucose2 count];
        }
    
       else if(component==3)
        {
            
            return [arraymeal count];
        }
    }
    
       return 0;  
    
}

//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
 //   
//    return  1;
//}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView==pickerTag)
    {
        return [arrayOfTags objectAtIndex:row];
    }
     if(pickerView==GlucosePicker)
    {
        if (component==0)
        {
            return [arrayofglucose objectAtIndex:row];
        }
        if (component==1)
        {
             return [arrayofglucose1 objectAtIndex:row];
        }
        if (component==2)
        {
            return [arrayofglucose2 objectAtIndex:row];
            
        }
        if(component==3)
        {
    
            return [arraymeal objectAtIndex:row];
        }

    }
    
    return @"abc";
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch(component) {
        case 0: return 50;
           case 1: return 50;
           case 2: return 50;
        case 3: return 150;

            }
    
    //NOT REACHED
    return 22;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
//    
//    if (pickerView==pickerTag)
//    {
//       [self setTag:[arrayOfTags objectAtIndex:row]];
//    }
//    if (pickerView==GlucosePicker)
//    {    
//        if(component==0)
//        {
//          [self setGlucose:[arrayofglucose objectAtIndex:row]];
//           // strGlucoseValue=[arrayofglucose objectAtIndex:row]; 
//        }
//        if(component==1)
//        {
//            [self setGlucose1:[arrayofglucose1 objectAtIndex:row]];
//        
//        }
//        if(component==2)
//        {
//            [self setGlucose2:[arrayofglucose2 objectAtIndex:row]];
//           //strGlucoseValue2=[arrayofglucose2 objectAtIndex:row];
//        }
//       
//    }
//    
    NSMutableArray * array;
    
    if(component==0)
    {
        
        componentOneValue=[[arrayofglucose objectAtIndex:row] intValue];
        
        // create array
        array=[[NSMutableArray alloc] init];
        
        // add audio file for value of component two
        [array addObject:[arrayOfNumberInText objectAtIndex:componentOneValue]];
        
    }
        
        
   else  if(component==1)
        {
            
            componentTwoValue=[[arrayofglucose1 objectAtIndex:row] intValue];
            array=[[NSMutableArray alloc] init];
            
            // add audio file for value of component two
            [array addObject:[arrayOfNumberInText objectAtIndex:componentTwoValue]];

            
        }
        
          else  if(component==2)
            {
                componentThreeValue=[[arrayofglucose1 objectAtIndex:row] intValue];
                array=[[NSMutableArray alloc] init];
                
                // add audio file for value of component two
                [array addObject:[arrayOfNumberInText objectAtIndex:componentThreeValue]];

                
            }
    
    else if(component==3)
    {
        
        if([arraymeal objectAtIndex:0])
        {
            
            
            strMealTpye=@"B";
            
        }
        
        else
        {
            
            strMealTpye=@"A";
        }
        //strMealTpye=[arraymeal objectAtIndex:row];
        // add audio file for value of component two
        
        
        
        
                
  

    }
    
        componentOneValue=[pickerView selectedRowInComponent:0];
        componentTwoValue=[pickerView selectedRowInComponent:1];
        componentThreeValue=[pickerView selectedRowInComponent:2];
   

    
    [self setweightFromComponent1:componentOneValue Component2:componentTwoValue Component3:componentThreeValue];
    
    
    
    
    
    
    
    
   // [myAudioPlayer playAudios:array];
    [array release];
    
}

-(void)setReading:(NSString *)reading
{
    // check reading is valid or not and then assigne
//    if([self validateReading:reading]==YES)
//    {
//        
//       self.myGlucose.glucoseReading=[self.txtGlucoseReading.text floatValue];
//        
//    }
    
}
-(void)setDateTime:(NSDate *)selectedDate
{
    
    self.myGlucose.date =selectedDate;
    
    // set the selected dat to btn's title
    NSDateFormatter * formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EE, MMMM dd,yyyy,h:mm a"];
    [self.btnDateTime setTitle:[formatter stringFromDate:selectedDate] forState:UIControlStateNormal];
    
    NSLog(@"%@",[formatter stringFromDate:selectedDate]);
    
}
-(void)setTag:(NSString *)selectedTag
{
    
    self.myGlucose.tag=selectedTag;
    [self.btnTag setTitle:selectedTag forState:UIControlStateNormal];

        
}

-(void)setGlucose:(NSString *)selectedGlucose
{
    
    //self.myGlucose.tag=selectedTag;
    [self.btnGlucose1 setTitle:selectedGlucose forState:UIControlStateNormal];
    strGlucoseValue=selectedGlucose; 
    
}
-(void)setGlucose1:(NSString *)selectedGlucose1
{
    
    //self.myGlucose.tag=selectedTag;
    [self.btnGlucose2 setTitle:selectedGlucose1 forState:UIControlStateNormal];
    strGlucoseValue1=selectedGlucose1;
    
}
-(void)setGlucose2:(NSString *)selectedGlucose2
{
    
    //self.myGlucose.tag=selectedTag;
    [self.btnGlucose3 setTitle:selectedGlucose2 forState:UIControlStateNormal];
    strGlucoseValue2=selectedGlucose2; 
    
}

    
-(void)cancel
{
    [objAudio stop];
    [objAudioReading stop];
    
     [self.navigationController popViewControllerAnimated:YES];
    
}
   
 
-(void)showBGmessage
{
    
    UIAlertView * alertForWeight=[[UIAlertView alloc] initWithTitle:@"Measure Glucose" message:@"Please measure your Hemoglobin..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    [alertForWeight show];
    alertForWeight.tag=3;
    [alertForWeight release];
    
  
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag==168)
    {
        
        
            if(buttonIndex==0)// done
        {
            
            // play audio to mesure weight
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"EnterGlucoseReading"];
            [myAudioPlayer playAudios:array];
            [array release];
            
        }
        else if(buttonIndex==1)// skip
            
        {
            [self checkFlag];

        }
        }
    else if(alertView.tag==111)
    {
        
        
        if(buttonIndex==0)// ok
        {
            
            [self checkFlag];
            [self.glucosedelegate glucosedoneFlag];
            [self saveGlucoseInformation];
        }
        else
        {
            
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


- (IBAction)selectGlucoseReading:(id)sender 
{
   [self doneTagSelection:nil];
    [self doneDateTimeSelection:nil];
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.GlucosePickerBackView.center;
    
    // set new cordinate
    point.y=322;
    
    //assigne new cordinate
    self.GlucosePickerBackView.center=point;
    
    [UIView commitAnimations];
    

}
- (IBAction)TouchGlucoseDone:(id)sender 
{ 
    if(strGlucoseValue==nil&&strGlucoseValue1==nil&&strGlucoseValue2==nil)   
  {
    [objAudio stop];
    [objAudioReading stop];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Empty Reading" message:@"Please enter your Glucose Reading" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
    
    NSString *path=[[NSBundle mainBundle]pathForResource:@"pleaseenter" ofType:@"aiff"];
    AVAudioPlayer *obj_Audio=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [obj_Audio play];
      
    [UIView beginAnimations:@"SendPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
      
    // declate a cgpoint variable
    CGPoint point;
      
    //get the old cordinate
    point=self.GlucosePickerBackView.center;
      
    // set new cordinate
    point.y=586;
      
    //assigne new cordinate
    self.GlucosePickerBackView.center=point;
      
    [UIView commitAnimations];

    
}
    else
    {
      selectReadingDone.hidden=NO;
    
      UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thanks.." message:@"Enter your reading successfully"delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
      [alertReading show];
      alertReading.tag=20;
      [alertReading release];
    
   // NSString *path=[[NSBundle mainBundle]pathForResource:@"EnterSuccess" ofType:@"aiff"];
    //AVAudioPlayer *obj_Audio=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    //[obj_Audio play];
    
    [UIView beginAnimations:@"SendPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declate a cgpoint variable
     CGPoint point;
    
    //get the old cordinate
     point=self.GlucosePickerBackView.center;
    
    // set new cordinate
     point.y=586;
    
    //assigne new cordinate
     self.GlucosePickerBackView.center=point;
    
     [UIView commitAnimations];
  }
    

}
- (IBAction)selectBtnGlucose1:(id)sender 
{
   // GlucosePicker.hidden=NO;
    [self doneTagSelection:nil];
    [self doneDateTimeSelection:nil];
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declare a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.GlucosePickerBackView.center;
    
    // set new cordinate
    point.y=322;
    
    //assigne new cordinate
    self.GlucosePickerBackView.center=point;
    
    [UIView commitAnimations];
    
    
}

- (IBAction)selectBtnGlucose2:(id)sender 
{
   // GlucosePicker.hidden=NO;
    [self doneTagSelection:nil];
    [self doneDateTimeSelection:nil];
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.GlucosePickerBackView.center;
    
    // set new cordinate
    point.y=322;
    
    //assigne new cordinate
    self.GlucosePickerBackView.center=point;
    
    [UIView commitAnimations];
    
}

- (IBAction)selectBtnGlucose3:(id)sender 
{
   // GlucosePicker.hidden=NO;
   //  btnGlucose3.hidden=YES;
       btnSkip.hidden=YES;

    [self doneTagSelection:nil];
    [self doneDateTimeSelection:nil];
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.GlucosePickerBackView.center;
    
    // set new cordinate
    point.y=375;
    
    //assigne new cordinate
    self.GlucosePickerBackView.center=point;
    GlucosePicker.frame=CGRectMake(0, 0,320, 90);
    [UIView commitAnimations];
    
}





-(IBAction)skipPressed:(id)sender
{
    [self.glucosedelegate glucoseskipFlag];
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
        [audioPlayer playAudios:array];
        [array release];
    }

}


-(IBAction)DonePicker
{
    
    NSLog(@"\n\n component1 value    %d\n\n",componentOneValue);
    NSLog(@" component1 value    %d\n\n",componentTwoValue);
    NSLog(@" component1 value    %d\n\n",componentThreeValue);

    if(componentOneValue+componentTwoValue+componentThreeValue==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Empty Reading" message:@"Please enter your glucose Reading" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];  
        
        // play audio to mesure weight
        NSMutableArray * array=[[NSMutableArray alloc] init];
        [array addObject:@"EnterGlucoseReading"];
        [myAudioPlayer playAudios:array];
        [array release];
        
    }
    else
    {
        [self doneGlucoseEntering ];
        
         if(![aUser.memberId isEqualToString:@""])
         {
        UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:[NSString stringWithFormat:@"Your blood glucose of %d%d%d mg/dl has been entered successfully.",componentOneValue,componentTwoValue,componentThreeValue] delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:@"Cancel", nil];
        [alertReading show];
        alertReading.tag=111;
        [alertReading release]; 
         }
         else
         {
             UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"MemberId Not Found!" message:[NSString stringWithFormat:@"Your blood glucose of %d%d%d mg/dl has been stored successfully on local Database.",componentOneValue,componentTwoValue,componentThreeValue] delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:@"Cancel", nil];
             [alertReading show];
             alertReading.tag=111;
             [alertReading release];  
         }
      

       [self playAudio:componentOneValue :componentTwoValue :componentThreeValue];
    }
    
}   

-(void)setweightFromComponent1:(int)value1 Component2:(int)value2 Component3:(int)value3
{
    //  NSString *totalWight=[NSString stringWithFormat:@"%d%d%d",value1,value2,value3];
    NSString *totalGlucose= [[NSString alloc]initWithFormat:@"%d%d%d",value1,value2,value3 ];
// [[[NSString alloc ]  iniWithFormat:@"%d%d%d",value1,value2,value3] ];
    lblTotalGlucose.text=totalGlucose;
    
}




-(void)mesuringBloodPressureDidCancel
{
    
    [self dismissModalViewControllerAnimated:YES];
    
    
}
-(void)mesuringBloodPressureDidComplete
{
    //[self.navigationController popViewControllerAnimated:YES]; 

    [self dismissModalViewControllerAnimated:YES];
    
}






-(void)checkFlag
{
    
     
  
    NSString *str3= [arrayFlags objectAtIndex:3];
    NSString *str4= [arrayFlags objectAtIndex:4];
    NSString *str5=[arrayFlags objectAtIndex:5];
    NSString *str6=[arrayFlags objectAtIndex:6];

     if([str3 isEqualToString:@"YES"])   
        
    {
        
        classMesureBPNew *obj_BP=[[classMesureBPNew alloc]initWithNibName:@"classMesureBPNew" bundle:nil];
         obj_BP.myAudioPlayer=myAudioPlayer;
        obj_BP.tabBarItem.title=@"BP";
        obj_BP.aUser=aUser;
        obj_BP.arrayFlags=arrayFlags;
        [self.navigationController pushViewController:obj_BP animated:YES];                
        [obj_BP release];
        
        
        //arrayofControllers=[[NSMutableArray alloc]initWithObjects:navC,nil];
        
        
        
        
        
    }  
    else  if([str4 isEqualToString:@"YES"])    
        
    {
        [myAudioPlayer stopAudio];

        
        
        classHimoglobin *obj_himoglobin=[[classHimoglobin alloc]initWithNibName:@"classHimoglobin" bundle:nil];
        //navC=[[UINavigationController alloc]initWithRootViewController:obj_himoglobin];
        // obj_himoglobin.delegate=self;
        obj_himoglobin.myAudioPlayer=self.myAudioPlayer;
        obj_himoglobin.tabBarItem.title=@"Add";
        obj_himoglobin.aUser=aUser;
         obj_himoglobin.arrayFlags=arrayFlags;
        [self.navigationController pushViewController:obj_himoglobin animated:YES];
        //[self presentModalViewController:navC1 animated:YES];
        [obj_himoglobin release];
        
        //arrayofControllers=[[NSMutableArray alloc]initWithObjects:navC,nil];
        
        
        
        
        
    }
    else if([str5 isEqualToString:@"YES"])
    {
        
        classGlycoHemoglobin *obj_glyco=[[classGlycoHemoglobin alloc]initWithNibName:@"classGlycoHemoglobin" bundle:nil];
        //navC=[[UINavigationController alloc]initWithRootViewController:obj_glyco];
        // obj_glyco.delegate=self;
        obj_glyco.myAudioPlayer=self.myAudioPlayer;
        obj_glyco.aUser=aUser;
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
    else {
        classHome *classHomeObj=[[classHome alloc]initWithNibName:@"classHome" bundle:nil];
        NSLog(@"Glucose %d",classHomeObj.glucoseBool);



        if (classHomeObj.glucoseBool==FALSE) {
            
            [self.navigationController popToRootViewControllerAnimated:NO ];
            
        }
        else if (classHomeObj.counter==5){
            
        UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:@"All readings entered successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertReading show];
        alertReading.tag=116;
        [alertReading release]; 
        
        // play audio to all reading entered
        NSMutableArray * array=[[NSMutableArray alloc] init];
        [array addObject:@"allReadingEntered"];
        [myAudioPlayer playAudios:array];
        }
    }
    
    
    
}
-(IBAction)Cancle
{
    [self.navigationController popViewControllerAnimated:YES];
    
}





-(void)playAudio:(int )component1:(int )component2:(int )component3

{
    
    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    language=[userDefaults objectForKey:[NSString stringWithFormat:@"languageselected%d",self.aUser.userId]];
    audiosatus=[userDefaults objectForKey:[NSString stringWithFormat:@"audioStatus%d",aUser.userId]];
    
    if ([audiosatus isEqualToString: @"on"]) {
        if([language isEqualToString:@"1"])
        {
            [array addObject:@"bgOf"];
            
            
            
            if(component1==0)
            {
                if(component2==1 && component3>0 )
                {
                    
                    [array addObject:[arrayOfNumberInText1 objectAtIndex:component3] ];
                    [array addObject:@"mgPerDlHasBeenEntered"];
                    NSLog(@"component2==1 && component3>0 %@",array);
                    [myAudioPlayer playAudios:array];
                }
                
                
                if(component2>1 && component3>0 )
                {
                    
                    [array addObject:[arrayOfNumberInText2 objectAtIndex:component2]];
                    [array addObject:[arrayOfNumberInText objectAtIndex:component3]];
                    
                    NSLog(@"component2>1 && component3>0 %@",array);
                    [array addObject:@"mgPerDlHasBeenEntered"];
                    
                    [myAudioPlayer playAudios:array];
                    
                    
                    
                    
                }
                
                
                
                
                
                
                if(component2 >=1 && component3==0)
                {
                    [array addObject:[arrayOfNumberInText2 objectAtIndex:component2] ];
                    //[array addObject:[arrayOfNumberInText objectAtIndex:component3]];
                    //[array addObject:[arrayOfNumberInText objectAtIndex:componentThreeValue]];
                    
                    // [array addObject:@"kg"];
                    
                    //  [array addObject:@"BPhasBeenEntered"];
                    NSLog(@"component2>=1 && component3=0 %@",array);
                    
                    [array addObject:@"mgPerDlHasBeenEntered"];
                    
                    [myAudioPlayer playAudios:array];
                    
                    
                    
                    
                }
                
                
                
                
                
            }
            
            else if(component1==0 && component2==0)
            {
                
                [array addObject:[arrayOfNumberInText objectAtIndex:component3] ];
                //  [array addObject:[arrayOfNumberInText objectAtIndex:componentTwoValue]];
                // [array addObject:[arrayOfNumberInText objectAtIndex:componentThreeValue]];
                
                // [array addObject:@"kg"];
                
                // [array addObject:@"BPhasBeenEntered"];
                NSLog(@"component2>=1 && component3=0 %@",array);
                
                [array addObject:@"mgPerDlHasBeenEntered"];
                
                [myAudioPlayer playAudios:array];
                
                
                [array release];
                
                
                
                
                
            }
            else
            {
                
                
                [array addObject:[arrayofHundredNumberInText objectAtIndex:component1] ];
                if (component2==1) {
                    if (component3==0) {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:component2]];
                        
                    }
                    else
                    {
                        [array addObject:[arrayOfNumberInText1 objectAtIndex:component3]];
                    }
                }
                else if (component2==0) {
                    if (component3>1) {
                        [array addObject:[arrayOfNumberInText objectAtIndex:component3]];
                        
                    }
                }
                
                else if (component2>1) {
                    
                    if (component3>0) {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:component2]];
                        [array addObject:[arrayOfNumberInText objectAtIndex:component3]];
                        
                    }
                    if (component3==0) {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:component2]];
                        
                    }
                }
                [array addObject:@"mgPerDlHasBeenEntered"];
            }
        }
        else if([language isEqualToString:@"2"])
        {
            [array addObject:@"13"];
            NSArray *numberArray=[[NSArray alloc] init];
            numberArray=[classCommanFunctions marathiAudioMethod:component1 :component2 :component3];
            NSLog(@"Number Array %@",numberArray);
            for (int i=0; i<[numberArray count]; i++) {
                [array addObject:[numberArray objectAtIndex:i]];
            }
           
             [array addObject:@"14"];
                
        }
        [myAudioPlayer playAudios:array];
        [array release];
    }
}





@end
