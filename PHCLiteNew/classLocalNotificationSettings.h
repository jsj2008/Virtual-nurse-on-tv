 NSString *label;//
//  classLocalNotificationSettings.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/30/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classNotificaitonTimePicker.h"


@class classUser;
@class classAudio;
@interface classLocalNotificationSettings : UITableViewController <protocolTimePicker>
{
    
    UITableViewCell *cellNotification;
    UILabel *lblReminderStatus;
    UISwitch *switchOnOff;
    
    classUser * objUser;
    classAudio * myAudioPlayer;

       NSString *label;
    
}
@property (nonatomic, retain) IBOutlet UITableViewCell *cellNotification;
@property (nonatomic, retain) IBOutlet UILabel *lblReminderStatus;
@property (nonatomic, retain)  UISwitch *switchOnOff;
@property(nonatomic,retain)classAudio * myAudioPlayer;
@property(nonatomic,retain) NSString *label;
@property(nonatomic,retain) classUser * objUser;


- (void)trunOnOffNotification:(id)sender;
-(void)getCurretnNotificationStatus;


@end
