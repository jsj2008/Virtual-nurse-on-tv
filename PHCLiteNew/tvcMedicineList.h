//
//  tvcMedicineList.h
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 9/17/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classPillBoxNew.h"
#import "classMedicineList.h"
//#import "classSynkData.h"

@class classUser;
@class classMedicine;
@class  classAudio;

@interface tvcMedicineList : UITableViewController<UIAlertViewDelegate,protocolPillBox,protocolMedicineAddDelete>

{
    int imgvalue;
    classUser * objUser;
    NSMutableArray* arrayPillBox;
    classAudio * myAudioPlayer;
    
}



-(BOOL)methodCheckMedicneFilledCompletely:(classMedicine *)objMedicine;
-(NSMutableArray *)splitMedicineAccordingToMedicineTime:(classMedicine *)objMedicine;
-(int)getArrowIndexAndPlayAudio:(BOOL)playAudio;
-(void)methodGetFlagValue;


@property(nonatomic,retain) NSMutableArray* arrayPillBox;
@property(nonatomic,retain) classUser * objUser;
@property(nonatomic,retain) classAudio * myAudioPlayer;
@property(nonatomic,assign) int imgvalue;

@end
