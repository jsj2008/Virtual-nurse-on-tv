//
//  classSyncToServerTaekeMed.h
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 16/01/12.
//  Copyright 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classWebServices.h"
#import "classCompartmentData.h"
@class classAudio;
@class classUser;

@protocol protocolSynkToServerTakeMed1

-(void)syncToServerDidCancelTakMed;
-(void)syncToServerDidCompleteTakMed;

@end


@interface   classSyncTrackerData : UITableViewController<webServiceDelegateProtocol> {
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
    
    NSMutableArray * arrayTakeMed;
    NSMutableString *strArrayTakemed;
    
    
}

-(void)showInidcator:(BOOL)mode withMessage:(NSString *)message;
-(void)saveMedicine:(classCompartmentData *)objMedicine;
-(void)cancel;
-(void)done;
-(void)validateUser;
-(NSString *)genrateMemberId:(NSString *) memberId;
-(void)getTableTakeMed;
-(void)saveMedicineArray;


@property (nonatomic, retain) IBOutlet UITextField *txtMemberId;
@property (nonatomic, retain) IBOutlet UITextField *txtPassword;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellMemberId;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellPassword;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellEmpty;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellInstruction;
@property (nonatomic, retain) IBOutlet UITableViewCell *cellPanhealth;

@property(nonatomic,retain) classUser * objUser;
@property(nonatomic,assign)   id<protocolSynkToServerTakeMed1>delegate;
@property(nonatomic,retain)    UIBarButtonItem * btnCancel,*btnDone;
@property(nonatomic,retain)classAudio * myAudioPlayer;
@property(nonatomic,retain)NSMutableArray * arrayTakeMed;
@property(nonatomic,retain) NSMutableString *strArrayTakemed;

@end
