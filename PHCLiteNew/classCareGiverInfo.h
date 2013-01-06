//
//  classCareGiverInfo.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 9/4/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classCareGiver.h"
//#import "classAudio.h"

@class classAudio;
@class classUser;

@protocol protocolCareGiverInfo 

-(void)careGiverInfoEnteringCancel;
-(void)careGiverInfoEnteringComelete;


@end

@interface classCareGiverInfo : UIViewController<UIAlertViewDelegate>
{
   // id<protocolCareGiverInfo>delegate;
    
    UITableView *myTableView;
    UITableViewCell *cellCareGiverEmail;
    UITableViewCell *cellCareGiverPhone;
    UITableViewCell *cellReenterEmail;
    UITableViewCell *cellReenterPhone;
    UITableViewCell *cellCareGiverName;
    UITableViewCell *cellCareGiverPhoto;
    
    classUser * objUser;
    classCareGiver *classCareGiverObj;
    UITextField *txtEmail;
    UITextField *txtPhone;
    UITextField *txtRenterEmail;
    UITextField *txtRenterPhone;
    UITextField *txtName;
    UIImageView *careGiverImage;
    
    UITableViewCell *cellInstruction;
    
    int mode;
    
    classAudio * myAudioPlayer;

    
}


-(void)cancel;
-(void)done;
-(void)saveCareGiverInfo;
-(void)updateCareGiverInfo;
-(BOOL)checkEmailIsValid;
-(BOOL)checkPhoneIsValid;
-(void)savePicture;


@property(nonatomic,assign)    id<protocolCareGiverInfo>delegate;
@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellCareGiverEmail;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellCareGiverPhone;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellReenterEmail;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellReenterPhone;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellCareGiverName;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellCareGiverPhoto;

@property(nonatomic,retain)    classUser * objUser;
@property(nonatomic,retain)classCareGiver *classCareGiverObj;


@property (nonatomic, retain) IBOutlet UITextField *txtEmail;
@property (nonatomic, retain) IBOutlet UITextField *txtPhone;
@property (nonatomic, retain) IBOutlet UITextField *txtRenterEmail;
@property (nonatomic, retain) IBOutlet UITextField *txtRenterPhone;
@property (nonatomic, retain) IBOutlet UITextField *txtName;
@property (nonatomic, retain) IBOutlet UIImageView *careGiverImage;


@property (nonatomic, retain) IBOutlet UITableViewCell *cellInstruction;

@property(nonatomic)int mode;


@property(nonatomic,retain)classAudio * myAudioPlayer;

@end
