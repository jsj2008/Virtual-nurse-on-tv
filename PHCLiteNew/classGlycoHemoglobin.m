//
//  classGlycoHemoglobin.m
//  PHCLite
//
//  Created by Avi Kulkarni on 30/08/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classGlycoHemoglobin.h"
#import "remindMed.h"
#import "classWebServices.h"
#import "PHCLiteNewAppDelegate.h"
#import "classAudio.h"
#import "classMesureWeight.h"
#import "classDatabaseOperations.h"
#import "remindMed.h"
#import "classMedicine.h"
#import "commanFunctions.h"
#import "classLocalNotification.h"
#import "classHome.h"

NSMutableArray *arrayNumberInText,*arrayPointNumberInText;



@implementation classGlycoHemoglobin
@synthesize hbPickerBackView;
@synthesize btnEnter;
@synthesize Picker_HBA1c;
@synthesize lblHBA1c;
@synthesize btnDateTime;
@synthesize arrayHba1c1,arrayHba1c2,arrayHba1c3;
@synthesize myAudioPlayer;
@synthesize TotalHBA1cValue;
@synthesize currentDate;
@synthesize delegate;
@synthesize arrayFlags;
@synthesize aUser;
@synthesize btnTake;
@synthesize skip;
@synthesize glycohemoglobindelegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        arrayHba1c1=[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
        
        arrayHba1c2=[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
        
       //  arrayHba1c3=[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];

        arrayHba1c3=[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
        
        
        
        
        componantOneValue=0;
        componantTwoValue=4;
        componantThreeValue=5;
        arrayNumberInText=[[NSMutableArray alloc]initWithObjects:@"zero",@"one",@"two",@"three",@"four",@"five",@"six",@"seven",@"eight",@"nine",nil];
        
      //  arrayFlags=[[NSMutableArray alloc] initWithArray:[classDatabaseOperations getFlags:aUser.userId]];
        //------------------------------------Initiating Number array with audio file name-------------------------------------------------------------------
        
        
         arrayofHundredNumberInText=[[NSMutableArray alloc]initWithObjects:@"zero",@"onehundred",@"twohundred",@"threehundred",@"fourhundred",@"fivehundred",@"sixhundred",@"sevenhundred",@"eighthundred",@"ninehundered", nil];
        
        arrayOfNumberInText1=[[NSMutableArray alloc] initWithObjects:@"zero",@"eleven",@"twelve",@"thirteen",@"fourteen",@"fifteen",@"sixteen",@"seventeen",@"eighteen",@"ninteen", nil];
        arrayOfNumberInText2=[[NSMutableArray alloc] initWithObjects:@"zero",@"ten",@"twenty",@"thiry",@"forty",@"fifty",@"sixty",@"seventy",@"eighty",@"ninety", nil];
        //-------

        // Custom initialization
    }
    return self;
}

-(void)connectionDidFailWithError
{
}

- (void)dealloc
{
    [lblHBA1c release];
    [btnDateTime release];
    [Picker_HBA1c release];
    
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
         
    self.title=@"HbA1c";
    
    self.navigationController.tabBarItem.title=@"Tracker";
    
   
    
    UIBarButtonItem *barCancle=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(Cancle)];
    self.navigationItem.leftBarButtonItem=barCancle;      
    [self setDateTime:[NSDate date]];
    
  //------------------------------------------------------------------------------------------------------------  
    
    lblHBA1c.text=@"04.5";
    
    [Picker_HBA1c selectRow:0 inComponent:0 animated:YES];
    [Picker_HBA1c selectRow:4 inComponent:1 animated:YES];
    [Picker_HBA1c selectRow:5 inComponent:2 animated:YES];
    
    
    
    UIBarButtonItem *barDone=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(DonePicker)];
    self.navigationItem.rightBarButtonItem=barDone;
     
  
    [barCancle release];
    [barDone release];
    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    language=[userDefaults objectForKey:[NSString stringWithFormat:@"languageselected%d",self.aUser.userId]];
    audiosatus=[userDefaults objectForKey:[NSString stringWithFormat:@"audioStatus%d",aUser.userId]];
    
    if ([audiosatus isEqualToString: @"on"]) {
        if([language isEqualToString:@"1"])
        {
            [array addObject:@"measureHBA1c"];
              }
        else if([language isEqualToString:@"2"])
        {
            [array addObject:@"21"];
            
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
{    [myAudioPlayer stopAudio];
    
    [self setLblHBA1c:nil];
    [self setBtnDateTime:nil];
    [self setPicker_HBA1c:nil];
    [ arrayFlags release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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



- (IBAction)selectBtnEnter:(id)sender 
{
    // GlucosePicker.hidden=NO;
    btnEnter.hidden=YES;
    skip.hidden=YES;

   // [self TouchDoneDateTime:nil];
    [UIView beginAnimations:@"BringPickerOut" context:nil];
    [UIView setAnimationDuration:0.5];
    
    // declate a cgpoint variable
    CGPoint point;
    
    //get the old cordinate
    point=self.hbPickerBackView.center;
    
    // set new cordinate
    point.y=292;
    
    //assigne new cordinate
    self.hbPickerBackView.center=point;
           Picker_HBA1c.frame=CGRectMake(0,15,320, 80);
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










-(IBAction)saveGlycoHGInformation
{
   // NSString * memberId=[(PHCLiteNewAppDelegate *) [[UIApplication sharedApplication]delegate]memberId];
    
    NSString *totalValue=[NSString stringWithFormat:@"%d%d.%d",componantOneValue,componantTwoValue,componantThreeValue];
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
    
    NSString *query=[NSString stringWithFormat:@"insert into healthydata (userid,memberid,date,time,type,unit,value1)values(%d,'%@','%@','%@','GH','mm/mol','%@')",userid,memberId,Date,currentTime, totalValue];
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
                        "</soap:Envelope>",@"A00000903952",@"HbA1c",@"SPB502",@"NVX9686BT",@"B",@"",@"",@"",@"",@"iPhone",@"Web",@"",@"",self.TotalHBA1cValue,@"",Date];
    
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
-(void)resultAfterParsing:(NSMutableArray *)soapResult
{
    
    
    
}



-(void)showMesureGlycoHimoglobinAlert
{
    UIAlertView * alertForWeight=[[UIAlertView alloc] initWithTitle:@"Measure GlycoHemoglobin" message:@"Please measure your Glyco hemoglobin..." delegate:self cancelButtonTitle:@"Done" otherButtonTitles:@"skip", nil];
    [alertForWeight show];
    alertForWeight.tag=168;
    [alertForWeight release];
    
    // play audio to mesure weight
    NSMutableArray *array=[[NSMutableArray alloc]init];    
    [array addObject:@"measusreHeamoglobinReadingAndTapDone"];
    [myAudioPlayer playAudios:array];
    [array release];
    
    

    }
// PickerView Methods....
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 3;
    
}
//picker_View Method...

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0)
    {
        return  [arrayHba1c1 count]; 
        
    }
    if(component==1)
    {
        return  [arrayHba1c2 count]; 
        
    }
    if(component==2)
    {
        return  [arrayHba1c3 count]; 
        
    }
    
    return 0;
    
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0)
    {
        return [arrayHba1c1 objectAtIndex:row];
        
    }
    if(component==1)
    {
        return [arrayHba1c2 objectAtIndex:row];
        
    }
    if(component==2)
    {
        return [arrayHba1c3 objectAtIndex:row];
        
    }
    
    return @"abc";
    
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    if (component==0)
    //    {
    //         //str_HG=[arrayHB1 objectAtIndex:row];
    //        [self setHG:[arrayHB1 objectAtIndex:row]];
    //    }
    //    if (component==1)
    //    {
    //        //str_HG1=[arrayHB2 objectAtIndex:row];
    //        [self setHG1:[arrayHB2 objectAtIndex:row]];
    //    }
    //    if (component==2)
    //    {
    //        //str_HG2=[arrayHB3 objectAtIndex:row];
    //        [self setHG2:[arrayHB3 objectAtIndex:row]];
    //    }
    
    
    NSMutableArray * array;
    
    
    if(component==0)
    {
        
        componantOneValue=[[arrayHba1c1 objectAtIndex:row] intValue];
        
        array=[[NSMutableArray alloc] init];
        
        // add audio file for value of component two
        [array addObject:[arrayNumberInText objectAtIndex:componantOneValue]];
        
        
    }
    else
        if(component==1)
        {
            
            componantTwoValue=[[arrayHba1c2 objectAtIndex:row] intValue];
            
            array=[[NSMutableArray alloc] init];
            
            // add audio file for value of component two
            [array addObject:[arrayNumberInText objectAtIndex:componantTwoValue]];
            
        }
        else
            if(component==2)
            {
                
                componantThreeValue=[[arrayHba1c3 objectAtIndex:row] floatValue];
                
                array=[[NSMutableArray alloc] init];
                
                // add audio file for value of component two
                [array addObject:[arrayNumberInText objectAtIndex:componantThreeValue]];
          }
    
    componantOneValue=[pickerView selectedRowInComponent:0];
    componantTwoValue=[pickerView selectedRowInComponent:1];
    componantThreeValue=[pickerView selectedRowInComponent:2];

    //[self setHimoglobinFromComponent1:componantOneValue Component2:componantTwoValue Component3:componantThreeValue];
    [self setGlycoHimoglobinFromComponent1:componantOneValue Component2:componantTwoValue Component3:componantThreeValue];
    
    [myAudioPlayer playAudios:array];
    [array release];
    
}
-(void)setGlycoHimoglobinFromComponent1:(int)value1 Component2:(int)value2 Component3:(int)value3
{
    NSString *totalValue=[NSString stringWithFormat:@"%d%d.%d",componantOneValue,componantTwoValue,componantThreeValue];
    
    lblHBA1c.text=totalValue;
     

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)selectDateTime:(id)sender {
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

    [self.glycohemoglobindelegate glycohemoglobinskipFlag];
}



-(IBAction)Cancle
{
    [self.navigationController popViewControllerAnimated:YES];

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
            /*   NSLog(@"hiiiiii1111111111111");
             
             classGlycoHemoglobin *obj_glyco=[[classGlycoHemoglobin alloc]initWithNibName:@"classGlycoHemoglobin" bundle:nil];
             // UINavigationController *nav2=[[UINavigationController alloc]initWithRootViewController:obj_glyco];
             // obj_glyco.delegate=self;
             
             NSLog(@"hiiiiii1111111111111");
             obj_glyco.myAudioPlayer=self.myAudioPlayer;
             [self.navigationController pushViewController:obj_glyco animated:YES];                
             [obj_glyco release];
             
             */
            
            
            
        }
        else
        {
            // do nothing
            
            
            
            
        }
        
    }
    else if (alertView.tag==111)
    {
        
        
        if(buttonIndex==0)
        {
            [self checkFlag];
            [self.glycohemoglobindelegate glycohemoglobinDoneFlag];

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

-(IBAction)DonePicker
{
    if(componantOneValue+componantTwoValue+componantThreeValue==0)
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Empty Reading" message:@"Please enter your Glycohemoglobin Reading" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
        [self saveGlycoHGInformation];
        if(![aUser.memberId isEqualToString:@""])
        {

        UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:[NSString stringWithFormat:@"Your Glycohemoglobin reading of %d%d.%d mmol/mol has been entered successfully.",componantOneValue,componantTwoValue,componantThreeValue] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alertReading show];
        alertReading.tag=111;
        [alertReading release]; 
        }
        else
        {
            UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"MemberId Not Found!" message:[NSString stringWithFormat:@"Your Glycohemoglobin reading of %d%d.%d mmol/mol has been stored successfully on local Database.",componantOneValue,componantTwoValue,componantThreeValue] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
            [alertReading show];
            alertReading.tag=111;
            [alertReading release]; 

        }
        
        NSMutableArray *array=[[NSMutableArray alloc]init];
        
        NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
        language=[userDefaults objectForKey:[NSString stringWithFormat:@"languageselected%d",self.aUser.userId]];
        audiosatus=[userDefaults objectForKey:[NSString stringWithFormat:@"audioStatus%d",aUser.userId]];
        
        if ([audiosatus isEqualToString: @"on"]) {
            if([language isEqualToString:@"1"])
            {
                [array addObject:@"yourglycohemoglobin"];
                
                if(componantOneValue!=0)
                {
                    
                    // add audio file for value of component two
                    if (componantOneValue>1) {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:componantOneValue]];
                        
                    }
                    if (componantOneValue==1 && componantTwoValue==0) {
                        [array addObject:[arrayOfNumberInText2 objectAtIndex:componantOneValue]];
                    }
                    if (componantOneValue==1 && componantTwoValue>0) {
                        [array addObject:[arrayOfNumberInText1 objectAtIndex:componantTwoValue]];
                    }
                }
                if (componantTwoValue!=0)
                {
                    if (componantOneValue>1) {
                        [array addObject:[arrayNumberInText objectAtIndex:componantTwoValue]];
                    }
                    // add audio file for value of component two
                }
                if (componantOneValue==0) {
                    if (componantTwoValue>0) {
                        [array addObject:[arrayNumberInText objectAtIndex:componantTwoValue]];
                    }
                }
                [array addObject:@"point"];
                
                // add audio file for value of component two
                [array addObject:[arrayNumberInText objectAtIndex:componantThreeValue]];
                
                
                [array addObject:@"mmPerMolesHasBeenEntered"];
                
            
            }
            else if([language isEqualToString:@"2"])
            {
                [array addObject:@"22"];
                                
                    NSArray *numberArray=[[NSArray alloc] init];
                    numberArray=[classCommanFunctions marathiAudioMethod:0 :componantOneValue :componantTwoValue];
                    NSLog(@"Number Array %@",numberArray);
                    for (int i=0; i<[numberArray count]; i++) {
                        [array addObject:[numberArray objectAtIndex:i]];
                    }
                  [array addObject:@"point1"];
                numberArray=[classCommanFunctions marathiAudioMethod:0 :0 :componantThreeValue];
                NSLog(@"Number Array %@",numberArray);
                for (int i=0; i<[numberArray count]; i++) {
                    [array addObject:[numberArray objectAtIndex:i]];
                }
                
                [array addObject:@"24"];
                [array release];
            }
            [myAudioPlayer playAudios:array];
            [array release];
        }
        
  }

 
}


-(void)mesuringGlycoHimoblobinDidComplete
{

}



-(void)mesuringGlycoHimoblobinDidCancel
{


}


-(void)checkFlag
{
    remindMed *obj_med;
   [myAudioPlayer stopAudio];
    
  NSString *str6= [arrayFlags objectAtIndex:6];
    if([str6 isEqualToString:@"YES"]) 
    {
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

        if (classHomeObj.glycoHemoBool==FALSE) {
            
            [self.navigationController popToRootViewControllerAnimated:NO ];
            
        }
       else
       {
       }
    }
    

}




@end
