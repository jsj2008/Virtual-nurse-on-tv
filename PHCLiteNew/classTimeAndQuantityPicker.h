//
//  classTimeAndQuantityPicker.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/6/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "classMedicine.h"
//#import "classMedicineTime.h"
//#import "classAudio.h"
//#import "classUser.h"

@class classUser;
@class classAudio;
@class classMedicineTime;
@class classMedicine;

@interface classTimeAndQuantityPicker : UIViewController <UIPickerViewDelegate>
{
    
    classMedicine * objMedicine;
    
    int timeNumber;
    NSArray * arrayQuantityInNumber,*arrayQuantityFormated;
    
    UIDatePicker *datePicker;
    UIPickerView *simplePicker;
    UILabel *lblDoseNumber;
    UILabel *lblTime;
    UILabel *lblPillQuantity;
    
    classAudio * myAudioPlayer;
    
    classUser * objUser;
    
    
    

    
}

@property(nonatomic,retain)classMedicine * objMedicine;
@property(nonatomic) int timeNumber;
@property(nonatomic,retain)NSArray * arrayQuantityInNumber,*arrayQuantityFormated;

@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet UIPickerView *simplePicker;
@property (nonatomic, retain) IBOutlet UILabel *lblDoseNumber;
@property (nonatomic, retain) IBOutlet UILabel *lblTime;
@property (nonatomic, retain) IBOutlet UILabel *lblPillQuantity;

@property(nonatomic,retain)classAudio * myAudioPlayer;
@property(nonatomic,retain)    classUser * objUser;




-(void)resetPiker;
-(void)done;
-(void)cancel;
-(BOOL)validateSelectedTime:(NSString *)selectedTime;
-(void)playAudio;

@end
