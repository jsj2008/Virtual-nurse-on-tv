//
//  classMedicineVerification.h
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 02/12/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class classUser;
@class classAudio;
@interface classMedicineVerification : UIViewController<UIActionSheetDelegate> {
    
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    UIButton *btn5;
    UIButton *btn6;
    UIButton *btn7;
    UIButton *btn8;
    UIButton *btn9;
    UIButton *btn10;
    UIButton *btn11;
    UIButton *btn12;
    UIButton *btn13;
    UIButton *btn14;
    UIButton *btn15;
    UIButton *btn16;
    UIButton *btn17;
    UIButton *btn18;
    UIButton *btn19;
    UIButton *btn20;
    UIButton *btn21;
    UIButton *btn22;
    UIButton *btn23;
    UIButton *btn24;
    UIButton *btn25;
    UIButton *btn26;
    UIButton *btn27;
    UIButton *btn28;
    UIButton *btnCommon;
    UIButton *btnCommon1;

    UIImageView *imgPillbox;
    UILabel *lbltoday;
    UILabel *lblDayDate;
    classUser *objUser;
    classAudio * myAudioPlayer;
    int currentBay ;
    int bayno;
    int btnClickedTag;
    int imgvaue;
    
}
@property (retain, nonatomic) IBOutlet UILabel *lblNight;
@property (retain, nonatomic) IBOutlet UILabel *lblEvening;
@property (retain, nonatomic) IBOutlet UILabel *lblNoon;
@property (retain, nonatomic) IBOutlet UILabel *lblMorning;
@property (nonatomic, retain) IBOutlet UILabel *lblDayDate;
@property (nonatomic, retain) IBOutlet UILabel *lbltoday;

@property (nonatomic, retain) IBOutlet UIImageView *imgPillbox;
@property (nonatomic, retain) IBOutlet UIButton *btn1;
@property (nonatomic, retain) IBOutlet UIButton *btn2;
@property (nonatomic, retain) IBOutlet UIButton *btn3;
@property (nonatomic, retain) IBOutlet UIButton *btn4;
@property (nonatomic, retain) IBOutlet UIButton *btn5;
@property (nonatomic, retain) IBOutlet UIButton *btn6;
@property (nonatomic, retain) IBOutlet UIButton *btn7;
@property (nonatomic, retain) IBOutlet UIButton *btn8;
@property (nonatomic, retain) IBOutlet UIButton *btn9;
@property (nonatomic, retain) IBOutlet UIButton *btn10;
@property (nonatomic, retain) IBOutlet UIButton *btn11;
@property (nonatomic, retain) IBOutlet UIButton *btn12;
@property (nonatomic, retain) IBOutlet UIButton *btn13;
@property (nonatomic, retain) IBOutlet UIButton *btn14;
@property (nonatomic, retain) IBOutlet UIButton *btn15;
@property (nonatomic, retain) IBOutlet UIButton *btn16;
@property (nonatomic, retain) IBOutlet UIButton *btn17;
@property (nonatomic, retain) IBOutlet UIButton *btn18;
@property (nonatomic, retain) IBOutlet UIButton *btn19;
@property (nonatomic, retain) IBOutlet UIButton *btn20;
@property (nonatomic, retain) IBOutlet UIButton *btn21;
@property (nonatomic, retain) IBOutlet UIButton *btn22;
@property (nonatomic, retain) IBOutlet UIButton *btn23;
@property (nonatomic, retain) IBOutlet UIButton *btn24;
@property (nonatomic, retain) IBOutlet UIButton *btn25;
@property (nonatomic, retain) IBOutlet UIButton *btn26;
@property (nonatomic, retain) IBOutlet UIButton *btn27;
@property (nonatomic, retain) IBOutlet UIButton *btn28;
@property (nonatomic, retain) IBOutlet UIButton *btnCommon;
@property(nonatomic,retain)classUser *objUser;
@property (nonatomic, retain) IBOutlet UIButton *btnCommon1;

@property(nonatomic,assign)int bayno;
@property(nonatomic,assign)   int currentBay;
@property(nonatomic,assign)    int btnClickedTag;
@property(nonatomic,retain)classAudio * myAudioPlayer;
@property(nonatomic,assign)int imgvalue;


-(void)methodTakeMedicine;
-(int)methodToHilightCompartment;
//+(int)timeSpanInInteger;
-(int)getDayInInteger;
-(void)blink;
-(void)methodMedcinelist:(UIButton *)btn;
-(void)methodSetTarget;
+(NSString *)convertIntTimeSpanToString:(int)timeSpan;
-(NSString *)methodSelectedBayTimeSpan;

-(void)getbacklogs:(int)currentBay1;

-(void)setImgback:(int)bay:(NSString *)img;
-(void)blink1;
-(void)getbacklogsStatus:(int)currentPass;
-(void)getSelectedBoxImage;
-(void)methodToHideMorningCompartment;
-(void)methodToHideAfternoonCompartment;
-(void)methodToHideEveningCompartment;
-(void)methodToHideNightCompartment;
-(void)logout;




@end
