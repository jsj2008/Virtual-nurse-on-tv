//
//  classHome.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 4/7/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "classNewUser.h"
#import "classDeleteMember.h"
#import "classMesureGlucose1.h"
#import "classUser.h"
#import "classAudio.h"
#import "classCommanFunctions.h"
#import "UIView+Animation.h"
#import "classMesureWeight2.h"
#import "classHimoglobin.h"
#import "classGlycoHemoglobin.h"
#import <UIKit/UIKit.h>
#import "SetTopBox.h"


@class classAudio;
//@class classMesureWeight2;
  classUser *clUser;
@interface classHome : UIViewController<BoolWeightClassProtocol,BoolClassBPProtocol,glucoseBoolClassProtocol,BoolClassHemoglobinProtocol,BoolClassGlycoHemoglobinProtocol,AVAudioPlayerDelegate>
{

    IBOutlet UIButton *btnTracker;
    IBOutlet UIButton *btnMed;
    IBOutlet UIImageView *nurseImage;
    IBOutlet UIButton *btnLogs;
    IBOutlet UIButton *btnSetting;
    IBOutlet UILabel *userName;
    IBOutlet UIButton *weightBtn;
    IBOutlet UIButton *BPBtn;
    IBOutlet UIButton *glucoseBtn;
    IBOutlet UIButton *hemoglobinBtn;
    IBOutlet UILabel *weightLabel,*hemoglobinLabel,*glucoseLabel,*bpLabel,*glycoLabel;
    BOOL weightBool;
    BOOL glucoseBool;
    BOOL BPBool;
    BOOL hemoBool;
    BOOL glycoHemoBool;
    BOOL doneFlag,skipFlag;

    NSMutableArray *arrayFlags;
    NSString  *str1;
    NSString  *str2;    
    NSString  *str3;
    NSString  *str4;    
    NSString  *str5;    
    NSString  *str6;
    NSString *strImg;
    int i,counter;
    NSMutableArray * arrayofControllers;
    UINavigationController *navC;
    UILocalNotification *notification;
    UIImageView *userImage;
   classUser *aUser;
   classAudio *myAudioPlayer;
    IBOutlet UIButton *btn1,*btn2,*btn3,*btn4,*btn5;
    int	selectedCurveIndex;
    int skipCounter,doneCounter;
    AVAudioPlayer * audioPlayer;
    NSString *language;
    NSString *audiosatus;
}
@property(nonatomic ,retain) IBOutlet UIButton *btnTracker;
@property(nonatomic ,retain)IBOutlet UIButton *btnMed;
@property(nonatomic ,retain) classUser *aUser;
@property(nonatomic ,retain) IBOutlet UILabel *userName;
@property(nonatomic ,retain)  NSMutableArray *arrayFlags; 
@property(nonatomic ,retain)IBOutlet UIButton *btnLogs;
@property(nonatomic ,retain) IBOutlet UIButton *btnSetting;
@property(nonatomic ,retain) UINavigationController *navC;
@property(nonatomic,retain) NSMutableArray *arrayofControllers;
@property(nonatomic ,retain) classAudio *myAudioPlayer;
@property(nonatomic,retain)  IBOutlet UIImageView *userImage;
@property(nonatomic ,retain)IBOutlet UIButton *weightBtn;
@property (nonatomic, assign) BOOL weightBool;
@property (nonatomic, assign) BOOL glucoseBool;
@property (nonatomic, assign) BOOL BPBool;
@property (nonatomic, assign) BOOL hemoBool;
@property (nonatomic, assign) BOOL glycoHemoBool;
@property (readwrite,assign) int counter;
@property(nonatomic,retain)  UILocalNotification *notification;
@property(nonatomic,retain) AVAudioPlayer * audioPlayer;

-(IBAction)gotoTracker;
-(IBAction)gotoMedicine:(id)sender;
- (IBAction)goSetiing:(id)sender;
- (IBAction)goLogs:(id)sender;
-(IBAction)Logout;
-(IBAction)Exit;
-(IBAction)addButtonClick:(id)sender;
-(IBAction)buttonTap:(id)sender;

-(void)allRedingsMethod;
+(void)setUser:(classUser *)aUser;
- (void)spinLayer:(CALayer *)inLayer duration:(CFTimeInterval)inDuration
        direction:(int)direction;
-(void)numberAlert;

@end
