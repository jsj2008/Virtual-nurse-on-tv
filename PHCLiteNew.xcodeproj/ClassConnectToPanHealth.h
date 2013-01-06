//
//  ClassConnectToPanHealth.h
//  PHCLiteNew
//
//  Created by Avi Kulkarni on 09/06/12.
//  Copyright 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classWebServices.h"
#import "classCompartmentData.h"
@class classAudio;
@class classUser;

@protocol protocolConnectToPanHealth

-(void)ConnToPanHealthDidCancelTakMed;

-(void)ConnToPanHealthDidCompleteTakMed;

@end



@interface ClassConnectToPanHealth : UITableViewController<webServiceDelegateProtocol,UIAlertViewDelegate> {
    
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
@property (nonatomic, retain) IBOutlet UITextField *txtMemberId;
@property (nonatomic, retain) IBOutlet UITextField *txtPassword;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellMemberId;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellPassword;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellEmpty;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellInstruction;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellPanhealth;

@property(nonatomic,retain) classUser * objUser;
@property(nonatomic,assign)   id<protocolConnectToPanHealth>delegate;
@property(nonatomic,retain)    UIBarButtonItem * btnCancel,*btnDone;

@property(nonatomic,retain)classAudio * myAudioPlayer;

-(void)showInidcator:(BOOL)mode withMessage:(NSString *)message;
//-(void)saveMedicine:(classCompartmentData *)objMedicine;
-(void)cancel;
-(void)done;
-(void)validateUser;
-(NSString *)genrateMemberId:(NSString *) memberId;
-(void)getTableTakeMed;
-(void)saveMedicineArray;
@end
