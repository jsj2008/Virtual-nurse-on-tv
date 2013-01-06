//
//  classNewUser.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 7/29/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classNewUser.h"
#import "classUser.h"
#import "classDatabaseOperations.h"
#import "commanFunctions.h"
#import "classAudio.h"
#import "classWebServices.h"
#import "classReigisterUser.h"
#import "classPicture.h"

UITextField * currentTextField;


@implementation classNewUser
@synthesize cellUserPhoto;
@synthesize imgViewUserPhoto;
@synthesize myAudioPlayer;
@synthesize objUser;
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
@synthesize arrayOfUsers;
@synthesize cellInstruction1;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        
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
    [cellInstruction1 release];
    [cellUserPhoto release];
    [imgViewUserPhoto release];
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
    self.title=@"New User";

    self.navigationItem.leftBarButtonItem=self.btnCancel;
    
    self.btnSave=[[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveUserInformation) ] autorelease];
    self.navigationItem.rightBarButtonItem=self.btnSave;
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated]; 
    if(objUser.userImage!=nil)
    {
        self.imgViewUserPhoto.image= objUser.userImage;
    }
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
    [self setCellInstruction1:nil];
    [self setCellUserPhoto:nil];
    [self setImgViewUserPhoto:nil];
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
    
    
    if(indexPath.row<7)
    {
        
        return 60;
    }
    else
    {
        return 65;
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
            
        case 3: return cellEmailId;
            break;
            
        case 4: return cellConfirmEmailId;
            break;
            
        case 5:return cellPhoneNo;
            break;
            
        case 6:return cellConfirmPhoneNo;
            break;
        
        case 7:return cellUserPhoto;
            break;

            
            
            
    }
    
    
    return cellEmpty;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        if(indexPath.row==7)
        {
            classPicture * takePicture=[[classPicture alloc] init];
            objUser=[[[classUser alloc] init] autorelease];
            
            takePicture.myAudioPlayer=self.myAudioPlayer;
            takePicture.isUserPhotoMode  = YES;
            takePicture.objUser=self.objUser;
            [self.navigationController pushViewController:takePicture animated:YES];
            [takePicture release];
            
        }
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
	
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTextField=textField;
    textField.keyboardType=UIKeyboardTypeEmailAddress;
    
    if(textField.tag==1)
    {
        [self.tblNewUsr scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
    }
    
    if(textField.tag==2)
    {
        [self.tblNewUsr scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
    }
    if(textField.tag==3)
    {
        [self.tblNewUsr scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
    }
    
    if(textField.tag==4|| textField.tag==5)
    {
       
       [self.tblNewUsr scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:11 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
     textField.keyboardType=UIKeyboardTypePhonePad;
    
    }

}



-(void)cancel
{
    
    
    [self.delegate cancelAddingNewUser];
    
}

-(void)setUserInformation:(classUser*)selectedUser
{
    
    self.txtFname.text=selectedUser.firstName;
    self.txtLName.text=selectedUser.lastName;
    
    if([selectedUser.gender isEqualToString:@"M"])
    {
        
        
        self.segmentGender.selectedSegmentIndex=0;
        
    }
    else
    {
        
        self.segmentGender.selectedSegmentIndex=1; 
        
    }
    
    
    
    
    
}

- (IBAction)saveUserInformation

{
    
    
    
    
    [currentTextField resignFirstResponder];
    [self.tblNewUsr scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
    
    
    
    if([commanFunctions checkIsValidName:txtFname.text andErrorMessage:@"First Name is invalid"])
    {
        
        
        
        if([commanFunctions checkIsValidName:txtLName.text andErrorMessage:@"Last Name is invalid"])
        {
            
        
            if([commanFunctions checkIsValidPhoneNumber:txtConfirmPhoneNo.text andErrorMessage:@"Confirmed  Phone No. is invalid"])
                {
                                
                                  
                if([txtPhoneNo.text isEqualToString:txtConfirmPhoneNo.text])
                
                    {

            if([self checkEmailIsValid])
                
            {
                
                // create new user
                objUser=[[[classUser alloc] init] autorelease];
                
                // set fname
                objUser.firstName=self.txtFname.text;
                
                //set lname
                objUser.lastName=self.txtLName.text;
                
                //set email
                
                // set gender
                if(self.segmentGender.selectedSegmentIndex==0)
                {
                    
                    objUser.gender=@"M";
                    
                }
                else
                {
                    
                    
                    objUser.gender=@"F";
                    
                }
                
                // set email
                objUser.emailId=txtEmailId.text;
                
                objUser.audioStatus=YES;
                objUser.phoneNo=txtPhoneNo.text;
                
                // finally add user to database    
                NSString *img=@"backImage1.png"; 
                NSString *queryStrin=[NSString stringWithFormat: @"insert into careGive values ('%d','%@')",objUser.userId,img];
                int m=[classDatabaseOperations add:queryStrin];
                NSLog(@"%d",m);

                NSString * queryString=[NSString stringWithFormat: @"insert into user (memberid,fname, lname, gender,emailid,phoneno,password) values ('%@','%@','%@','%@','%@','%@','%@')",objUser.memberId, objUser.firstName,objUser.lastName,objUser.gender,objUser.emailId,objUser.phoneNo,objUser.password];
                NSLog(@"%@",queryString);
                
                 [self savePicture];
                
                if([classDatabaseOperations add:queryString]==0)
                {
                    // add user in our arrayOfUsers
                    [self.arrayOfUsers addObject:objUser];
                    [self insertFlag];
                    [self arrayOfUsers];
                    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"User account created successfully !" message:@"Do you want register to Panhealth now ?? " delegate:self cancelButtonTitle:@"Not Now" otherButtonTitles:@"Register", nil];
                    alert.tag=100;
                    [alert show];
                    [alert release];
                    
//                    NSMutableArray * array=[[NSMutableArray alloc] init];
//                    [array addObject:@"done"];
//                    [self.myAudioPlayer playAudios:array];
//                    [array release];

                    
                }
                else
                {
                    
                    
                    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Unable to add new member" message:@"Error occured while creating account!, please check entered values are valid or not." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    alert.tag=101;
                    [alert show];
                    [alert release]; 
                    
                    
                    
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







-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(alertView.tag==100 ) // alert for new user added successfully, skip to userlit
    {
        
        if(buttonIndex==0)
        {
           [self.delegate doneAddingNewUser];
 
            
        }
        
        if(buttonIndex==1)
        {
            
            [self saveUserInformation1];
//          // [self saveUserInformation1];
//            classReigisterUser *objReg=[[classReigisterUser alloc]init];
//           UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:objReg];
//         [self presentModalViewController:nav animated:YES];
            
            
            
        }
    }
    
    
    if(alertView.tag==10)
    {
       
        
        [self.delegate doneAddingNewUser];

        
               
    }
    if(alertView.tag==11)
    {
        if(buttonIndex==0)
        {
            [self.delegate doneAddingNewUser];
 
            
        }
        else
        {
        [self saveUserInformation1];
    
        }

    }
    
        
}





-(void)playAudio
{
    
    
    
    
    
}


-(BOOL)checkEmailIsValid
{
    
    if([commanFunctions checkIsValidEmail:txtEmailId.text andErrorMessage:@"Email Id is invalid"]==YES)// YES for valid email
    {
        
        
        if([commanFunctions checkIsValidEmail:txtConfirmEmailId.text andErrorMessage:@"Re-entered email Id is invalid"]==YES)
        {
            
            if([txtEmailId.text isEqualToString:txtConfirmEmailId.text])
            {
                
                return YES;
                
            }
            else
            {
                
                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Email id do not match" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];  
                
            }
            
            
        }
        
        
    }
    
    
    return NO;
    
}


-(void)saveUserInformation1

{
    
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
                                   objUser=[[[classUser alloc] init] autorelease];
                                    
                                    // set fname
                                   objUser.firstName =txtFname.text;
                                                                     
                                    //set lname
                                    objUser.lastName=txtLName.text;
                                    
                                    // set gender
                                    if(self.segmentGender.selectedSegmentIndex==0)
                                    {
                                        
                                      objUser.gender=@"M";
                                        
                                    }
                                    else
                                    {
                                        
                                        
                                       objUser.gender=@"F";
                                        
                                    }
                                    
                                    // set phone number
                                    objUser.phoneNo=txtPhoneNo.text;
                                    
                                    //set email id
                                   objUser.emailId=txtEmailId.text;
                                    
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
        NSString * qery=[NSString stringWithFormat:@"select userid from user where fname='%@'and lname='%@'and emailid='%@'",self.objUser.firstName,self.objUser.lastName,self.objUser.emailId];
        
        int userid=[classDatabaseOperations get:qery];
        objUser.userId=userid;
        
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

-(void)savePicture
{
    
    if(self.imgViewUserPhoto.image!=[UIImage imageNamed:@"Placeholder.png"])
    {
        
        
        //medicine name
        NSString * imgName = [NSString stringWithFormat:@"%@%@",objUser.firstName,objUser.lastName];
        // covert Medicne image to nsdata
        NSData* imageData = UIImagePNGRepresentation(imgViewUserPhoto.image);
        
        // get path of document directory to save medicne
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString * databasePath = [documentsDir stringByAppendingPathComponent:imgName];
        
        
        
        
        // and then we write it out
        [imageData writeToFile:databasePath atomically:NO];
        
        
    }
    
    
    
}





-(void)insertFlag      
{
    NSMutableArray *arrayofuser= [classDatabaseOperations getUserList];
    
    for (int i=0;i< arrayofuser.count ;i++)
    {
        objUser=[arrayofuser objectAtIndex:i];
        if( [objUser.firstName isEqualToString:objUser.firstName])
        {
            if( [objUser.lastName isEqualToString:objUser.lastName])
            {
                
            NSString * query =[[NSString alloc] initWithFormat:@"insert  into vnscripts values ( %d,'YES','YES','YES','YES','YES','YES',1)",objUser.userId];
                [classDatabaseOperations updateFlags:query];
                [query release];


           query =[[NSString alloc] initWithFormat:@"insert  into vnscripts values ( %d,'YES','YES','YES','YES','YES','YES',2)",objUser.userId];
                [classDatabaseOperations updateFlags:query];
                [query release];


           query =[[NSString alloc] initWithFormat:@"insert  into vnscripts values ( %d,'YES','YES','YES','YES','YES','YES',3)",objUser.userId];

                [classDatabaseOperations updateFlags:query];
                [query release];


           query =[[NSString alloc] initWithFormat:@"insert  into vnscripts values ( %d,'YES','YES','YES','YES','YES','YES',4)",objUser.userId];
                [classDatabaseOperations updateFlags:query];
                
                [query release];
                
            }
        }
    }
    
    
}


@end


