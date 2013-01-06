//
//  classRefillingOption.h
//  i_strip
//
//  Created by Avi Kulkarni on 7/20/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>
//#import "classAudio.h"
#import "classCareGiverInfo.h"

@class classAudio;
@class classUser;
@interface classRefillingOption : UITableViewController <UIAlertViewDelegate,protocolCareGiverInfo>
{
    
    
    UITextField * txtFiledRefill;    
    UIBarButtonItem * btnBack;    
    NSString *strMedicineName;    
    int quantityToOrder;
    
    classAudio * myAudioPlayer;
    
    
    classUser * objUser;

    
}

@property(nonatomic,retain)UITextField * txtFiledRefill;
@property(nonatomic,retain)UIBarButtonItem * btnBack;
@property(nonatomic)int quantityToOrder;
@property(nonatomic,retain)NSString *strMedicineName;

@property(nonatomic,retain)classAudio * myAudioPlayer;
@property(nonatomic,retain)classUser * objUser;


-(void)back;
-(void)send;
-(void) sendInAppSMS:(id) sender;
-(void)playAudio;
-(void)checkCareGiverInfo;
-(void)setCareGiverInfo;
@end
