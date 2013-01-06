//
//  classSynkData.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/9/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classSyncToPhone.h"
#import "classReigisterUser.h"
#import "classSyncToServer.h"
#import "classAudio.h"
#import "classSyncToServerTaekeMed.h"
#import "ClassConnectToPanHealth.h"
#import "classSyncTrackerData.h"
@class classUser;
@class classAudio;


@protocol protocolSyncComplete

-(void)methodSyncComplete;

@end

@interface classSynkData : UITableViewController <protocolDownloadMedicine,protocolRegisterUser,protocolSynkToServer,UIAlertViewDelegate,protocolSynkToServerTakeMed,protocolConnectToPanHealth,protocolSynkToServerTakeMed1>
{
    
    
    classUser * objUser;
    classAudio * myAudioPlayer;

    
}


@property(nonatomic,retain) classUser * objUser;
@property(nonatomic,retain)classAudio * myAudioPlayer;

@property(nonatomic,assign)id<protocolSyncComplete>delegate;

-(void)checkUserDidRegistered;

@end
