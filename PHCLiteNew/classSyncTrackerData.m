//
//  classSyncToServerTaekeMed.m
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 16/01/12.
//  Copyright 2012 PanHealth Inc. All rights reserved.
//

#import "classSyncToServerTaekeMed.h"
#import "classWebServices.h"
#import "classMedicine.h"
#import "classMedicineTime.h"
#import "classDatabaseOperations.h"
#import "commanFunctions.h"
#import "classUser.h"
#import "classAudio.h"
#import "classCompartmentData.h"
#import "classSyncTrackerData.h"

int downloadingMode;
#define downloadingUserInfo 1
#define downloadingMedicineInfo 2
int medicineIndex,uploded,duplicate;

@implementation   classSyncTrackerData

@synthesize txtMemberId;
@synthesize txtPassword;
@synthesize cellMemberId;
@synthesize cellPassword;
@synthesize cellEmpty;
@synthesize cellInstruction;
@synthesize cellPanhealth;
@synthesize objUser;
@synthesize delegate=_delegate;
@synthesize btnDone,btnCancel;
@synthesize myAudioPlayer;
@synthesize arrayTakeMed;
@synthesize strArrayTakemed;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [cellMemberId release];
    [cellPassword release];
    [cellEmpty release];
    [cellInstruction release];
    [cellPanhealth release];
    [txtMemberId release];
    [txtPassword release];
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
    
    //title
    self.title=@"Sync(PillBox)to Server";
    // show cancel button
    self.btnCancel=[[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel) ] autorelease];
    self.navigationItem.leftBarButtonItem=self.btnCancel;
    
    self.btnDone=[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done) ] autorelease];
    self.navigationItem.rightBarButtonItem=self.btnDone;
    
    
    self.txtMemberId.text=self.objUser.memberId;
    
    if(objUser.audioStatus==YES)
    {
        if(objUser.language==1)
        {
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"pleaseEnterYourMemberIdAndPassword"];
            
            [self.myAudioPlayer playAudios:array];
            [array release];
        }
        
        
        else if(objUser.language==2)
        {
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"2pleaseEnterYourMemberIdAndPassword"];
            
            [self.myAudioPlayer playAudios:array];
            [array release];
            
            
            
        }
        
    }
    
    
    NSLog(@"\n  userid  in sync is.............%d",objUser.userId);
    
  
    //[self getTableTakeMed];
    
    //     arrayTakeMed=[classDatabaseOperations getTakeMedicineArrayForUser:objUser.userId];
    //   for(int i=0;i<[arrayTakeMed count];i++)
    //    {
    //        NSLog(@"%@",[arrayTakeMed objectAtIndex:i]);    
    //    
    //   }
    //    NSLog(@"%d",[arrayTakeMed count]);  
    
    
    
    
    
    
}

- (void)viewDidUnload
{
    [self setCellMemberId:nil];
    [self setCellPassword:nil];
    [self setCellEmpty:nil];
    [self setCellInstruction:nil];
    [self setCellPanhealth:nil];
    [self setTxtMemberId:nil];
    [self setTxtPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *strImg1=@"backImage1.png";
    UIImageView *logoView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:strImg1]];
    NSString *strImg=[classDatabaseOperations getNurseImg:objUser.userId];
    NSLog(@"%@image",strImg);
    if ([strImg isEqualToString:@"null"])
    {
        logoView.image=[UIImage imageNamed:strImg1];
    }
    else{
        NSLog(@"Nurse is %@",strImg);
        logoView.image=[UIImage imageNamed:strImg];
    }
    
    
    logoView.frame = CGRectMake(220, 0, 43, 43);
    
    
    [self.navigationController.navigationBar addSubview:logoView];
    [super viewWillAppear:animated];
    [logoView release];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    switch (indexPath.row)
    {
            
        case 3: return cellPanhealth;
            
            break;
            
        case 1: return cellMemberId;
            
            break;
            
        case 2: return cellPassword;
            
            break;
            
        case 0: return cellInstruction;
            
            break;
            
            
    }
    
    
    return cellEmpty;
    
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}



-(void)cancel
{
    
    //[self.delegate syncToServerDidCancelTakMed];
    [self dismissModalViewControllerAnimated:YES];

    
}


-(void)done
{
    medicineIndex=0;
    uploded=0;
    duplicate=0;
    downloadingMode=downloadingUserInfo;
    
    
    if([txtMemberId.text length]!=0)
    {
        
        if([txtPassword.text length]!=0)
        {
            
            
            if([self.objUser.medicineList count]!=0)
            { 
                
                if(objUser.audioStatus==YES)
                {
                    if(objUser.language==1)
                    {
                        NSMutableArray * array=[[NSMutableArray alloc] init];
                        [array addObject:@"PleaseWeightLoginIN"];                
                        [self.myAudioPlayer playAudios:array];
                        [array release];
                    }
                    
                    else if(objUser.language==2)
                        
                    {
                        NSMutableArray * array=[[NSMutableArray alloc] init];
                        [array addObject:@"2PleaseWeightLoginIN"];                
                        [self.myAudioPlayer playAudios:array];
                        [array release];
                        
                        
                    }
                }
                [self validateUser];
                
            }
            else
            {
                
                
                UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"There are no medicines to upload" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                alert.tag=168;
                [alert show];
                [alert release];  
                
            }
            
            
            
        }
        else
        {
            
            
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Please enter your Password " message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];  
            
        }
        
    }
    else
    {
        
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Please enter your Member Id" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release]; 
        
    }
    
    
    
    
}



-(void)showInidcator:(BOOL)mode
{
    if(downloadingMode==downloadingUserInfo)
    {
        
        [self showInidcator:mode withMessage:@"Logging in..."];
        
        
        
    }
    else
    {        
        //        classCompartmentData * objMed=[arrayTakeMed objectAtIndex:medicineIndex];
        //        
        //        [self showInidcator:mode withMessage:[NSString stringWithFormat:@"Uploading (%d of %d) %@",medicineIndex+1, [arrayTakeMed count], objMed.bayMedName]];
        //NSLog(@"Uploading medicine %d",medicineIndex);
        
        
        [self showInidcator:mode withMessage:@"Uploading...."];
        
        
    }
    
    
    
}

-(void)showInidcator:(BOOL)mode withMessage:(NSString *)message
{
    
    
    
    if(mode==YES)
    {
        
        
        
        self.btnCancel.enabled=NO;
        self.btnDone.enabled=NO;
        
        UIView * viewWithActIndicator=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        viewWithActIndicator.tag=100;
        viewWithActIndicator.alpha=0.7f;
        viewWithActIndicator.backgroundColor=[UIColor blackColor];
        
        
        UIActivityIndicatorView * indicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(135, 218, 37, 37)];        
        indicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
        [indicator startAnimating];
        [viewWithActIndicator addSubview:indicator];
        
        [indicator release];
        
        UILabel * lblLoading=[[UILabel alloc] initWithFrame:CGRectMake(0, 255, 320, 21)];
        lblLoading.text=message;
        lblLoading.textAlignment=UITextAlignmentCenter;
        lblLoading.font=[UIFont fontWithName:@"Futura" size:14.0f];
        lblLoading.textColor=[UIColor whiteColor];
        lblLoading.backgroundColor=[UIColor clearColor];
        
        [viewWithActIndicator addSubview:lblLoading];
        [lblLoading release];
        
        [self.view addSubview:viewWithActIndicator];
        [viewWithActIndicator release];
        
        
    }
    else
    {
        
        self.btnCancel.enabled=YES;
        self.btnDone.enabled=YES;
        
        UIView * myview=[self.view viewWithTag:100];
        [myview removeFromSuperview];//848381
        
    }
    
    
    
    
}
-(void)resultAfterParsing:(NSMutableArray *)arrayResult
{
    if(downloadingMode==downloadingUserInfo)
    {
        if([arrayResult count]==1 && ![[arrayResult objectAtIndex:0] isEqualToString:@"False"])
        {
            
            // update users member id            
            NSString * queryString=[NSString stringWithFormat: @"update user set memberid='%@' where userid=%d",[commanFunctions genrateMemberId:self.txtMemberId.text], self.objUser.userId];
            
            // NSLog(@"%@",queryString);
            [classDatabaseOperations add:queryString];
            NSString * queryString1=[NSString stringWithFormat: @"update takemedicine set Memberid='%@' where userid=%d",[commanFunctions genrateMemberId:self.txtMemberId.text], self.objUser.userId];
            
            // NSLog(@"%@",queryString);
            [classDatabaseOperations add:queryString1];
            
            
            
            self.objUser.memberId=[commanFunctions genrateMemberId:txtMemberId.text];
            
            // change downloadig mode
            downloadingMode=downloadingMedicineInfo;       
            
            [self getTableTakeMed];
            [self saveMedicineArray];
            
            //            if(medicineIndex<[arrayTakeMed count])
            //            {
            //                classCompartmentData * objTakeMed=[arrayTakeMed objectAtIndex:medicineIndex];
            //                
            //                [self saveMedicine:objTakeMed];
            //                
            //            }
            
            
            
            
            
        }
        else
        {
            
            // alert- Login failed
            
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Unable to login" message:@"Please check Member Id/ passwrod, \n and try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
            
            
            
        }
        
        
    }
    else  if(downloadingMode==downloadingMedicineInfo)
    {
        
        //medicineIndex++;
        //   [self saveMedicineArray];
        
        
        //        if(medicineIndex<[arrayTakeMed count])
        //        {
        //            classCompartmentData * objTakeMed=[arrayTakeMed objectAtIndex:medicineIndex];
        //            [self saveMedicine:objTakeMed];
        //            
        //        }
        
        //        
        //        if([[arrayResult objectAtIndex:0] isEqualToString:@"True"])
        //        {
        //            
        //            
        //            uploded++;
        //            
        //        }
        //        else
        //        {
        //            
        //            
        //            duplicate++;
        //            
        //        }
        //        
        
        //NSLog(@"result ading medicine %@, medicine index:%d",[arrayResult objectAtIndex:0],medicineIndex);
        
        // if(medicineIndex>=[arrayTakeMed count])
        {
            
            
            int i=[arrayTakeMed count]/10;
            
            
            
            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Uploading complete !!" message:[NSString stringWithFormat: @"Uploaded Medicine:%d ",i] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            alert.tag=89;
            [alert show];
            [alert release]; 
            
            if(objUser.audioStatus==YES)
            {
                
                if(objUser.language==1)
                {
                    NSMutableArray * array=[[NSMutableArray alloc] init];
                    [array addObject:@"uploadingComplete"];
                    
                    [self.myAudioPlayer playAudios:array];
                    [array release];
                }
                else if(objUser.language==2)
                {
                    NSMutableArray * array=[[NSMutableArray alloc] init];
                    [array addObject:@"2uploadingComplete"];
                    
                    [self.myAudioPlayer playAudios:array];
                    [array release];
                    
                    
                }
                
            }
        }
        
        
    }    
    
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(alertView.tag==89)
    {
        
        [self.delegate syncToServerDidCompleteTakMed];
        
        
    }
    
    
}


-(void)connectionDidFailWithError
{
    
    
    
}

-(NSString *)genrateMemberId:(NSString *) memberId
{
	NSAutoreleasePool * pool=[[NSAutoreleasePool alloc]init];
    
    
	NSMutableString *strNewMemberId=[[NSMutableString alloc]init];
	NSString * subStringOfGivenMemberId=[memberId substringFromIndex:1];
	
	
    for(int i=0;i<12-[subStringOfGivenMemberId length];i++)
    {
        
        if(i==0)// append A
        {
            [strNewMemberId appendString: [[NSString stringWithFormat:@"%c",[memberId characterAtIndex:0]] uppercaseString]];
        }
        else
        {
            [strNewMemberId appendString: @"0"];
        }
    }
    
    [strNewMemberId appendString:subStringOfGivenMemberId];
	[pool drain];
	NSString *str=[strNewMemberId substringFromIndex:0];
	[strNewMemberId release];
	
	//
	
	return str;	
	
}


-(void)saveMedicine:(classCompartmentData *)objMedicine

{
    
    NSMutableArray  *arrayOfData=[[NSMutableArray alloc]initWithArray:[classDatabaseOperations getData:@"pulse" :objUser.userId]  ];
    
    for ( NSString  *obj in  arrayOfData)
    {
        NSLog(@"data for user is......................\n");
        NSLog(@"    \n %@ \n",obj);
    }
    

    
    //    //this is a soap request body
    //    NSString * soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    //                      
    //                        "<soap:Body>"
    //                        "<Take_Medication xmlns=\"http://tempuri.org/\">"
    //                        "<strUser_id>%@</strUser_id>"
    //                        "<intMedicineid>%d</intMedicineid>"
    //                       "<strMedicineName>%@</strMedicineName>"
    //                       "<strMedQty>%@</strMedQty>"
    //                        "<strDay>%@</strDay>"
    //                       "<strBayno>%@</strBayno>"
    //                       "<strtimespan>%@</strtimespan>"
    //                        "<intstate>%d</intstate>"
    //                       "<timestamp>%@</timestamp>"
    //                        "</Take_Medication>"
    //                        "</soap:Body>"
    //                        "</soap:Envelope>",
    //                        [commanFunctions genrateMemberId:txtMemberId.text],
    //                        objMedicine.medicineID,
    //                        objMedicine.bayMedName,
    //                        objMedicine.bayMedQty,
    //                        objMedicine.bayMedDay,
    //                        [NSString stringWithFormat:@"%@",objMedicine.bayno],
    //                        objMedicine.bayMedTimeSpan,
    //                        objMedicine.state,
    //                        objMedicine.timestamp];	
    
    // NSLog(@"%@ %f %@",objMedicine.bayMedName,objMedicine.bayMedQty,objMedicine.timestamp);
    
    
    
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
                        "</soap:Envelope>",objUser. memberId,@"WT",@"SPB502",@"NVX9686BT",@"B",@"",@"",@"",@"",@"iPhone",@"Web",@"3443",@"",@"",@"",@""];
    
    
    
    NSLog(@"%@",soapMsg);
    
    // url for websrvice method
    NSString * url=@"http:173.161.245.235/test/Service.asmx";
    
    //and soap aciton of webservice method
    NSString *soapAction=@"http://tempuri.org/Take_Medication";
    
    
    //create the object of webservice class, this class contian all code for webservice and parsing
    classWebServices * objWebService=[[classWebServices alloc]init];
    objWebService.delegate=self;
    
    // call the method and pass all info i.e. body, url and soapaction
    [objWebService callWebServiceWithBoday:soapMsg url:url soapAction:soapAction];
    
    [objWebService release];
    [arrayOfData release];
}

-(void)validateUser
{
    
    
    
    [txtMemberId resignFirstResponder];
    [txtPassword resignFirstResponder];
    
    //1st call webservice to download userInfo e.g. fname, lname, getnder, phno. and email
    
    downloadingMode=downloadingUserInfo;
    
    
    NSString * soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        "<soap:Body>"
                        "<getMemberinfo xmlns=\"http://tempuri.org/\">"
                        "<strUserid>%@</strUserid>"
                        "<strPass>%@</strPass>"
                        "</getMemberinfo>"
                        "</soap:Body>"
                        "</soap:Envelope>",[commanFunctions genrateMemberId:txtMemberId.text],txtPassword.text];
    
    
    //url for websrvice method
    NSString * url=@"http:173.161.245.235/test/Service.asmx";
    
    // and soap aciton of webservice method
    NSString *soapAction=@"http://tempuri.org/getMemberinfo";
    
    // create the object of webservice class, this class contian all code for webservice and parsing
    classWebServices * objWebService=[[classWebServices alloc]init];
    objWebService.delegate=self;
    
    // call the method and pass all info i.e. body, url and soapaction
    [objWebService callWebServiceWithBoday:soapMsg url:url soapAction:soapAction];
    
    [objWebService release];
    
    
}


-(void)getTableTakeMed
{
    
    
    arrayTakeMed=[classDatabaseOperations getMedicineListForUser:objUser];
    
    strArrayTakemed=[[NSMutableString alloc]init];
    
    for(int i=0;i<[arrayTakeMed count];i++)
    {
        
        [strArrayTakemed appendString: [NSString stringWithFormat:@"%@",[arrayTakeMed objectAtIndex:i]]];
        
    }
    
    
    
    
    
    
    NSLog(@"MSG %@",strArrayTakemed);
    
    
    
    
    
    
    
}

-(void)saveMedicineArray
{
    
    NSString * soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        "<soap:Body>"
                        "<Take_MedicationArray xmlns=\"http://tempuri.org/\">"
                        " <strData>%@</strData>"
                        " </Take_MedicationArray>"
                        "</soap:Body>"
                        " </soap:Envelope>",strArrayTakemed];
    
    
    
    
    NSLog(@" soap Msg  %@",soapMsg);
    
    // url for websrvice method
    NSString * url=@"http:173.161.245.235/test/Service.asmx";
    
    //and soap aciton of webservice method
    NSString *soapAction=@"http://tempuri.org/Take_MedicationArray";
    
    
    
    //create the object of webservice class, this class contian all code for webservice and parsing
    classWebServices * objWebService=[[classWebServices alloc]init];
    objWebService.delegate=self;
    
    // call the method and pass all info i.e. body, url and soapaction
    [objWebService callWebServiceWithBoday:soapMsg url:url soapAction:soapAction];
    
    [objWebService release];
    
    
    
    
    
}


@end
