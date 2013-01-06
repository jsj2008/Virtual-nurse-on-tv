//
//  classTotalQuantity.h
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


@protocol totalQuantityProtocol

-(void)doneTotalQuantityEntering;
-(void)cancelTotalQuantityEntering;

@end

@interface classTotalQuantity : UIViewController
{
    
    classMedicine * objMedicine;
    UITextField *txtTotalQuantity;
    UITextField *txtReorderLevel;
    
    //id<totalQuantityProtocol>delegate;
    
    classAudio * myAudioPlayer;
    classUser * objUser;

}

@property (nonatomic,assign)  id<totalQuantityProtocol>delegate;

@property (nonatomic,retain)  classMedicine * objMedicine;

@property (nonatomic, retain) IBOutlet UITextField *txtTotalQuantity;
@property (nonatomic, retain) IBOutlet UITextField *txtReorderLevel;
@property (nonatomic,retain)    classAudio * myAudioPlayer;
@property(nonatomic,retain)    classUser * objUser;


-(void)cancel;
-(void)done;
+(BOOL)validate:(NSString *)value;

@end
