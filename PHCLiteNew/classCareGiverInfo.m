//
//  classCareGiverInfo.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 9/4/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classCareGiverInfo.h"
#import "classUser.h"
#import "classDatabaseOperations.h"
#import "commanFunctions.h"
#import "classAudio.h"
#import "classPicture.h"

#define newInfo 1
#define updateInfo 2


@implementation classCareGiverInfo
@synthesize myTableView;
@synthesize cellCareGiverEmail;
@synthesize cellCareGiverPhone;
@synthesize cellReenterEmail;
@synthesize cellReenterPhone;
@synthesize cellCareGiverName;
@synthesize cellCareGiverPhoto;
@synthesize careGiverImage;
@synthesize delegate=_delegate;
@synthesize objUser;
@synthesize txtEmail;
@synthesize txtPhone;
@synthesize txtRenterEmail;
@synthesize txtRenterPhone;
@synthesize cellInstruction;
@synthesize mode;
@synthesize myAudioPlayer;
@synthesize classCareGiverObj;
@synthesize txtName;
UITextField * currentTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [myTableView release];
    [cellCareGiverEmail release];
    [cellCareGiverPhone release];
    [cellReenterEmail release];
    [cellReenterPhone release];
    [txtEmail release];
    [txtPhone release];
    [txtRenterEmail release];
    [txtRenterPhone release];
    [cellInstruction release];
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
    
    // show cancel button
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancel) ] autorelease];
    
    if(objUser.careGiverEmail!=nil && objUser.CareGiverPhone!=nil)
    {
        self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStyleDone target:self action:@selector(saveCareGiverInfo) ] autorelease];
        
        self.txtEmail.text=objUser.careGiverEmail;
        self.txtPhone.text=objUser.CareGiverPhone;
        
        
        if(objUser.audioStatus==YES)
        {
            if(objUser.language==1)
            {
        NSMutableArray * array=[[NSMutableArray alloc] init];
        [array addObject:@"updateCareGiverInfo"];
        
        [self.myAudioPlayer playAudios:array];
        [array release];
            }
            
            else if(objUser.language==2)
            {
                NSMutableArray * array=[[NSMutableArray alloc] init];
                [array addObject:@""];
                
                [self.myAudioPlayer playAudios:array];
                [array release];

                
                
            }

        }
        
    }
    else        
    {
        
        self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveCareGiverInfo) ] autorelease];
        
        
        if(objUser.audioStatus==YES)
        {
            if(objUser.language==1)
            {
        NSMutableArray * array=[[NSMutableArray alloc] init];
        [array addObject:@"PleasesEnterCareGiverInfo"];
        
        [self.myAudioPlayer playAudios:array];
        [array release];
            }
            
            else if(objUser.language==2)
            {
                
                NSMutableArray * array=[[NSMutableArray alloc] init];
                [array addObject:@""];
                
                [self.myAudioPlayer playAudios:array];
                [array release];
                
            }
        
        }
        
    }

    
    NSLog(@"upate userid:%d",objUser.userId);
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (classCareGiverObj.caregiverImage!=nil)
    {
        careGiverImage.image=classCareGiverObj.caregiverImage;
        
    }
}


- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [self setCellCareGiverEmail:nil];
    [self setCellCareGiverPhone:nil];
    [self setCellReenterEmail:nil];
    [self setCellReenterPhone:nil];
    [self setTxtEmail:nil];
    [self setTxtPhone:nil];
    [self setTxtRenterEmail:nil];
    [self setTxtRenterPhone:nil];
    [self setCellInstruction:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
	[textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTextField=textField;
    textField.keyboardType=UIKeyboardTypeDefault;
    
    if(textField.tag==1)
    {
        [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
    }
    
    if(textField.tag==2)
    {
        [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
        textField.keyboardType=UIKeyboardTypeEmailAddress;

    }
    if(textField.tag==3)
    {
        [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
        textField.keyboardType=UIKeyboardTypeEmailAddress;

    }
    
    if(textField.tag==4|| textField.tag==5)
    {
        
        [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
        textField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
        
    }
    
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
    return 7;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(indexPath.row<5 || indexPath.row==5)
    {
        
        return 60;
    }
    else
    {
        return 80;
    }
   
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    switch (indexPath.row)
    {
        case 0: return cellCareGiverName;
            break;
            
        case 1: return cellCareGiverEmail;
            break;
            
        case 2: return cellReenterEmail;
            break;
            
        case 3: return cellCareGiverPhone;
            break;
            
        case 4: return cellReenterPhone;
            break;
        
        case 5: return cellCareGiverPhoto;
            break;
                   
        case 6: return cellInstruction;
            break;
        
            
    }
    
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        if(indexPath.row==5)
        {
            classPicture * takePicture=[[classPicture alloc] init];
          //  objUser=[[[classUser alloc] init] autorelease];
            classCareGiverObj=[[[classCareGiver alloc] init]autorelease ];

            takePicture.myAudioPlayer=self.myAudioPlayer;
            takePicture.isUserPhotoMode  = YES;
           takePicture.classCareGiverobj=self.classCareGiverObj;
            [self.navigationController pushViewController:takePicture animated:YES];
            [takePicture release];
            
        }
    }
}


-(void)cancel
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)done
{
    
    
    [self.delegate careGiverInfoEnteringComelete];  
    
}

-(void)savePicture
{
    
    if(careGiverImage.image!=[UIImage imageNamed:@"Placeholder.png"])
    {
        
        
        //medicine name
        NSString * imgName = [NSString stringWithFormat:@"%@",txtName.text];
        // covert Medicne image to nsdata
        NSData* imageData = UIImagePNGRepresentation(careGiverImage.image);
        
        // get path of document directory to save medicne
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString * databasePath = [documentsDir stringByAppendingPathComponent:imgName];
        
        
        
        
        // and then we write it out
        [imageData writeToFile:databasePath atomically:NO];
        
        
    }
    
    
    
}

-(void)saveCareGiverInfo
{
    
    [currentTextField resignFirstResponder];
    [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
    if([commanFunctions checkIsValidName:txtName.text andErrorMessage:@"Name is invalid"])
    {
       if([self checkEmailIsValid])
        {
            
            if([self checkPhoneIsValid])
            {
                
                classCareGiverObj=[[[classCareGiver alloc] init] autorelease];
                classCareGiverObj.caregiverImage=careGiverImage.image;
                classCareGiverObj.phoneNo=txtPhone.text;
                classCareGiverObj.emailId=txtEmail.text;
                classCareGiverObj.Name=txtName.text;
                NSString *queryStrin=[NSString stringWithFormat: @"insert into newCareGiver (userId,careImg, careGiverPhone, careGiverEmail,name) values (%d,'%@','%@','%@','%@')",objUser.userId,txtName.text,txtPhone.text,txtEmail.text,txtName.text];
                NSLog(@"Query %@",queryStrin);
                int m=[classDatabaseOperations add:queryStrin];
                NSLog(@"%d",m);
                [self savePicture];
                
   
                        
                        if(m==0)
                        {
                          
                            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Added" message:@"CareGiver Added  successfully " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                            alert.tag=100;
                            [alert show];
                            [alert release];
                            
                            NSMutableArray * array=[[NSMutableArray alloc] init];
                            [array addObject:@"done"];
                            [self.myAudioPlayer playAudios:array];
                            [array release];
                            
                            
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

-(void)updateCareGiverInfo
{
    
    
    if([commanFunctions checkIsValidName:txtName.text andErrorMessage:@" Name is invalid"])
    {
    if([self checkEmailIsValid])
    {
        
        if([self checkPhoneIsValid])
        {
            
            // finally add user to database            
            NSString * queryString=[NSString stringWithFormat: @"update user set caregiveremail='%@' ,caregiverphone='%@' where userid=%d",txtEmail.text,txtPhone.text, self.objUser.userId];
            
            NSLog(@"%@",queryString);
            
            int  Result=[classDatabaseOperations add:queryString];
            NSLog(@"%d",Result);
            
            if(Result==0)
            {
                
                self.objUser.careGiverEmail=self.txtRenterEmail.text;
                self.objUser.CareGiverPhone=self.txtRenterPhone.text;
               
                if(mode==newInfo)
                {
                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Caregiver information saved successfully !" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                alert.tag=195;
                    
                [alert show];
                [alert release];
                    
                    
                    if(objUser.audioStatus==YES)
                    {
                        if(objUser.language==1)
                        {
                        
                    NSMutableArray * array=[[NSMutableArray alloc] init];
                    [array addObject:@"careGiverInfoSaved"];
                    
                    [self.myAudioPlayer playAudios:array];
                    [array release];
                        }
                        else if(objUser.language==2)
                        {
                            
                            NSMutableArray * array=[[NSMutableArray alloc] init];
                            [array addObject:@""];
                            
                            [self.myAudioPlayer playAudios:array];
                            [array release];

                            
                        }
                            
                    
                    }
                    
                    
                    
                }
                else
                {
                    
                    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Caregiver information updated successfully !" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    alert.tag=195;
                    [alert show];
                    [alert release];

                    
                    if(objUser.audioStatus==YES)
                    
                    {
                        if(objUser.language==1)
                        {
                            
                        
                    NSMutableArray * array=[[NSMutableArray alloc] init];
                    [array addObject:@"careGiverInfoUpdated"];
                    
                    [self.myAudioPlayer playAudios:array];
                    [array release];
                        }
                        
                        else if(objUser.language==2)
                        {
                            NSMutableArray * array=[[NSMutableArray alloc] init];
                            [array addObject:@"careGiverInfoUpdated"];
                            
                            [self.myAudioPlayer playAudios:array];
                            [array release];
                            
                            
                        }
                    
                    }
                }
                
            }
            else
            {
                
                
                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Unable to update Caregiver information." message:@"Error occured while updating!, please check entered values are valid or not." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                alert.tag=100;
                [alert show];
                [alert release]; 
                
                
                
            }
            
            
        }
        
    }    
    
    
    }
    
    
    
    
}





-(BOOL)checkEmailIsValid
{
    
    if([commanFunctions checkIsValidEmail:txtEmail.text andErrorMessage:@"Email Id is invalid"]==YES)// YES for valid email
    {
        
        
        if([commanFunctions checkIsValidEmail:txtRenterEmail.text andErrorMessage:@"Reentered email Id is invalid"]==YES)
        {
            
            if([txtEmail.text isEqualToString:txtRenterEmail.text])
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

-(BOOL)checkPhoneIsValid
{
    
    if([commanFunctions checkIsValidPhoneNumber:txtPhone.text andErrorMessage:@"Phone number is invalid"]==YES)// YES for valid phone
    {
        
        
        if([commanFunctions checkIsValidPhoneNumber:txtRenterPhone.text andErrorMessage:@"Reentered number is invalid"]==YES)// YES for valid phone
        {
            
            if([txtEmail.text isEqualToString:txtRenterEmail.text])
            {
                
                return YES;
                
            }
            else
            {
                
                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Phone number do not match" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];  
                
            }
            
            
        }
        
        
    }
    
    
    return NO;
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(alertView.tag==195)
    {
        
        if(buttonIndex==0)// for ok
        {
            
            [self.delegate careGiverInfoEnteringComelete];
            
        }
        
    }
    
}


@end
