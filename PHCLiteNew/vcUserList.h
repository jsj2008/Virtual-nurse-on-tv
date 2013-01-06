//
//  vcUserList.h
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 9/15/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classNewUser.h"
#import "classDeleteMember.h"
#import "classMesureGlucose1.h"
#import "classUser.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
@class classAudio;

@interface vcUserList : UITableViewController <protocolAddUser,protocolDeleteMember,UIActionSheetDelegate>
{
    
    NSMutableArray * arrayOfUsers;
    NSMutableArray *arrayFlags;
    NSMutableArray *arrayofControllers;
    UINavigationController *navC;
    UINavigationController *nav1;
    UINavigationController *nav2;
    UINavigationController *nav3;
    UINavigationController *nav4;
   UINavigationController *nav5;
    NSString *str1;
    
    NSString *str2;
    NSString *str3;
    NSString *str4;
    NSString *language;
    NSString *audiosatus;
    classAudio * myAudioPlayer;
    classMesureGlucose1 *objMesureGlucose;
    NSString *mediaPath;
    SystemSoundID soundID;

}
-(void)methodGetUserListFromDatabase;
-(void)methodAddNewMember;
-(void)methodDeleteMember;
-(void)setArrayOfUsers:(NSMutableArray *)newArray;
-(void)customAudio;


@property(nonatomic,retain)classAudio * myAudioPlayer;
@property(nonatomic,retain) NSMutableArray * arrayOfUsers;
@property(nonatomic,retain)UINavigationController *navC;
@property(nonatomic,retain)     classMesureGlucose1 *objMesureGlucose;
@property(nonatomic,retain)    UINavigationController *nav1;
@property(nonatomic,retain)    UINavigationController *nav2;
@property(nonatomic,retain)    UINavigationController *nav3;
@property(nonatomic,retain)    UINavigationController *nav4;
@property(nonatomic,retain)    UINavigationController *nav5;
@property(nonatomic,retain) NSMutableArray *arrayofControllers;
@property(nonatomic,retain) NSMutableArray *arrayFlags;
@property(nonatomic,retain)classUser * aUser;

@end
