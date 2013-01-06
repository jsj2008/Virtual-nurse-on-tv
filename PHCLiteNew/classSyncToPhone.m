//
//  classSyncToPhone.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/26/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classSyncToPhone.h"
#import "classMedicine.h"
#import "classDatabaseOperations.h"
#import "classMedicineTime.h"
#import "classUser.h"
#import "commanFunctions.h"
#import "classAudio.h"
int downloadingMode;
int medicineIndex,added,duplicate;

#define downloadingUserInfo 1
#define downloadingMedicineInfo 2

@implementation classSyncToPhone
@synthesize myTableView;
@synthesize cellPasswrod;
@synthesize cellMemberId;
@synthesize cellEmpty;
@synthesize cellInstruction;
@synthesize cellPanhealth;
@synthesize txtPassword;
@synthesize txtMemberId;
@synthesize objUser;
@synthesize deletate=_deletate;
@synthesize btnCancel, btnDone;
@synthesize myAudioPlayer;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [cellPasswrod release];
    [cellMemberId release];
    [cellEmpty release];
    [cellInstruction release];
    [cellPanhealth release];
    [txtPassword release];
    [txtMemberId release];
    [myTableView release];
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
    self.title=@"Sync to phone";
    // show cancel button
    self.btnCancel=[[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel) ] autorelease];
    self.navigationItem.leftBarButtonItem=self.btnCancel;
    
    self.btnDone=[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done) ] autorelease];
    self.navigationItem.rightBarButtonItem=self.btnDone;
    
// set memberid
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
    [logoView release];
}

- (void)viewDidUnload
{
    [self setCellPasswrod:nil];
    [self setCellMemberId:nil];
    [self setCellEmpty:nil];
    [self setCellInstruction:nil];
    [self setCellPanhealth:nil];
    [self setTxtPassword:nil];
    [self setTxtMemberId:nil];
    [self setMyTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



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
    // Configure the cell...
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    switch (indexPath.row)
    {
            
        case 3: return cellPanhealth;
            
            break;
            
        case 1: return cellMemberId;
            
            break;
            
        case 2: return cellPasswrod;
            
            break;
            
        case 0: return cellInstruction;
            
            break;
            
            
    }
    
    
    return cellEmpty;
    
    
    
}

-(void)showInidcator:(BOOL)mode
{
    if(downloadingMode==downloadingUserInfo)
    {
        
        [self showInidcator:mode withMessage:@"Logging in..."];
        
                
    }
    else
    {
        
        [self showInidcator:mode withMessage:@"Downloading Medicines..."];
        
        
//        NSMutableArray * array=[[NSMutableArray alloc] init];
//        [array addObject:@"pleaseWaitDownloading"];
//        
//        [self.myAudioPlayer playAudios:array];
//        [array release];
        
        
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
        
        
        UIActivityIndicatorView * indicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(140, 218, 37, 37)];        
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
        [myview removeFromSuperview];
        
    }
    
    
    
    
}
-(void)resultAfterParsing:(NSMutableArray *)arrayResult
{
   
    
    if(downloadingMode==downloadingUserInfo)
    {
        if([arrayResult count]==1 && ![[arrayResult objectAtIndex:0] isEqualToString:@"False"])
        {
            
            NSString * queryString=[NSString stringWithFormat: @"update user set memberid='%@' where userid=%d",[commanFunctions genrateMemberId:self.txtMemberId.text], self.objUser.userId];
            
           // NSLog(@"%@",queryString);
            [classDatabaseOperations add:queryString];
            
            self.objUser.memberId=[commanFunctions genrateMemberId:txtMemberId.text];

            
            // change downloadig mode
            downloadingMode=downloadingMedicineInfo;               
            
            
            // after successfully authenticating user, now download user medicines
            
            NSString * soapMsg=[NSString stringWithFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                "<soap:Body>"
                                "<getMedicineInformation xmlns=\"http://tempuri.org/\">"
                                "<Me_id>%@</Me_id>"
                                "</getMedicineInformation>"
                                "</soap:Body>"
                                "</soap:Envelope>",[commanFunctions genrateMemberId:txtMemberId.text]];	
            // url for websrvice method
            NSString * url=@"http:173.161.245.235/panservices/PickPillService.asmx";
            
            //and soap aciton of webservice method
            NSString *soapAction=@"http://tempuri.org/getMedicineInformation";
            
            
            
            
            // create the object of webservice class, this class contian all code for webservice and parsing
            classWebServices * objWebService=[[classWebServices alloc]init];
            objWebService.delegate=self;
            
            // call the method and pass all info i.e. body, url and soapaction
            [objWebService callWebServiceWithBoday:soapMsg url:url soapAction:soapAction];
            
            [objWebService release];
            
            
            
            
            
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
        
        for(classMedicine * objMedicine in arrayResult)
        {
            
            //add medicines to database
            
            // (1) our query string to add medicine                      
            NSString * queryString=[NSString stringWithFormat:@"insert into medicine (medicinename,medicinetotalpillquantity, medicinefrequency,reorderlevel,medicinecomments,userid) values ('%@',%.1f,%d,%d,'%@',%d)",objMedicine.medicineName,objMedicine.totalPillQuantity,objMedicine.medicineDosesFrequency,objMedicine.reorderLevel,objMedicine.medicineComments,objUser.userId];
          //  NSLog(@"%@",queryString);
            
            // get result back of adding medicine
            int result=[classDatabaseOperations add:queryString];
            
                       
            if(result==0)// 0 for success, medicine added succsfully
            {
                added++;
                               
                //(2) now get id of just added medicine
                NSString * queryString=[NSString stringWithFormat:@"select medicineid from medicine where medicinename='%@' and userId=%d",objMedicine.medicineName,objUser.userId];
                int medicineId=[classDatabaseOperations get:queryString ];
                
                // now add medicine id and its time,quantity in timequantitydetails table
                for(classMedicineTime * objMedicineTime in objMedicine.medicineTimes)
                {
                    
                    if(objMedicineTime.times !=nil)
                    {
                        
                        //(3) ADD TIME DETAILS OF JUST ADDED MEDICINE IN MEDICINETIEDETAILS TABLE
                        NSString * queryString=[NSString stringWithFormat:@"insert into medicinetimedetails (medicineid,medicinetime,medicinepillquantitytotake,doseNumber,userid) values (%d,'%@',%.1f,%d,%d)",medicineId,objMedicineTime.times,objMedicineTime.pillQuantity,objMedicineTime.doseNumber,self.objUser.userId];
                        [classDatabaseOperations add:queryString];
                        
                    }
                }
                
//                              
                // medicine added successfully
                added++;
                
            }
            else
            {
                
                // medicine not added
                duplicate++;
                
                
                
            }
            
            
        }    
        
        
        
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Downloading complete" message:[NSString stringWithFormat:@"Total medicines downloded: %d\n Duplicate medicines: %d",[arrayResult count],duplicate] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        alert.tag=150;
        [alert show];
        [alert release];
        
        // finally get updated medicine list from database
        self.objUser.medicineList=[classDatabaseOperations getMedicineListForUser:self.objUser];   
        
        if(objUser.audioStatus==YES)
        {
            if(objUser.language==1)
            {
        NSMutableArray * array=[[NSMutableArray alloc] init];
        [array addObject:@"downloadingComplete"];
        [self.myAudioPlayer playAudios:array];
        [array release];
            }
            else if(objUser.language==2)
            {
                NSMutableArray * array=[[NSMutableArray alloc] init];
                [array addObject:@"2DownLoadComplete"];
                [self.myAudioPlayer playAudios:array];
                [array release];

                
                
            }
        }
    }
    
      
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(alertView.tag==150)
    {
        
        [self.deletate medicineDownloadingComplete];
 
        
    }
    
    
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



-(void)done
{
    medicineIndex=0;
    added=0;
    duplicate=0;
    downloadingMode=downloadingUserInfo;
    
    
    if([txtMemberId.text length]!=0)
    {
        
        if([txtPassword.text length]!=0)
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
    
    // set downloading mode
    
    
    
}


-(void)cancel
{
    
    
    [self.deletate medicineDownloadingCancel];
    
}


-(void)connectionDidFailWithError
{
    
//    
//    [self showInidcator:NO withMessage:nil];
//  
//    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Unable to connect to server" message:@"Please try after some time" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    [alert show];
//    [alert release];  

    
}
@end
