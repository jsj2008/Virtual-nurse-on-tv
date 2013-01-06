//
//  classSyncToPhone.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/26/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classWebServices.h"
//#import "classAudio.h"



@protocol protocolDownloadMedicine

-(void)medicineDownloadingComplete;
-(void)medicineDownloadingCancel;

@end

@class classUser;
@class classAudio;

@interface classSyncToPhone : UIViewController <webServiceDelegateProtocol,UIAlertViewDelegate,UIAlertViewDelegate>
{
    
    //id<protocolDownloadMedicine>deletate;
    classUser *  objUser;
    UIBarButtonItem * btnCancel,* btnDone;
    
    UITableViewCell *cellPasswrod;
    UITableViewCell *cellMemberId;
    UITableViewCell *cellEmpty;
    UITableViewCell *cellInstruction;
    UITableViewCell *cellPanhealth;
    UITextField *txtPassword;
    UITextField *txtMemberId;
    UITableView *myTableView;
    
    classAudio * myAudioPlayer;

}
@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellPasswrod;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellMemberId;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellEmpty;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellInstruction;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellPanhealth;
@property (nonatomic, retain) IBOutlet UITextField *txtPassword;
@property (nonatomic, retain) IBOutlet UITextField *txtMemberId;

-(NSString *)genrateMemberId:(NSString *) memberId;
-(void)showInidcator:(BOOL)mode withMessage:(NSString *)message;
-(void)validateUser;

@property(nonatomic,retain)    classUser *  objUser;
@property(nonatomic,assign)    id<protocolDownloadMedicine>deletate;
@property(nonatomic,retain)    UIBarButtonItem * btnCancel,* btnDone;
@property(nonatomic,retain)classAudio * myAudioPlayer;



@end
