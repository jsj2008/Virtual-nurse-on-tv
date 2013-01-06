//
//  classNewUser.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 7/29/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classWebServices.h"
@class classUser;

@protocol protocolAddUser

-(void)doneAddingNewUser;
-(void)cancelAddingNewUser;

@end

@class classAudio;
@interface classNewUser : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,webServiceDelegateProtocol>
{
    
   // id<userProtocol>delegate;
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
    
    
    NSMutableArray * arrayOfUsers;
    
    UIBarButtonItem *saveUserInformation;    
    UITableViewCell *cellInstruction1;
    
    classAudio * myAudioPlayer;
    classUser * objUser;




}

@property (nonatomic,assign)  id<protocolAddUser>delegate;

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
@property(nonatomic,retain)    NSMutableArray * arrayOfUsers; 
@property (nonatomic, retain) IBOutlet UITableViewCell *cellInstruction1;

@property(nonatomic,retain)classUser * objUser;

@property(nonatomic,retain)classAudio * myAudioPlayer;

-(void)setUserInformation:(classUser*)selectedUser;
-(void)saveUserInformation1;

-(void)cancel;
- (IBAction)saveUserInformation;
-(void)playAudio;
-(BOOL)checkEmailIsValid;
-(void)showInidcator:(BOOL)mode withMessage:(NSString *)message;
-(void)saveUserInformation1;

@property (retain, nonatomic) IBOutlet UITableViewCell *cellUserPhoto;
@property (retain, nonatomic) IBOutlet UIImageView *imgViewUserPhoto;
-(void)savePicture;
-(void)insertFlag;
@end
