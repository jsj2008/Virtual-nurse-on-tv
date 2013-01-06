//
//  classLanguage.h
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 16/12/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class classUser;
@class classAudio;

@interface classLanguage : UITableViewController {
    
    UISwitch *swhAudioSat;

    UISwitch *swhEnglish;
    UISwitch *swhGujarati;
    UISwitch *swhMarathi;
    classUser*objUser;
    
    classAudio * myAudioPlayer;

}

@property(nonatomic,retain)    UISwitch *swhEnglish;

@property(nonatomic,retain)       UISwitch *swhGujarati;

@property(nonatomic,retain)          UISwitch *swhAudioSat;

@property(nonatomic,retain)          UISwitch *swhMarathi;

@property(nonatomic,retain)    classUser*objUser;

@property(nonatomic,retain)    classAudio * myAudioPlayer;

-(void)GujaratiOnOffAudio:(id)sender;
-(void)trunOnOffAudio:(id)sender;
-(void)englishOnOffAudio:(id)sender;
-(NSString *)getAudioStatus;
-(void)getLangStatus;

@end
