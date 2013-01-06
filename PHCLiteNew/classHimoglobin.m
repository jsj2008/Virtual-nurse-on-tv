//
//  classHimoglobin.m
//  PHCLite
//
//  Created by Avi Kulkarni on 18/08/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classHimoglobin.h"

#import "classMesureBPNew.h"
#import "classGlycoHemoglobin.h"
#import "PHCLiteNewAppDelegate.h"
#import "remindMed.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "classUser.h"
#import "commanFunctions.h"
#import "classHome.h"

NSMutableArray * arrayOfNumberInText;


@implementation classHimoglobin
@synthesize btnEnter;
@synthesize hbPickerBackView;
@synthesize btnHimoglobin1;
@synthesize btnHimoglobin2;
@synthesize DateTimeBackView;
@synthesize DatePickerTime;
@synthesize TotalHGValue;
@synthesize Picker_HB;
@synthesize pickerBackSide;
@synthesize btnTag;
@synthesize lblHG;
@synthesize btnDateTime;
@synthesize btnHimoglobin;
@synthesize currentDate;
@synthesize arrayHB1,arrayHB2,arrayHB3;
@synthesize delegate;
@synthesize myAudioPlayer;
@synthesize lblTotalHimoglobin;
@synthesize  arrayFlags;
@synthesize aUser;
@synthesize btnTake;
@synthesize skip;
@synthesize hemoglobindelegate;
int i,j,k;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        arrayHB1=[[NSMutableArray alloc]init];
        
        for (i=0; i<=9; i++)
        {
            [arrayHB1 addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        
        arrayHB2=[[NSMutableArray alloc]init];
        for (j=0; j<=9; j++)
        {
            [arrayHB2 addObject:[NSString stringWithFormat:@"%d",j]];
            
        }
        arrayHB3=[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
      
        
    }
    return self;
}

- (void)dealloc
{
    [btnHimoglobin release];
    [lblHG release];
    [btnDateTime release];
    [btnTag release];
    [pickerBackSide release];
    [Picker_HB release];
    [DateTimeBackView release];
    [DatePickerTime release];
    [btnHimoglobin1 release];
    [btnHimoglobin2 release];
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
    self.title=@"Heamoglobin";
    
    
    self.navigationController.tabBarItem.title=@"Tracker";
    UIBarButtonItem *barCancle=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(Cancle)];
    self.navigationItem.leftBarButtonItem=barCancle;  
    barBtnDone=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(DonePicker)];
    self.navigationItem.rightBarButtonItem=barBtnDone;
    [barCancle  release];
        [self setDateTime:[NSDate date]];
    Picker_HB.delegate=self;
    Picker_HB.dataSource=self;
    [Picker_HB selectRow:0 inComponent:0 animated:YES];
    [Picker_HB selectRow:1 inComponent:1 animated:YES];
    [Picker_HB selectRow:4 inComponent:2 animated:YES];
    lblTotalHimoglobin.text=[NSString stringWithFormat:@"%d",014];
    
    // reset
   componentOneValue=0;
   componentTwoValue=1;
   componentThreeValue=4;
    
    //-----------------------------------
    [self setHimoglobinFromComponent1:componentOneValue Component2:componentTwoValue Component3:componentThreeValue];
  //  [self showMesureHimoglobinAlert];
    
    arrayOfNumberInText=[[NSMutableArray alloc] initWithObjects:@"zero",@"one",@"two",@"three",@"four",@"five",@"six",@"seven",@"eight",@"nine", nil];
    arrayofHundredNumberInText=[[NSMutableArray alloc]initWithObjects:@"zero",@"onehundred",@"twohundred",@"threehundred",@"fourhundred",@"fivehundred",@"sixhundred",@"sevenhundred",@"eighthundred",@"ninehundered", nil];
    
    arrayOfNumberInText1=[[NSMutableArray alloc] initWithObjects:@"zero",@"eleven",@"twelve",@"thirteen",@"fourteen",@"fifteen",@"sixteen",@"seventeen",@"eighteen",@"ninteen", nil];
    arrayOfNumberInText2=[[NSMutableArray alloc] initWithObjects:@"zero",@"ten",@"twenty",@"thiry",@"forty",@"fifty",@"sixty",@"seventy",@"eighty",@"ninety", nil];

    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    language=[userDefaults objectForKey:[NSString stringWithFormat:@"languageselected%d",self.aUser.userId]];
    audiosatus=[userDefaults objectForKey:[NSString stringWithFormat:@"audioStatus%d",aUser.userId]];
    
    if ([audiosatus isEqualToString: @"on"]) {
        if([language isEqualToString:@"1"])
        {
            [array addObject:@"measusreHeamoglobinReadingAndTapDone"];
         
        }
        else if([language isEqualToString:@"2"])
        {
            [array addObject:@"18"];
            
        }
        [myAudioPlayer playAudios:array];
    }
    [array release];

}


-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    NSString *strImg1=@"backImage1.png";
    NSString *strImg=[classDatabaseOperations getNurseImg:aUser.userId];
    NSLog(@"%@image",strImg);
    if ([strImg isEqualToString:@"null"])
    {
        nurseImgeView.image=[UIImage imageNamed:strImg1];
    }
    else{
        NSLog(@"Nurse is %@",strImg);
        nurseImgeView.image=[UIImage imageNamed:strImg];
    }

    
    
}


- (void)viewDidUnload
{
    [self setBtnHimoglobin:nil];
    [self setLblHG:nil];
    [self setBtnDateTime:nil];
    [self setBtnTag:nil];
    [self setPickerBackSide:nil];
    [self setPicker_HB:nil];
    [self setDateTimeBackView:nil];
    [self setDatePickerTime:nil];
    [self setBtnHimoglobin1:nil];
    [self setBtnHimoglobin2:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)setDateTime:(NSDate *)selectedDate
{
    
    //self.myGlucose.date =selectedDate;
    
    // set the selected dat to btn's title
    NSDateFormatter * formatter=[[[NSDateFormatter alloc] init]autorelease];
    [formatter setDateFormat:@"EE, MMMM dd,yyyy,h:mm a"];
    [self.btnDateTime setTitle:[formatter stringFromDate:selectedDate] forState:UIControlStateNormal];
    
    NSLog(@"%@",[formatter stringFromDate:selectedDate]);
    
}
-(IBAction)saveHGInformation
{
   // NSString * memberId=[(PHCLiteNewAppDelegate *) [[UIApplication sharedApplication]delegate]memberId];
    
    TotalHGValue=[NSString stringWithFormat:@"%d%d%d",componentOneValue,componentTwoValue,componentThreeValue];
    
    
    NSString *memberId =aUser.memberId;
   int userid=aUser.userId;
    
    
    NSLog(@"member id is %@",memberId);
    NSLog(@"userid is %d",userid);
    // NSString *currentDate=self.btndateTime.titleLabel.text;    //get current date
    NSDate *picker_date= [NSDate date];
    NSDateFormatter *dateformator=[[[NSDateFormatter alloc]init]autorelease];
    [dateformator setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSString *Date=[dateformator stringFromDate:picker_date];
    [dateformator setDateFormat:@" HH:mm:ss"];
    NSString *currentTime=[dateformator stringFromDate:picker_date];
    NSLog(@"today is.......%@\n",Date); //show Date MM/dd/yyyy HH:mm:ss format.
    NSLog(@"today is.......%@\n",currentTime);
    
    NSString *query=[NSString stringWithFormat:@"insert into healthydata (userid,memberid,date,time,type,unit,value1)values(%d,'%@','%@','%@','HG','g/dl','%@')",aUser.userId,aUser.memberId,Date,currentTime, TotalHGValue ];
    NSLog(@"\n\n\n\nqueryis...%@",query);
    [classDatabaseOperations addData:query];
      if(![memberId isEqualToString:@""])
     {
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
                        "</soap:Envelope>",memberId,@"HG",@"SPB502",@"NVX9686BT",@"B",@"",@"",@"",@"",@"iPhone",@"Web",@"",self.TotalHGValue,@"",@"",Date];
    
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
}
-(void)connectionDidFailWithError
{



}
-(void)resultAfterParsing:(NSMutableArray *)soapResult
{
    
    NSLog(@"%@",soapResult);
    
}

- (IBAction)selectHB1:(id)sender 
{
    Picker_HB.hidden=NO;
    [self TouchDoneDateTime:nil];
}

- (IBAction)selectHB2:(id)sender 
{
    
    Picker_HB.hidden=NO;
    [self TouchDoneDateTime:nil];
}


-(void)setHG:(NSString *)selectedHG
{
    
    //self.my_weight.weightReading=[NSString stringWithFormat:@"%@", selectedWeight];
    // [self.btnWeightReading setTitle:selectedWeight forState:UIControlStateNormal];
    [self.btnHimoglobin setTitle:selectedHG forState:UIControlStateNormal];
    
    str_HG =selectedHG;
    
}
-(void)setHG1:(NSString *)selectedHG1
{
    
    //self.my_weight.weightReading=[NSString stringWithFormat:@"%@", selectedWeight];
    // [self.btnWeightReading setTitle:selectedWeight forState:UIControlStateNormal];
    
    [self.btnHimoglobin1 setTitle:selectedHG1 forState:UIControlStateNormal];
    
    str_HG1=selectedHG1;
    
}
-(void)setHG2:(NSString *)selectedHG2
{
    
    //self.my_weight.weightReading=[NSString stringWithFormat:@"%@", selectedWeight];
    // [self.btnWeightReading setTitle:selectedWeight forState:UIControlStateNormal];
    
    [self.btnHimoglobin2 setTitle:selectedHG2 forState:UIControlStateNormal];
    
    str_HG2=selectedHG2; 
    
}

- (IBAction)selectHimoglobinBtn:(id)sender 
{
    Picker_HB.hidden=NO;
    [self TouchDoneDateTime:nil];
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.pickerBackSide.center;
    
    // set new cordinate
    point.y=332;
    
    //assigne new cordinate
    self.pickerBackSide.center=point;
    
    [UIView commitAnimations];
}
- (IBAction)selectDateTime:(id)sender 
{
    Picker_HB.hidden=YES;
   
    [UIView beginAnimations:@"sendPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.DateTimeBackView.center;
    
    // set new cordinate
    point.y=332;
    
    //assigne new cordinate
    self.DateTimeBackView.center=point;
    [UIView commitAnimations]; 
    
    
}
- (IBAction)TouchDoneDateTime:(id)sender 
{
    
    [UIView beginAnimations:@"sendPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.DateTimeBackView.center;
    
    // set new cordinate
    point.y=586;
    
    //assigne new cordinate
    self.DateTimeBackView.center=point;
    
    [UIView commitAnimations];
    
    [self setDateTime:[self.DatePickerTime date]];
    
    
}





- (IBAction)selectBtnEnter:(id)sender 
{
    // GlucosePicker.hidden=NO;
    btnEnter.hidden=YES;
    skip.hidden=YES;

    [self TouchDoneDateTime:nil];
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.hbPickerBackView.center;
    
    // set new cordinate
    point.y=365;
    
    //assigne new cordinate
    self.hbPickerBackView.center=point;
     Picker_HB.frame=CGRectMake(0,15,320, 80);
    [UIView commitAnimations];
    
}

- (void)doneHBEntering
{
    //[txtGlucoseReading resignFirstResponder];
    
    
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.28];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.hbPickerBackView.center;
    
    // set new cordinate
    point.y=586;
    
    //assigne new cordinate
    self.hbPickerBackView.center=point;
    
    
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


    [self.hemoglobindelegate hemoglobinskipFlag];
}




- (IBAction)selectTag:(id)sender {
}
// PickerView Methods....
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 3;
    
}







-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0)
    {
        return  [arrayHB1 count]; 
        
    }
    if(component==1)
    {
        return  [arrayHB2 count]; 
        
    }
    if(component==2)
    {
        return  [arrayHB3 count]; 
        
    }
    
    return 0;
    
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0)
    {
        return [arrayHB1 objectAtIndex:row];
        
    }
    if(component==1)
    {
        return [arrayHB2 objectAtIndex:row];
        
    }
    if(component==2)
    {
        return [arrayHB3 objectAtIndex:row];
        
    }
    
    return @"abc";
    
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    

    NSMutableArray * array;
  
    
    if(component==0)
    {
        
        componentOneValue=[[arrayHB1 objectAtIndex:row] intValue];
        if ([audiosatus isEqualToString: @"on"]) {
            if([language isEqualToString:@"1"])
            {
                // create array
                array=[[NSMutableArray alloc] init];
                
                // add audio file for value of component two
                [array addObject:[arrayOfNumberInText objectAtIndex:componentOneValue]];
                [myAudioPlayer playAudios:array];
                [array release];
                
            }
        }

       
        

    }
    else
        if(component==1)
        {
            
            componentTwoValue=[[arrayHB2 objectAtIndex:row] intValue];
            if ([audiosatus isEqualToString: @"on"]) {
                if([language isEqualToString:@"1"])
                {
                    array=[[NSMutableArray alloc] init];
                    
                    // add audio file for value of component two
                    [array addObject:[arrayOfNumberInText objectAtIndex:componentTwoValue]];
                    [myAudioPlayer playAudios:array];
                    [array release];
                    
                }
            }
        }
        else
            if(component==2)
            {
                
                componentThreeValue=[[arrayHB3 objectAtIndex:row] intValue];
                if ([audiosatus isEqualToString: @"on"]) {
                    if([language isEqualToString:@"1"])
                    {
                        array=[[NSMutableArray alloc] init];
                        
                        // add audio file for value of component two
                        [array addObject:[arrayOfNumberInText objectAtIndex:componentThreeValue]];
                        [myAudioPlayer playAudios:array];
                        [array release];
                        
                        
                    }
                }

                

                
                
            }
    
    componentOneValue=[pickerView selectedRowInComponent:0] ;
    componentTwoValue=[pickerView selectedRowInComponent:1];
    componentThreeValue=[pickerView selectedRowInComponent:2];
    
    
    
    [self setHimoglobinFromComponent1:componentOneValue Component2:componentTwoValue Component3:componentThreeValue];
    
    
    

    
    
    
}

-(IBAction)Cancle
{
    //[self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];

}
-(IBAction)DonePicker
{
    
    
    if(componentOneValue+componentTwoValue+componentThreeValue==0)
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Empty Reading" message:@"Please enter your hemoglobin Reading" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];  
        
        // play audio to mesure weight
        NSMutableArray * array=[[NSMutableArray alloc] init];
        [array addObject:@"EnterHimoGReading"];
        [myAudioPlayer playAudios:array];
        [array release];
    }
    else
    {
        [self doneHBEntering];
        [self saveHGInformation];
        
        if(![aUser.memberId isEqualToString:@""])
        {

        UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:[NSString stringWithFormat:@"Your hemoglobin reading of %d%d%d gm/dl has been entered successfully.",componentOneValue,componentTwoValue,componentThreeValue] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alertReading show];
        alertReading.tag=111;
        [alertReading release]; 
        }
        else
        {
            UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"MemberId Not Found!" message:[NSString stringWithFormat:@"Your hemoglobin reading of %d%d%d gm/dl has been stored successfully on local Database.",componentOneValue,componentTwoValue,componentThreeValue] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
            [alertReading show];
            alertReading.tag=111;
            [alertReading release]; 

        }
        
        // play audio to mesure weight
        NSMutableArray * array=[[NSMutableArray alloc] init];

        if ([audiosatus isEqualToString: @"on"]) {
            if([language isEqualToString:@"1"])
            {
                [array addObject:@"yourHeamoglobinReadingOf"];
                
                if(componentOneValue!=0)
                {
                    // add audio file for value of component two
                    [array addObject:[arrayofHundredNumberInText objectAtIndex:componentOneValue]];
                    if (componentTwoValue==0 && componentThreeValue>0) {
                        [array addObject:[arrayOfNumberInText objectAtIndex:componentThreeValue]];
                        
                    }
                    
                    
                    
                }
                if (componentTwoValue>0) {
                    if (componentTwoValue==1) {
                        if (componentThreeValue>0) {
                            [array addObject:[arrayOfNumberInText1 objectAtIndex:componentThreeValue]];
                        }
                        if (componentThreeValue==0) {
                            [array addObject:[arrayOfNumberInText2 objectAtIndex:componentTwoValue]];
                            
                        }
                    }
                    else
                    {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:componentTwoValue]];
                        //                if (componentThreeValue>0) {
                        //                    [array addObject:[arrayOfNumberInText objectAtIndex:componentThreeValue]];
                        //
                        //                }
                    }
                    
                }
                if (componentOneValue==0 && componentTwoValue==0 && componentThreeValue>=0) {
                    [array addObject:[arrayOfNumberInText objectAtIndex:componentThreeValue]];
                    
                }
                if (componentTwoValue>1 && componentThreeValue>0) {
                    [array addObject:[arrayOfNumberInText objectAtIndex:componentThreeValue]];
                    
                }
                
                [array addObject:@"gmsPerDlHasBeenEntered"];
                NSLog(@"Array %@",array);
                [myAudioPlayer playAudios:array];
                
            }
            else if([language isEqualToString:@"2"])
            {
                [array addObject:@"19"];
                
                NSArray *numberArray=[[[NSArray alloc] init]autorelease];
                numberArray=[classCommanFunctions marathiAudioMethod:componentOneValue :componentTwoValue :componentThreeValue];
                NSLog(@"Number Array %@",numberArray);
                for (int i=0; i<[numberArray count]; i++) {
                    [array addObject:[numberArray objectAtIndex:i]];
                }
                [array addObject:@"20.1"];
                [myAudioPlayer playAudios:array];
                
            }
           
        }

    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   if(alertView.tag==168)
    {
        
        
       if(buttonIndex==0)
       {
           // play audio
           
           // play audio to mesure weight
           NSMutableArray * array=[[NSMutableArray alloc] init];
           [array addObject:@"EnterHimoGReading"];
           [myAudioPlayer playAudios:array];
           [array release];

           
           
       }
      else if(buttonIndex==1)
        {
            
            [self checkFlag];
           
        }
        else
        {
                  }
        
    }
    else if (alertView.tag==111)
    {
        
        
        if(buttonIndex==0)
        {
            [self checkFlag];
            [self.hemoglobindelegate hemoglobinDoneFlag];
        }
        else
        {
            
        }
        
    }
    else if(alertView.tag==116)
    {
        
        if (buttonIndex==0)
        {
                  [self.navigationController popToRootViewControllerAnimated:NO ];
                       
        }
    }
 
}


-(void)showMesureHimoglobinAlert
{
    
    UIAlertView * alertForWeight=[[UIAlertView alloc] initWithTitle:@"Measure Hemoglobin" message:@"Please measure your hemoglobin..." delegate:self cancelButtonTitle:@"Done" otherButtonTitles:@"skip", nil];
    [alertForWeight show];
    alertForWeight.tag=168;
    [alertForWeight release];
    
    // play audio to mesure weight      
    NSMutableArray *array=[[NSMutableArray alloc]init];    
    [array addObject:@"measusreHeamoglobinReadingAndTapDone"];
    [myAudioPlayer playAudios:array];
    [array release];
    
}
-(void)setHimoglobinFromComponent1:(int)value1 Component2:(int)value2 Component3:(int)value3
{
    NSString *totalWight=[NSString stringWithFormat:@"%d%d%d",value1,value2,value3];
    
    lblTotalHimoglobin.text=totalWight;
    
}
-(void)mesuringHimoblobinDidComplete
{


}
-(void)mesuringHimoblobinDidCancel
{


}
-(void)mesuringBloodPressureDidComplete
{



}
-(void)mesuringBloodPressureDidCancel
{


}





-(void)checkFlag
{
    
        [myAudioPlayer stopAudio];

    
    
      NSString *str5= [arrayFlags objectAtIndex:5];
  NSString *str6= [arrayFlags objectAtIndex:6];
    if([str5 isEqualToString:@"YES"])
    {
        
        classGlycoHemoglobin *obj_glyco=[[classGlycoHemoglobin alloc]initWithNibName:@"classGlycoHemoglobin" bundle:nil];
        //navC=[[UINavigationController alloc]initWithRootViewController:obj_glyco];
        // obj_glyco.delegate=self;
        obj_glyco.myAudioPlayer=myAudioPlayer;
        obj_glyco.arrayFlags=arrayFlags;
        obj_glyco.tabBarItem.title=@"Add";
        obj_glyco.aUser=aUser;
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
        
    
   else
       
    {
        classHome *classHomeObj=[[classHome alloc]initWithNibName:@"classHome" bundle:nil];

        NSLog(@"Class Home Obj %d",classHomeObj.counter);

        if (classHomeObj.hemoBool==FALSE) {
            
            [self.navigationController popToRootViewControllerAnimated:NO ];
            
        }
        else if (classHomeObj.counter==5){
        UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:@"All readings entered successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertReading show];
        alertReading.tag=116;
        [alertReading release]; 
        }
//        if (classHomeObj.counter==5) {
//            UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:@"All readings entered successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alertReading show];
//            alertReading.tag=116;
//            [alertReading release];
//            
//            // play audio to all reading entered
//            NSMutableArray * array=[[NSMutableArray alloc] init];
//            [array addObject:@"allReadingEntered"];
//            [myAudioPlayer playAudios:array];
//        }

        
    }
    
    
}





@end
