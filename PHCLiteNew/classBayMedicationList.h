//
//  classBayMedicationList.h
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 29/11/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class classCompartmentData;
@class classUser;
@class classAudio;
@interface classBayMedicationList : UITableViewController {
    
    
   classAudio * myAudioPlayer;

    NSMutableArray *arrayMed;
    
    classCompartmentData *objMed;

    NSString * strSpan;
    
    int userid;
    
    int bayno;
    classUser * objUser;
    
}

@property(nonatomic,assign)    NSMutableArray *arrayMed;
@property(nonatomic,assign)      classCompartmentData *objMed;;
@property(nonatomic,retain)     NSString * strSpan;
@property(nonatomic,assign)        int userid;
@property(nonatomic,assign)        int bayno;
@property(nonatomic,retain)    classUser * objUser;
@property(nonatomic,retain)classAudio * myAudioPlayer;


-(void)done;




@end
