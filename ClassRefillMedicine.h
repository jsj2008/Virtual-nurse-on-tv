//
//  ClassRefillMedicine.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/14/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "classDatabaseOperations.h"
//#import "classMedicine.h"
//#import "classUser.h"
//#import "classAudio.h"


@class classUser;
@class classAudio;
@class classMedicine;
@class classDatabaseOperations;

@protocol medicineRefillingProtocol

-(void)medicineReffilingDidComplete;

@end

@interface ClassRefillMedicine : UIViewController <UIAlertViewDelegate>
{
   // id<medicineRefillingProtocol>delegate;
    
    UITextField *txtReroderLevel;
    UITextField *txtTotalPillQuantity;
    UIButton *btnSubmit;
    
    classMedicine * objMedicine;
    classUser * objUser;
    
    
    classAudio * myAudioPlayer;

}

@property(nonatomic,assign)id<medicineRefillingProtocol>delegate;

@property (nonatomic, retain) IBOutlet UITextField *txtReroderLevel;
@property (nonatomic, retain) IBOutlet UITextField *txtTotalPillQuantity;
@property (nonatomic, retain) IBOutlet UIButton *btnSubmit;
- (IBAction)submit:(id)sender;
+(BOOL)validate:(NSString *)value;
-(void)playAudio;

@property (nonatomic, retain)    classMedicine * objMedicine;
@property (nonatomic, retain) classUser * objUser;

@property(nonatomic,retain)classAudio * myAudioPlayer;

@end
