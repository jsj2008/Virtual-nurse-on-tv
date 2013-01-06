//
//  classReigisterUser.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/27/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classWebServices.h" 
//#import "classAudio.h"

@class classUser;
@class classAudio;

@protocol protocolRegisterUser

-(void)newUserAddingDidComplete;
-(void)newUserAddingDidCancel;

@end


@interface classReigisterUser : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,webServiceDelegateProtocol>
{
    
  //  id<protocolRegisterUser>delegate;
    UITableViewCell *cellInstruction;
    
   UITableView *tblNewUsr;
    UITextField *txtFname;
    UITextField *txtLName;
    UISegmentedControl *segmentGender;
    UITextField *txtEmailId;
    UITextField *txtPhoneNo;
    UITextField *txtConfirmEmailId;
    UITextField *txtConfirmPhoneNo;
    IBOutlet UITextField *txtPassword;
    UITextField *txtConfirmPassword;
    UIBarButtonItem *btnBarDelete;
    UIBarButtonItem *btnBarUpdate;
    UIBarButtonItem *btnBarSave;
    UIBarButtonItem *btnBarCancel;
    UITableViewCell *cellFirstName;
    UITableViewCell *cellLastName;
    UITableViewCell *cellGender;
    UITableViewCell *cellEmailId;
    UITableViewCell *cellPhoneNo;
    UITableViewCell *cellPasswrod;
    UITableViewCell *cellConfirmEmailId;
    UITableViewCell *cellConfirmPhoneNo;
    UITableViewCell *cellConfirmPassword;
    UITableViewCell *cellEmpty;    
    UIBarButtonItem * btnCancel,*btnSave;
    UILabel *cellPanhealth;
    UITableViewCell *cellPanhealth1;
    
    
    BOOL isNewUser;
    classUser * objUser;
    
    
    UIBarButtonItem *saveUserInformation;
    
    
    classAudio * myAudioPlayer1;
    NSMutableArray * arrayOfSoundFileNames;
    
}

@property (nonatomic,assign)  id<protocolRegisterUser>delegate;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellInstruction;
@property (nonatomic, retain) IBOutlet UITableView *tblNewUsr;
@property (nonatomic, retain) IBOutlet UITextField *txtFname;
@property (nonatomic, retain) IBOutlet UITextField *txtLName;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentGender;
@property (nonatomic, retain) IBOutlet UITextField *txtEmailId;
@property (nonatomic, retain) IBOutlet UITextField *txtPhoneNo;
@property (nonatomic, retain) IBOutlet UITextField *txtConfirmEmailId;
@property (nonatomic, retain) IBOutlet UITextField *txtConfirmPhoneNo;
@property (nonatomic, retain) IBOutlet UITextField *txtConfirmPassword;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *btnBarDelete;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *btnBarUpdate;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *btnBarSave;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *btnBarCancel;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellFirstName;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellLastName;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellGender;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellEmailId;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellPhoneNo;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellPasswrod;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellConfirmEmailId;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellConfirmPhoneNo;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellConfirmPassword;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellEmpty;
@property(nonatomic,retain) UIBarButtonItem * btnCancel, *btnSave;
@property (nonatomic, retain) IBOutlet UILabel *cellPanhealth;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellPanhealth1;
@property(nonatomic) BOOL isNewUser;
@property(nonatomic,retain)classUser * objUser;
@property(nonatomic,retain)classAudio * myAudioPlayer1;
@property(nonatomic,retain)NSMutableArray * arrayOfSoundFileNames;


-(void)setUserInformation:(classUser*)selectedUser;
-(void)cancel;


- (IBAction)saveUserInformation;
- (IBAction)deleteUser:(id)sender;
-(void)showInidcator:(BOOL)mode withMessage:(NSString *)message;
-(void)playAudio;


@end
