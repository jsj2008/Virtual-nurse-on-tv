//
//  classNotificaitonTimePicker.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/31/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class classUser;
@class classAudio;

@protocol protocolTimePicker

-(void)timeSelectionDidCancel;
-(void)timeSelectionDidComplete;


@end

@interface classNotificaitonTimePicker : UIViewController 
{
    
    //id<protocolTimePicker>delegate;
    
    classUser* objUser;
    int TimeSpan;
    UIDatePicker *pickerTime;
    UILabel *lblTime;
    UILabel *lblTimeSpan;
    classAudio * myAudioPlayer;

}



@property(nonatomic,assign) id<protocolTimePicker>delegate;


@property(nonatomic,retain)    classUser* objUser;
@property(nonatomic)int TimeSpan;

@property (nonatomic, retain) IBOutlet UIDatePicker *pickerTime;

@property (nonatomic, retain) IBOutlet UILabel *lblTime;
@property (nonatomic, retain) IBOutlet UILabel *lblTimeSpan;
@property(nonatomic,retain)classAudio * myAudioPlayer;

-(void)setNewTime;
-(void)resetPickerAccrodingToOldTime;
-(void)cancel;
-(void)done;

@end
