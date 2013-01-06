//
//  classSetting3.h
//  PHCLiteNew
//
//  Created by Avi Kulkarni on 16/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "editProfile.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "classReigisterUser.h"

@class editProfile;
@class classUser;

@interface classSetting3 : UITableViewController<protocolUpdateUser,protocolRegisterUser> {
        NSMutableArray *arrayFlags;
    classUser *aUser;
    NSString *imagepath;
    UIImageView *nurseImage;
    BOOL editFlag;
    classAudio * myAudioPlayer;

}
@property(nonatomic,retain) NSMutableArray *arrayFlags;
@property(nonatomic,retain) classUser *aUser;
@property(nonatomic,retain) UIImageView *nurseImage;
@property(nonatomic,retain) NSString *imagepath;
@property (nonatomic) BOOL editFlag;
@property(nonatomic,retain)classAudio * myAudioPlayer;


@end
