//
//  classMedicineList.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/7/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "classUser.h"
//#import "classDatabaseOperations.h"
#import "ClassAddMedicationNew.h"
//#import "classAudio.h"


@class classAudio;
@class classDatabaseOperations;
@class classUser;


@protocol protocolMedicineAddDelete

-(void)cancelAddDelete;
-(void)doneAddDelete;


@end

@interface classMedicineList : UITableViewController <UIActionSheetDelegate,addMedicineProtocol>
{
    
    classUser * objUser;
    
    
    classAudio * myAudioPlayer;
}


@property(nonatomic,retain) classUser * objUser;@property(nonatomic,retain)classAudio * myAudioPlayer;
@property(nonatomic,assign) id<protocolMedicineAddDelete>delegate;


-(void)resetMedicineList;
//-(void)deleteMedicine;
-(void)playAudio;

-(void)addNewMedicine;
-(void)cancel;

//------
-(void)methoddeleteMedicine;


@end
