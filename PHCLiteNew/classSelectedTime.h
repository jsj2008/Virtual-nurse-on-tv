//
//  classSelectedTime.h
//  i_strip
//
//  Created by Avi Kulkarni on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "classMedicine.h"
//#import "classTimePicker.h"
//#import "classMedicineTime.h"
//#import "classTimeAndQuantityPicker.h"
//#import "classAudio.h"
//#import "classUser.h"


@class classUser;
@class classAudio;
@class classTimeAndQuantityPicker;
@class classMedicineTime;
@class classTimePicker;
@class classMedicine;


@interface classSelectedTime : UITableViewController 
{
	
	classMedicine * objMedicine;    
    classMedicine * objMedicineLocal;
    
    
    UIDatePicker *datePicker;
    UIPickerView *simplePicker; 
    
    classAudio * myAudioPlayer;
    classUser * objUser;

}

@property(nonatomic,retain)	classMedicine * objMedicine,* objMedicineLocal;

@property(nonatomic,retain)   UIDatePicker *datePicker;
@property(nonatomic,retain)classAudio * myAudioPlayer;
@property(nonatomic,retain)    classUser * objUser;


-(void)done;
-(void)cancel;
-(void)initializeLocalMedicineObject;

-(void)showPicker;
-(void)resetPicker;

@end
