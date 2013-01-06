//
//  classReigisterUser.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/27/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classReigisterUser.h"
#import "classUser.h"
#import "classDatabaseOperations.h"
#import "commanFunctions.h"
#import "classAudio.h"

UITextField * curretnTextField;


@implementation classReigisterUser

@synthesize delegate=_delegate;
@synthesize cellInstruction;
@synthesize tblNewUsr;
@synthesize txtFname;
@synthesize txtLName;
@synthesize segmentGender;
@synthesize txtEmailId;
@synthesize txtPhoneNo;
@synthesize txtConfirmEmailId;
@synthesize txtConfirmPhoneNo;
@synthesize txtConfirmPassword;
@synthesize btnBarDelete;
@synthesize btnBarUpdate;
@synthesize btnBarSave;
@synthesize btnBarCancel;
@synthesize cellFirstName;
@synthesize cellLastName;
@synthesize cellGender;
@synthesize cellEmailId;
@synthesize cellPhoneNo;
@synthesize cellPasswrod;
@synthesize cellConfirmEmailId;
@synthesize cellConfirmPhoneNo;
@synthesize cellConfirmPassword;
@synthesize cellEmpty;
@synthesize btnCancel,btnSave;

@synthesize cellPanhealth;
@synthesize cellPanhealth1;
@synthesize isNewUser;
@synthesize objUser;

@synthesize myAudioPlayer;
@synthesize arrayOfSoundFileNames;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        myAudioPlayer=[[classAudio alloc] init];
        arrayOfSoundFileNames=[[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [tblNewUsr release];
    [txtFname release];
    [segmentGender release];
    [txtLName release];
    [txtEmailId release];
    [txtPhoneNo release];
    [btnBarDelete release];
    [btnBarUpdate release];
    [btnBarSave release];
    [btnBarCancel release];
    [cellFirstName release];
    [cellLastName release];
    [cellGender release];
    [cellEmailId release];
    [cellPhoneNo release];
    [cellPasswrod release];
    [cellEmpty release];
    [cellConfirmEmailId release];
    [cellConfirmPhoneNo release];
    [cellConfirmPassword release];
    [txtConfirmEmailId release];
    [txtConfirmPhoneNo release];
    [txtConfirmPassword release];
    [txtPassword release];
    [cellInstruction release];
    [cellPanhealth release];
    [cellPanhealth1 release];
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
    
    // set title 
    
    
    // show cancel button
    self.btnCancel=[[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel) ] autorelease];
    self.navigationItem.leftBarButtonItem=self.btnCancel;
    
    self.btnSave=[[[UIBarButtonItem alloc] initWithTitle:@"Register" style:UIBarButtonItemStyleDone target:self action:@selector(saveUserInformation) ] autorelease];
    self.navigationItem.rightBarButtonItem=self.btnSave;
    
    // if we are adding new user disable update and delete button
    
    if(isNewUser==YES)
    {
        self.btnBarDelete.enabled=NO;
        self.btnBarUpdate.enabled=NO;
        self.btnBarSave.enabled=YES;
    }
    else
    {
        [self setUserInformation:self.objUser];
        self.btnBarDelete.enabled=YES;
        self.btnBarUpdate.enabled=YES;
        //self.btnBarSave.enabled=NO;
        
    }
    

    
    
  //  NSLog(@"userid newuser %d",objUser.userId);
    
    if(self.objUser.audioStatus==YES)
    {
    
        if(objUser.language==1)
        {
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"pleaseEnterAllYourDetails"];
    
            [self.myAudioPlayer playAudios:array];
            [array release];
        }  
           
        
      else if(objUser.language==2)
        {
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"2EnterAllData"];
            
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
    [self setTblNewUsr:nil];
    [self setTxtFname:nil];
    [self setSegmentGender:nil];
    [self setTxtLName:nil];
    [self setTxtEmailId:nil];
    [self setTxtPhoneNo:nil];
    [self setBtnBarDelete:nil];
    [self setBtnBarUpdate:nil];
    [self setBtnBarSave:nil];
    [self setBtnBarCancel:nil];
    [self setCellFirstName:nil];
    [self setCellLastName:nil];
    [self setCellGender:nil];
    [self setCellEmailId:nil];
    [self setCellPhoneNo:nil];
    [self setCellPasswrod:nil];
    [self setCellEmpty:nil];
    [self setCellConfirmEmailId:nil];
    [self setCellConfirmPhoneNo:nil];
    [self setCellConfirmPassword:nil];
    [self setTxtConfirmEmailId:nil];
    [self setTxtConfirmPhoneNo:nil];
    [self setTxtConfirmPassword:nil];
    [txtPassword release];
    txtPassword = nil;
    [self setCellInstruction:nil];
    [self setCellPanhealth:nil];
    [self setCellPanhealth1:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark tableViewDelegateMethdos

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 14;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(indexPath.row<=7)
    {
        
        return 45;
    }
    else
    {
        return 45;
    }
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    switch (indexPath.row)
    {
        case 0: return cellFirstName;
            break;
            
        case 1: return cellLastName;
            break;
            
        case 2: return cellGender;
            break;
            
        case 3: return cellPhoneNo;
            break;
        case 4: return cellConfirmPhoneNo;
            break;
            
        case 5: return cellEmailId;
            break;
        case 6: return cellConfirmEmailId;
            break;
        case 7: return cellInstruction;
            break;
        case 8: return cellPanhealth1;
            break;
            
            
            
    }
    
    
    return cellEmpty;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    curretnTextField=textField;
    [textField resignFirstResponder];
    [self.tblNewUsr scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
    
    
    
    
    switch (textField.tag)
    {
        case 0: //[txtLName becomeFirstResponder];
            
            break;
            
        case 1: //[txtPhoneNo becomeFirstResponder];
            [self.tblNewUsr scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:10 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
            
            
            
            break;
            
        case 2:// [txtConfirmPhoneNo becomeFirstResponder];
            
            
            break;
            
        case 3: //[txtEmailId becomeFirstResponder];
            [self.tblNewUsr scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:10 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
            
            
            break;
            
        case 4:// [txtConfirmEmailId becomeFirstResponder];
            
            
            break;
            
            
            
    }
    
    
    
    
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    curretnTextField=textField;
    
    if(textField.tag==1)
    {
        [self.tblNewUsr scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
    }
    
    if(textField.tag==3 ||textField.tag==4)
    {
        [self.tblNewUsr scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:10 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
    }
    
    if(textField.tag==5||textField.tag==6)
    {
        [self.tblNewUsr scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:11 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
    }
   // NSLog(@"%d",textField.tag);
}


-(void)cancel
{
    [myAudioPlayer stopAudio];
    
    [self.delegate newUserAddingDidCancel];
    
}

-(void)setUserInformation:(classUser*)selectedUser
{
    
    self.txtFname.text=selectedUser.firstName;
    self.txtLName.text=selectedUser.lastName;
    self.txtEmailId.text=selectedUser.emailId;
    self.txtPhoneNo.text=selectedUser.phoneNo;
    
    self.txtConfirmEmailId.text=selectedUser.emailId;
    self.txtConfirmPhoneNo.text=selectedUser.phoneNo;
    
    if([selectedUser.gender isEqualToString:@"M"])
    {
        
        
        self.segmentGender.selectedSegmentIndex=0;
        
    }
    else
    {
        
        self.segmentGender.selectedSegmentIndex=1; 
        
    }
    
    
    self.txtEmailId.text=selectedUser.emailId;
    
    
    
    
}

- (IBAction)saveUserInformation

{
    
    
    
    
    [curretnTextField resignFirstResponder];
    [self.tblNewUsr scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
    
    
    
    if([commanFunctions checkIsValidName:txtFname.text andErrorMessage:@"First Name is invalid"])
    {
        
        
        
        if([commanFunctions checkIsValidName:txtLName.text andErrorMessage:@"Last Name is invalid"])
        {
            
            if([commanFunctions checkIsValidPhoneNumber:txtPhoneNo.text andErrorMessage:@"Invalid Phone No."])
            {
                
                
                if([commanFunctions checkIsValidPhoneNumber:txtConfirmPhoneNo.text andErrorMessage:@"Confirmed  Phone No. is invalid"])
                {
                    
                    
                    if([txtPhoneNo.text isEqualToString:txtConfirmPhoneNo.text])
                        
                    {
                        
                        
                        if([commanFunctions checkIsValidEmail:txtEmailId.text andErrorMessage:@"Email Id is invalid"])
                            
                        {
                            
                            
                            if([commanFunctions checkIsValidEmail:txtConfirmEmailId.text andErrorMessage:@"Confirmed Email Id is invalid"])
                                
                            {
                                
                                
                                if([txtEmailId.text isEqualToString:txtConfirmEmailId.text])
                                    
                                {
                                    
                                    
                                    // create new user
                                  //  self.objUser=[[[classUser alloc] init] autorelease];
                                    
                                    // set fname
                                    self.objUser.firstName=self.txtFname.text;
                                    
                                    //set lname
                                    self.objUser.lastName=self.txtLName.text;
                                    
                                    // set gender
                                    if(self.segmentGender.selectedSegmentIndex==0)
                                    {
                                        
                                        self.objUser.gender=@"M";
                                        
                                    }
                                    else
                                    {
                                        
                                        
                                        self.objUser.gender=@"F";
                                        
                                    }
                                    
                                    // set phone number
                                    self.objUser.phoneNo=txtPhoneNo.text;
                                    
                                    //set email id
                                    self.objUser.emailId=txtEmailId.text;
                                    
                                    // show indicator 
                                    
                                    
                                    
                                    NSString * soapMsg = [NSString stringWithFormat:	
                                                          
                                                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                                          "<soap:Body>"
                                                          "<CreateNewMember xmlns=\"http://tempuri.org/\">"
                                                          "<strFirst>%@</strFirst>"
                                                          "<strMid>%@</strMid>"
                                                          "<strLast>%@</strLast>"
                                                          "<strGen>%@</strGen>"
                                                          "<strEmailAdd>%@</strEmailAdd>"
                                                          "<strPhone>%@</strPhone>"
                                                          "<intcontacttype>%d</intcontacttype>" // 3 for both phone & email or email and 5 for phone
                                                          "</CreateNewMember>"
                                                          "</soap:Body>"
                                                          "</soap:Envelope>",objUser.firstName,@"",objUser.lastName,objUser.gender,objUser.emailId,objUser.phoneNo,3];
                                    
                                    
                                    
                                    //url for websrvice method
                                    NSString * url=@"http:173.161.245.235/test/Service.asmx";
                                    
                                    // and soap aciton of webservice method
                                    NSString *soapAction=@"http://tempuri.org/CreateNewMember";
                                    
                                    // create the object of webservice class, this class contian all code for webservice and parsing
                                    classWebServices * objWebService=[[classWebServices alloc]init];
                                    objWebService.delegate=self;
                                    
                                    // call the method and pass all info i.e. body, url and soapaction
                                    [objWebService callWebServiceWithBoday:soapMsg url:url soapAction:soapAction];
                                    
                                    [objWebService release];
                                    
                                    
                                    
                                    
                                    
                                }
                                else
                                {
                                    
                                    // alert email email id do not match
                                    
                                    
                                    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Email id's do not match" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                    [alert show];
                                    [alert release];  
                                    
                                    
                                }
                                
                                
                                
                                
                            }
                            
                            
                        } 
                    }
                    else
                    {
                        
                        
                        // show alert phone no. do not match
                        
                        
                        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Phone no.'s do not match" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [alert show];
                        [alert release];  
                        
                    }
                }
            }
            
            
        }
        
        
        
    }
    
    
    
    
        
}



-(void)connectionDidFailWithError
{
    
    // remove indicator    
    [self showInidcator:NO withMessage:nil];
    
}

-(void)resultAfterParsing:(NSMutableArray *)arrayResult
{
    
    // remove indicator
    [self showInidcator:NO withMessage:nil];
    
    if([arrayResult count]==2)
    {
        
        self.objUser.memberId=[arrayResult objectAtIndex:0];
        self.objUser.password=[arrayResult objectAtIndex:1];
        
        //[classDatabaseOperations addNewUser:self.objUser];
        
        // finally add user to database            
        NSString * queryString=[NSString stringWithFormat: @"update user set memberid='%@' where userid=%d",self.objUser.memberId, self.objUser.userId];
        
       // NSLog(@"%@",queryString);
        [classDatabaseOperations add:queryString];

        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"User registered successfully !" message:[NSString stringWithFormat:@"Please note down your\nMember Id: %@\nand\nPassword: %@\n A link containing your MemberId and Password is also sent to your email id.",objUser.memberId,objUser.password] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        alert.tag=10;
        [alert show];
        [alert release];
        
        if(self.objUser.audioStatus==YES)

        {
            if(objUser.language==1)
            {
        NSMutableArray * array=[[NSMutableArray alloc] init];
        [array addObject:@"userCreatedSuccessfully"];
        
        [self.myAudioPlayer playAudios:array];
        [array release];
            }
            else if(objUser.language==2)
            {
                NSMutableArray * array=[[NSMutableArray alloc] init];
                [array addObject:@"2userCreatedSuccessfully"];
                
                [self.myAudioPlayer playAudios:array];
                [array release];
                
            }
        }
                
    }
    else
    {
        
        UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"Unable to registered user!" message:@"Please try after some time." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Retry", nil];
        alertView.tag=11;
        [alertView show];
        [alertView release];
        
        
    }
    
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(alertView.tag==10 && buttonIndex==0) // alert for new user added successfully
    {
        
        
        [self.delegate newUserAddingDidComplete];
        
    }
    else 
        if(alertView.tag==11 && buttonIndex==1) // alert for  retry adding user
        {
            
            
            [self saveUserInformation];
            
        }
    
}

- (IBAction)deleteUser:(id)sender
{
}


-(void)showInidcator:(BOOL)mode 
{
    
    [self showInidcator:mode withMessage:@"Loading..."];
    
}

-(void)showInidcator:(BOOL)mode withMessage:(NSString *)message
{
    
    
    if(mode==YES)
    {
        
        UIView * viewWithActIndicator=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        viewWithActIndicator.tag=100;
        viewWithActIndicator.alpha=0.7f;
        viewWithActIndicator.backgroundColor=[UIColor blackColor];
        
        
        UIActivityIndicatorView * indicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(140, 218, 37, 37)];        
        indicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
        [indicator startAnimating];
        [viewWithActIndicator addSubview:indicator];
        
        [indicator release];
        
        UILabel * lblLoading=[[UILabel alloc] initWithFrame:CGRectMake(132, 255, 100, 21)];
        lblLoading.text=message;
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
        
        
        UIView * myview=[self.view viewWithTag:100];
        [myview removeFromSuperview];
        
    }
    
    
    
    
}


-(void)playAudio
{
    
    
   
    
    
}





@end


