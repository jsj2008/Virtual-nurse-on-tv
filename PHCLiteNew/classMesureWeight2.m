//
//  classMesureWeight2.m
//  PHCLiteNew
//
//  Created by Avi Kulkarni on 23/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classMesureWeight2.h"
#import "classMesureGlucose1.h"
#import "classAudio.h"
#import "classMesureGlucose1.h"
#import "classMesureBPNew.h"
#import "classGlycoHemoglobin.h"
#import "classHimoglobin.h"
#import "remindMed.h"
#import "commanFunctions.h"
#import "classHome.h"
@implementation classMesureWeight2
@synthesize lblWeight;
@synthesize PickerWeight;
@synthesize lblTotalWeight;
@synthesize btndateTime;
@synthesize arrayNumber,arrayNumber1,arrayNumber2;
@synthesize AllTotalWeightValue;
@synthesize arrayOfNumberInText;
@synthesize arrayOfNumberInText1;
@synthesize arrayOfNumberInText2;
@synthesize arrayFlags;
@synthesize  aUser;
@synthesize hbPickerBackView;
@synthesize audioPlayer ;
@synthesize delegate;
NSMutableArray * arrayOfNumberInText;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        arrayNumber=[[NSMutableArray alloc]initWithObjects:@"0" ,@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
        arrayNumber1=[[NSMutableArray alloc]initWithObjects:@"0" ,@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
        arrayNumber2=[[NSMutableArray alloc]initWithObjects:@"0" ,@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];


        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [lblTotalWeight release];
    [btndateTime release];
    [lblWeight release];
    [PickerWeight release];
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
    
    self.navigationController.navigationBar.hidden=YES;
    //self.title=@"Weight";
    
   self.navigationController.tabBarItem.title=@"Tracker";
//    UIBarButtonItem *barCancle=[[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(Cancle) ]autorelease];
//    self.navigationItem.leftBarButtonItem=barCancle;  
    lblTotalWeight.text=@"50";
   // self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
  
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"weight.jpg"]];
    
   
     
    PickerWeight.frame=CGRectMake(0, 44,320, 80);
    
    [PickerWeight selectRow:0 inComponent:0 animated:YES];
    [PickerWeight selectRow:5 inComponent:1 animated:YES];
    [PickerWeight selectRow:0 inComponent:2 animated:YES];
    //--------------------------------------------***Navigation Bar Content***-------------------------------------------------------------------------------------------------
    
    self.navigationItem.leftBarButtonItem.width= 0;
//    UIBarButtonItem *barSave=[[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(DonePicker)]autorelease];
//    self.navigationItem.rightBarButtonItem = barSave;
   
    
  //------------------------------------Initiating Number array with audio file name------------------------------------------------------------------- 
    
    
    arrayOfNumberInText=[[NSMutableArray alloc] initWithObjects:@"zero",@"one",@"two",@"three",@"four",@"five1",@"six",@"seven",@"eight",@"nine", nil];
    arrayofHundredNumberInText=[[NSMutableArray alloc]initWithObjects:@"zero",@"onehundred",@"twohundred",@"threehundred",@"fourhundred",@"fivehundred",@"sixhundred",@"sevenhundred",@"eighthundred",@"ninehundered", nil];

    arrayOfNumberInText1=[[NSMutableArray alloc] initWithObjects:@"zero",@"eleven",@"twelve",@"thirteen",@"fourteen",@"fifteen",@"sixteen",@"seventeen",@"eighteen",@"ninteen", nil];
    arrayOfNumberInText2=[[NSMutableArray alloc] initWithObjects:@"zero",@"ten",@"twenty",@"thiry",@"forty",@"fifty",@"sixty",@"seventy",@"eighty",@"ninety", nil];
 //--------------------------------------------------------------------------------------------------------------------------------------------------   
    
  /*  NSMutableArray * array=[[NSMutableArray alloc] init];
    [array addObject:@"EnterWeightReading"];
    [self.audioPlayer playAudios:array];
    [array release];*/
      componentOneValue=0;
      componentTwoValue=5;
      componentThreeValue=0;
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    language=[userDefaults objectForKey:[NSString stringWithFormat:@"languageselected%d",self.aUser.userId]];
    audiosatus=[userDefaults objectForKey:[NSString stringWithFormat:@"audioStatus%d",aUser.userId]];
    NSMutableArray * array=[[NSMutableArray alloc] init];

    if ([audiosatus isEqualToString: @"on"]) {
        if([language isEqualToString:@"1"])
        {
            [array addObject:@"PleaseMesureWeight12"];
        }
        else if([language isEqualToString:@"2"])
        {
            [array addObject:@"8.1"];

        }
        [audioPlayer playAudios:array];

    }
     
    [array release];

        
     [self setDateTime:[NSDate date]];

    // Do any additional setup after loading the view from its nib.
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
{    [audioPlayer stopAudio];
    [self setLblTotalWeight:nil];
    [self setBtndateTime:nil];
    [self setLblWeight:nil];
    [self setPickerWeight:nil];
    [self setPickerWeight:nil];
    self.delegate = nil;

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)selectDateTime:(id)sender {
}
-(void)setDateTime:(NSDate *)selectdateTime
{
   // self.my_weight.date=selectdateTime;
    
    NSDateFormatter *formator=[[NSDateFormatter alloc]init];
    [formator setDateFormat:@"EE, MMMM dd,yyyy,h:mm a"];
    
    [self.btndateTime setTitle:[formator stringFromDate:selectdateTime] forState:UIControlStateNormal];
    
    NSLog(@"%@",[formator stringFromDate:selectdateTime]);
    [formator release];
    
}




- (IBAction)selectBtnEnter:(id)sender 
{
    // GlucosePicker.hidden=NO;
    btnEnter.hidden=YES;
    skip.hidden=YES;
    //[self setDateTime:nil];
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    hbPickerBackView.backgroundColor=[UIColor clearColor];
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.hbPickerBackView.center;
    
    // set new cordinate
    point.y=365;
    
    //assigne new cordinate
    self.hbPickerBackView.center=point;
     PickerWeight.frame=CGRectMake(0, 15,320, 80);
   // PickerWeight.bounds=CGRectMake(0, 55,320, 50);
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
           [audioPlayer playAudios:array];
       }
       [array release];

       [delegate weightskipFlag];
   }

-(IBAction)saveWeightInformation
{
    //NSString * memberId=[(PHCLiteNewAppDelegate *) [[UIApplication sharedApplication]delegate]memberId];
    NSString *memberId =aUser.memberId;
    int userid=aUser.userId;
    
    AllTotalWeightValue=[NSString stringWithFormat:@"%d%d%d",componentOneValue,componentTwoValue,componentThreeValue];
    
    NSLog(@"member id is %@",memberId);
    NSLog(@"userid is %d",userid);
   // NSString *currentDate=self.btndateTime.titleLabel.text;    //get current date
   NSDate *picker_date= [[NSDate date]retain];
   NSDateFormatter *dateformator=[[[NSDateFormatter alloc]init]autorelease];
   [dateformator setDateFormat:@"MM/dd/yyyy HH:mm:ss "];
   NSString *currentDate=[dateformator stringFromDate:picker_date];
    [dateformator setDateFormat:@" HH:mm:ss"];
    NSString *currentTime=[dateformator stringFromDate:picker_date];
    NSLog(@"today is.......%@\n",currentDate); //show Date MM/dd/yyyy HH:mm:ss format.
    NSLog(@"today is.......%@\n",currentTime);
    //[picker_date release];
    

    NSString *query=[NSString stringWithFormat:@"insert into healthydata (userid,memberid,date,time,type,unit,value1)values(%d,'%@','%@','%@','WG','Kg','%@')",userid,memberId,currentDate,currentTime,AllTotalWeightValue ];
    NSLog(@"\n\n\n\nqueryis...%@",query);
    [classDatabaseOperations addData:query];
    //   if([self.DatePicker date])
    //   {
    //      NSDate *picker_date= [self.DatePicker date];
    //      NSDateFormatter *dateformator=[[NSDateFormatter alloc]init];
    //      [dateformator setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    //      currentDate=[dateformator stringFromDate:picker_date];
    //      
    //       NSLog(@"%@",currentDate); //show Date MM/dd/yyyy HH:mm:ss format.
    //  }
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
                        "</soap:Envelope>",memberId,@"WT",@"SPB502",@"NVX9686BT",@"B",@"",@"",@"",@"",@"iPhone",@"Web",self.AllTotalWeightValue,@"",@"",@"",currentDate];
    
    NSLog(@"soap msg is..........\n%@",soapMsg);
    
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
//-(void)resultAfterParsing:(NSString *)soapResult
//{
//    
//    NSLog(@"%@",soapResult);
//    
//}
-(void)connectionDidFailWithError
{
    
    
}



// Delegate and datasource PickerView Methods....
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    
    return 3;
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0)
    {
        return  [arrayNumber count]; 
        
    }
    if(component==1)
    {
        return  [arrayNumber1 count]; 
        
    }
    if(component==2)
    {
        return  [arrayNumber2 count]; 
        
    }
    
    
    return 0;
    
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0)
    {
        return [arrayNumber objectAtIndex:row];
        
    }
    if(component==1)
    {
        return [arrayNumber1 objectAtIndex:row];
        
    }
    if(component==2)
    {
        return [arrayNumber2 objectAtIndex:row];
        
    }
    
    return @"abc";
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
        NSMutableArray * array;
    
    if(component==0)
    {
        
        componentOneValue=[[arrayNumber objectAtIndex:row] intValue];
    

        if ([audiosatus isEqualToString: @"on"]) {
            if([language isEqualToString:@"1"])
            {
                // create array
                array=[[NSMutableArray alloc] init];
                
                // add audio file for value of component two
                [array addObject:[arrayOfNumberInText objectAtIndex:componentOneValue]];
                [audioPlayer playAudios:array];
                [array release];
            }
        }
        
      }
    else
        if(component==1)
        {
            
            componentTwoValue=[[arrayNumber1 objectAtIndex:row] intValue];
            if ([audiosatus isEqualToString: @"on"]) {
                if([language isEqualToString:@"1"])
                {
                    // create array
                    array=[[NSMutableArray alloc] init];
                    
                    // add audio file for value of component two
                    [array addObject:[arrayOfNumberInText objectAtIndex:componentTwoValue]];
                    
                    [audioPlayer playAudios:array];
                    [array release];

                }
            }


            // create array
                          }
        else
            if(component==2)
            {
                
                componentThreeValue=[[arrayNumber2 objectAtIndex:row] intValue];
             
                if ([audiosatus isEqualToString: @"on"]) {
                    if([language isEqualToString:@"1"])
                    {
                        // create array
                        array=[[NSMutableArray alloc] init];
                        
                        // add audio file for value of component two
                        [array addObject:[arrayOfNumberInText objectAtIndex:componentThreeValue]];
                        
                        [audioPlayer playAudios:array];
                        [array release];
                        
                    }
                }

                
            }
    
   [self setweightFromComponent1:componentOneValue Component2:componentTwoValue Component3:componentThreeValue];
   
}
-(void)setweightFromComponent1:(int)value1 Component2:(int)value2 Component3:(int)value3
{
      NSString *totalWight=[NSString stringWithFormat:@"%d%d%d",value1,value2,value3];
    
    lblTotalWeight.text=totalWight;
    
}
-(IBAction)DonePicker
{
        
    if(componentOneValue+componentTwoValue+componentThreeValue==0)
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Empty Reading" message:@"Please enter your Weight Reading" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];  
   
    }
    else
    {
       
        
        [self doneHBEntering];      
        
        
        
        if(componentOneValue==0)
        {
            AllTotalWeightValue=[NSString stringWithFormat:@"%d%d",componentTwoValue,componentThreeValue];
        }
        else
        {
           AllTotalWeightValue=[NSString stringWithFormat:@"%d%d%d",componentOneValue,componentTwoValue,componentThreeValue];
        }

        
        if(![aUser.memberId isEqualToString:@""])
        {

        UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:[NSString stringWithFormat:@" Your weight of %@ kg has been entered Successfully",AllTotalWeightValue] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
         //   alertReading.transform = CGAffineTransformMakeTranslation( 0, 100);
            [self.delegate weightdoneFlag];
            
        [alertReading show];
        alertReading.tag=111;
        [alertReading release]; 
        }
        else
        {
            UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"MemberId Not Found!" message:[NSString stringWithFormat:@" Your weight of %@ kg has been Stored Successfully On Local Database",AllTotalWeightValue] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
          //
            [self.delegate weightdoneFlag];

            alertReading.transform = CGAffineTransformMakeTranslation( 0, 0);
            [alertReading show];
            alertReading.tag=111;
            [alertReading release];
        }


        [self playAudio:componentOneValue :componentTwoValue :componentThreeValue];
        
    }
  
}

//--------------------------------------------------------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
       
    if(alertView.tag==168)
    {
        
        
       if(buttonIndex==0)// done
        {
            
            // play audio to mesure weight
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"EnterWeightReading"];
            // [myAudioPlayer playAudios:array];
            [array release];
            
            
        }
        else if(buttonIndex==1)// skip
            
        {
            
            [self checkFlag];

            
        }
        
    }
    else if(alertView.tag==111)
    {
        
        if(buttonIndex==0)// ok reading taken go to next view
        {
            [self saveWeightInformation];
            
            [self checkFlag];
            
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


-(IBAction)Cancle
{
     [self.navigationController popViewControllerAnimated:YES];


}

-(void)resultAfterParsing:(NSMutableArray *)soapResult
{
    
    NSLog(@"%@",soapResult);
    
}

-(void) checkFlag
  {
      
      
      [audioPlayer stopAudio];

   
     NSString *str2= [arrayFlags objectAtIndex:2];
     NSString *str3= [arrayFlags objectAtIndex:3];
     NSString *str4= [arrayFlags objectAtIndex:4];
      NSString *str5= [arrayFlags objectAtIndex:5];
       NSString *str6= [arrayFlags objectAtIndex:6];
      if ([str2 isEqualToString:@"YES" ])
      {
          // navigate to mesure BG
          classMesureGlucose1 *objMesureGlucose=[[classMesureGlucose1 alloc]initWithNibName:@"classMesureGlucose1" bundle:nil];
          objMesureGlucose.arrayFlags=self.arrayFlags;
          objMesureGlucose.aUser=aUser;
          objMesureGlucose.myAudioPlayer=self.audioPlayer;        
    
          objMesureGlucose.tabBarItem.title=@"Glucose";
          objMesureGlucose.tabBarItem.image=[UIImage imageNamed:@"10-medical.png"];       
          [self.navigationController pushViewController:objMesureGlucose animated:YES];
          [objMesureGlucose release];
                  
      }
      
      else if([str3 isEqualToString:@"YES"])   
          
      {
          
          classMesureBPNew *obj_BP=[[classMesureBPNew alloc]initWithNibName:@"classMesureBPNew" bundle:nil];
          //navC=[[UINavigationController alloc]initWithRootViewController:obj_BP];
          //  obj_BP.delegate=self;
          obj_BP.arrayFlags=self.arrayFlags;
          obj_BP.myAudioPlayer=self.audioPlayer;
          obj_BP.tabBarItem.title=@"BP";
          obj_BP.aUser=self.aUser;

           [self.navigationController pushViewController:obj_BP animated:YES];                
          [obj_BP release];
    }  
      else  if([str4 isEqualToString:@"YES"])    
          
      {
            classHimoglobin *obj_himoglobin=[[classHimoglobin alloc]initWithNibName:@"classHimoglobin" bundle:nil];
          obj_himoglobin.arrayFlags=arrayFlags;
          obj_himoglobin.myAudioPlayer=self.audioPlayer;
          obj_himoglobin.tabBarItem.title=@"Add";
          obj_himoglobin.aUser=aUser;
           [self.navigationController pushViewController:obj_himoglobin animated:YES];
           [obj_himoglobin release];
        
          
      }
      else if([str5 isEqualToString:@"YES"])
      {
          
          classGlycoHemoglobin *obj_glyco=[[classGlycoHemoglobin alloc]initWithNibName:@"classGlycoHemoglobin" bundle:nil];
           obj_glyco.arrayFlags=arrayFlags;
          obj_glyco.aUser=aUser;
          obj_glyco.myAudioPlayer=self.audioPlayer;
          obj_glyco.tabBarItem.title=@"Add";
          [self.navigationController pushViewController:obj_glyco animated:YES];                
          [obj_glyco release];
    
          
      }
 else if([str6 isEqualToString:@"YES"]) 
      {
          
          remindMed *obj_med;
          [audioPlayer stopAudio];
          
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
          obj_med.myAudioPlayer=self.audioPlayer;
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
          if (classHomeObj.weightBool=TRUE) {
              
              [self.navigationController popToRootViewControllerAnimated:NO ];

          }
          else if(classHomeObj.counter==5)
          {
              UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:@"All readings entered successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
              [alertReading show];
              alertReading.tag=116;
              [alertReading release];
              // play audio to all reading entered
              NSMutableArray * array=[[NSMutableArray alloc] init];
              [array addObject:@"allReadingEntered"];
              [audioPlayer playAudios:array];


          }
          [classHomeObj release];
      }

      
      
  }




-(void)playAudio:(int )component1:(int )component2:(int )component3

{
    
    NSMutableArray * array=[[NSMutableArray alloc] init];
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    language=[userDefaults objectForKey:[NSString stringWithFormat:@"languageselected%d",self.aUser.userId]];
    audiosatus=[userDefaults objectForKey:[NSString stringWithFormat:@"audioStatus%d",aUser.userId]];
    
    if ([audiosatus isEqualToString: @"on"]) {
        if([language isEqualToString:@"1"])
        {
            [array addObject:@"yourweightof1"];
            if(component1==0)
            {
                if(component2==1 && component3>0 )
                {
                    
                    [array addObject:[arrayOfNumberInText1 objectAtIndex:component3] ];
                }
                
                if(component2>1 && component3>0 )
                {
                    
                    [array addObject:[arrayOfNumberInText2 objectAtIndex:component2] ];
                    [array addObject:[arrayOfNumberInText objectAtIndex:component3]];
                    
                }
                
                if(component2 >=1 && component3==0)
                {
                    [array addObject:[arrayOfNumberInText2 objectAtIndex:component2] ];
                }
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
                else if (component2>1) {
                    
                    if (component3>0) {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:component2]];
                        [array addObject:[arrayOfNumberInText objectAtIndex:component3]];
                        
                    }
                    if (component3==0) {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:component2]];
                        
                    }
                    
                }
                
                if (component2==0 && component3>0) {
                    [array addObject:[arrayOfNumberInText objectAtIndex:component3]];
                    
                }
                
                
            }
            [array addObject:@"KGHasbeenEntered"];
        }
        else if([language isEqualToString:@"2"])
        {
            [array addObject:@"10"];
            //NSArray *numberArray=[[NSArray alloc] init];
          NSArray *numberArray=[classCommanFunctions marathiAudioMethod:component1 :component2 :component3];
            NSLog(@"Number Array %@",numberArray);
            for (int i=0; i<[numberArray count]; i++) {
                [array addObject:[numberArray objectAtIndex:i]];
            }

                 [array addObject:@"11"];
        }
           
    }
    [audioPlayer playAudios:array];
    [array release];
    [audioPlayer release];
}






@end
