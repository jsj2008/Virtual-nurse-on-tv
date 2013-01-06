//
//  RemoteScreenView.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 1/6/13.
//  Copyright (c) 2013 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classUser.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "PHCLiteNewAppDelegate.h"
#import "SetTopBox.h"
#import "UverseConnectedManager.h"
#import "uveErrors.h"
#import "uveRemoteButtonCommand.h"
#import "uveTuneToChannelNumberCommand.h"
#import "uveTuneToURLCommand.h"
@class classAudio;
@interface RemoteScreenView : UIViewController
{
    UINavigationController *navC,*nav1,*nav2,*nav3,*nav4,*nav5;
    classUser * aUser;
    NSMutableArray * arrayOfUsers;
    NSMutableArray *arrayofControllers;
    NSString *language;
    NSString *audiosatus;
    classAudio * myAudioPlayer;
    NSMutableArray *arrayFlags;
  
}
@property(nonatomic,retain)classUser * aUser;
@property(nonatomic,retain)    UINavigationController *nav1;
@property(nonatomic,retain)    UINavigationController *nav2;
@property(nonatomic,retain)    UINavigationController *nav3;
@property(nonatomic,retain)    UINavigationController *nav4;
@property(nonatomic,retain)    UINavigationController *nav5;
@property(nonatomic,retain) NSMutableArray *arrayofControllers;
@property(nonatomic,retain)classAudio * myAudioPlayer;
@property(nonatomic,retain)UINavigationController *navC;
@property(nonatomic,retain) NSMutableArray *arrayFlags;
@property(nonatomic,retain) NSMutableArray * arrayOfUsers;
-(IBAction)ButtonTapMethod:(id)sender;
-(void)methodGetUserListFromDatabase;
-(void)setArrayOfUsers:(NSMutableArray *)newArray;
-(void)connectToReceiver;

@end
