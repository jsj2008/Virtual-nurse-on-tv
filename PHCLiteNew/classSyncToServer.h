//
//  classSyncToServer.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/26/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classWebServices.h"

@class classAudio;
@class classUser;

@protocol protocolSynkToServer

-(void)syncToServerDidCancel;
-(void)syncToServerDidComplete;

@end

@interface classSyncToServer : UITableViewController <webServiceDelegateProtocol>
{
    
    classUser * objUser;
    //id<protocolSynkToServer>delegate;
    UIBarButtonItem * btnCancel,*btnDone;
    
    
    
    UITableViewCell *cellMemberId;
    UITableViewCell *cellPassword;
    UITableViewCell *cellEmpty;
    UITableViewCell *cellInstruction;
    UITableViewCell *cellPanhealth;
    UITextField *txtMemberId;
    UITextField *txtPassword;
    
    classAudio * myAudioPlayer;

}

-(void)showInidcator:(BOOL)mode withMessage:(NSString *)message;
-(void)saveMedicine:(classMedicine *)objMedicine;
-(void)cancel;
-(void)done;
-(void)validateUser;
-(NSString *)genrateMemberId:(NSString *) memberId;



@property (nonatomic, retain) IBOutlet UITextField *txtMemberId;
@property (nonatomic, retain) IBOutlet UITextField *txtPassword;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellMemberId;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellPassword;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellEmpty;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellInstruction;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellPanhealth;

@property(nonatomic,retain) classUser * objUser;
@property(nonatomic,assign)   id<protocolSynkToServer>delegate;
@property(nonatomic,retain)    UIBarButtonItem * btnCancel,*btnDone;
@property(nonatomic,retain)classAudio * myAudioPlayer;



@end
