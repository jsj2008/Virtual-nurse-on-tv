//
//  editProfile.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 3/28/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "editProfile.h"
#import "classNewUser.h"
#import "classUser.h"
#import "classDatabaseOperations.h"
#import "commanFunctions.h"
#import "classAudio.h"
#import "classWebServices.h"
#import "classReigisterUser.h"
#import "classPicture.h"
#import "classSetting3.h"
#import "classHome.h"
UITextField * currentTextField;


@implementation editProfile
@synthesize cellUserPhoto;
@synthesize imgViewUserPhoto;
@synthesize myAudioPlayer;
@synthesize objUser,aUser;

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
@synthesize delegate;



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
    self.title=@"Edit Profile";

    // Do any additional setup after loading the view from its nib.
    
    // set title 
    
    
    // show cancel button
    self.btnCancel=[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)] autorelease];
    
    self.navigationItem.leftBarButtonItem=self.btnCancel;
    
    self.btnSave=[[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveUserInformation)] autorelease];
    self.navigationItem.rightBarButtonItem=self.btnSave;
  
        [txtFname setText:aUser.firstName];
        [txtLName setText:aUser.lastName];
        [txtEmailId setText:aUser.emailId];
        [txtConfirmEmailId setText:aUser.emailId];
        [txtPhoneNo setText:aUser.phoneNo];
        [txtConfirmPhoneNo setText:aUser.phoneNo];


    if([aUser.gender isEqualToString:@"M"])
        [segmentGender setSelectedSegmentIndex:0];
    else
        [segmentGender setSelectedSegmentIndex:1];
       
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (aUser.userImage!=nil)
    {
        self.imgViewUserPhoto.image=aUser.userImage;
        
    }
    [txtFname setText:aUser.firstName];
    [txtLName setText:aUser.lastName];
    [txtEmailId setText:aUser.emailId];
    [txtConfirmEmailId setText:aUser.emailId];
    [txtPhoneNo setText:aUser.phoneNo];
    [txtConfirmPhoneNo setText:aUser.phoneNo];
  }



-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    // reset
    /*   componentOneValue=0;
     componentTwoValue=0;
     componentThreeValue=0;
     
     [self setBPFromComponent1:componentOneValue Component2:componentTwoValue Component3:componentThreeValue];
     
     */
    
    //[self.PickerWeight reloadAllComponents];
    
    
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
        return 55;
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
            
        case 7:
            return cellUserPhoto;
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
            //objUser=[[[classUser alloc] init] autorelease];
            
            takePicture.myAudioPlayer=self.myAudioPlayer;
            takePicture.isUserPhotoMode  = YES;
            takePicture.objUser=aUser;
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
  [[self navigationController] popViewControllerAnimated:YES ];
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
                        NSString * queryString=[NSString stringWithFormat: @"update user  set fname='%@', lname='%@', gender='%@',emailid='%@',phoneno='%@' where userid=%d", objUser.firstName,objUser.lastName,objUser.gender,objUser.emailId,objUser.phoneNo,aUser.userId];
                        NSLog(@"%@",queryString);
                        
                          //[self savePicture];
                        [self deleteUserPhoto];
                        
                        if([classDatabaseOperations add:queryString]==0)
                        {
                            // add user in our arrayOfUsers
                            [self.arrayOfUsers addObject:objUser];
                            NSLog(@"User Array %@ ",self.arrayOfUsers);

                            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"User account updated successfully !" message:@"Your account update successfully " delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
                            alert.tag=100;
                            [alert show];
                            [alert release];
                            
                            NSMutableArray * array=[[NSMutableArray alloc] init];
                            [array addObject:@"done"];
                            [self.myAudioPlayer playAudios:array];
                            [array release];
                            
                            // update our objUser Object too
                            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                            
                            [defaults setObject:txtFname.text forKey:@"firstName"];
                            [defaults setObject:txtLName.text forKey:@"lastname"];
                            [defaults setObject:txtEmailId.text forKey:@"email"];
                            [defaults setObject:txtPhoneNo.text forKey:@"phoneNo"];
                            
                            [defaults synchronize];
                            aUser.firstName=objUser.firstName;
                            aUser.lastName=objUser.lastName;
                            aUser.gender=objUser.gender;
                            aUser.emailId=objUser.emailId;
                            aUser.phoneNo=objUser.phoneNo;
                           // self.objUser.conf=aUser.phoneNo;
                            NSLog(@"aUser.firstName %@ ",self.objUser.firstName);
                            NSLog(@"aUser.lastName %@ ",self.objUser.lastName);
                            NSLog(@"aUser.emailId %@ ",self.objUser.emailId);
                            NSLog(@"aUser.phoneNo %@ ",self.objUser.phoneNo);
                            [self savePicture];
                            NSLog(@"newusername%@%@",objUser.firstName,objUser.lastName);
                        }
                        else
                        {
                            
                            
                            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Unable to update new member" message:@"Error occured while updating account!, please check entered values are valid or not." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
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
        [self.delegate userUpdatingDidComplete];
}
    
    
    if(alertView.tag==10)
    {
        
        
       // [self.delegate doneAddingNewUser];
        
        
        
    }
    if(alertView.tag==11)
    {
        if(buttonIndex==0)
        {
         //  [self.delegate doneAddingNewUser];
            
            
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



-(void)savePicture
{
    if(self.imgViewUserPhoto.image!=[UIImage imageNamed:@"Placeholder.png"])
    {
        
        
        //medicine name
        NSString * imgName = [NSString stringWithFormat:@"%@%@",self.objUser.firstName,self.objUser.lastName];
        // covert Medicne image to nsdata
        //NSData* imageData = UIImagePNGRepresentation( self.objUser.userImage);
        NSData *imageData = [[NSData alloc]initWithData:UIImagePNGRepresentation(self.objUser.userImage)];

        // get path of document directory to save medicne
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString * databasePath = [documentsDir stringByAppendingPathComponent:imgName];
        
        
        
        
        // and then we write it out
        [imageData writeToFile:databasePath atomically:NO];
        
        
    }
}

-(void)deleteUserPhoto
{
    NSString * imgName = [NSString stringWithFormat:@"%@%@",aUser.firstName,aUser.lastName];    //            // covert Medicne image to nsdata
    //                      
    //            // get path of document directory to delete medicne
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString * documentImagePth = [documentsDir stringByAppendingPathComponent:imgName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:documentImagePth error:nil];
    
    
    
}

-(void)saveUserInformation1
{
    
}
-(void)showInidcator:(BOOL)mode withMessage:(NSString *)message
{
    
}


@end
