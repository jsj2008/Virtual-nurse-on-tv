//
//  classMesureBPNew.h
//  PHCLite
//
//  Created by Avi Kulkarni on 05/08/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "classBP.h"
#import "classWebServices.h"
#import "classAudio.h"
#import "classHimoglobin.h"
#import "classUser.h"
@protocol mesureBloodPressureProtocol

-(void)mesuringBloodPressureDidComplete;
-(void)mesuringBloodPressureDidCancel;

@end
@protocol BoolClassBPProtocol <NSObject>

-(void)BPdoneFlag;
-(void)BPskipFlag;


@end
@interface classMesureBPNew : UIViewController<webServiceDelegateProtocol,UIPickerViewDelegate>
{
    id<mesureBloodPressureProtocol>delegate;
    
    classBP *obj_BP;
   int componentOneValue,componentTwoValue,componentThreeValue; 
    NSMutableArray *arrayFlags;
    
    UIView *Pickerbackview;
   IBOutlet UIPickerView *pickerView;
    IBOutlet UIImageView *nurseImgeView;
 
    UIView *bppickerBackView;
    UIButton *btnReading;
    
    UIButton *btnTake;
     UIButton *btnSkip;  
    NSString *titleString,*language,*audiosatus;
    
    NSMutableArray *array_systolic,*array_diastolic,*array_pulse,*arrayofHundredNumberInText,*arrayOfNumberInText1,*arrayOfNumberInText2;
    UILabel *lblbpm;
    UILabel *lblDiastolic;
    UILabel *lblsystolic;
    UIButton *btndiastolic;
    UIButton *btnSystolic;

    NSString *str_sys,*str_dia,*str_pulse;
    UILabel *lblsysmes;
    UILabel *lblDiames;
    UILabel *lblpulsemes;
    UIButton *btnDatetime;
    UIButton *setdateTime;
    UIView *DatePickerBackView;
    UIDatePicker *DatePickerview;
    UIButton *btnmainReading;
    UIButton *btnDoneTouch;
    UIButton *btnEnter;
    UIButton *BtnReading2;
    UIButton *btnReading3;
    UIButton *btnReading4;
    NSString *currentDate;
    UILabel *lblSys1;
    UILabel *lblDia1;
    UILabel *lblPulse1;
    UILabel *lblDia;
    UILabel *lblPulse;
    
    //-----------------------------
    classAudio * myAudioPlayer;
    classUser *aUser;

    UILabel * lblTotalBP;
    UIActionSheet *actionSheetObj;

}
//---------------------
@property(nonatomic,retain) classUser *aUser;

@property(nonatomic,retain)classBP *obj_BP;
@property (nonatomic, retain) IBOutlet UIView *Pickerbackview;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;
@property (nonatomic, retain) IBOutlet UIButton *btnReading;
@property (nonatomic, retain) IBOutlet UILabel *lblbpm;
@property (nonatomic, retain) IBOutlet UILabel *lblDiastolic;
@property (nonatomic, retain) IBOutlet UILabel *lblsystolic;
@property (nonatomic, retain) IBOutlet UIButton *btndiastolic;
@property (nonatomic, retain) IBOutlet UIButton *btnSystolic;
@property (nonatomic, retain) IBOutlet UILabel *lblsysmes;
@property (nonatomic, retain) IBOutlet UILabel *lblDiames;
@property (nonatomic, retain) IBOutlet UILabel *lblpulsemes;
@property (nonatomic, retain) IBOutlet UIButton *btnDatetime;
@property (nonatomic, retain) IBOutlet UIView *DatePickerBackView;
@property (nonatomic, retain) IBOutlet UIDatePicker *DatePickerview;
@property (nonatomic, retain) IBOutlet UIButton *btnmainReading;
@property(nonatomic,retain)  id<mesureBloodPressureProtocol>delegate;
@property(nonatomic,retain) NSString *str_sys,*str_dia,*str_pulse;
@property(nonatomic,retain)NSString *currentDate;
@property (nonatomic, retain) IBOutlet UIButton *btnDoneTouch;
@property (nonatomic, retain) IBOutlet UIButton *BtnReading2;
@property (nonatomic, retain) IBOutlet UIButton *btnReading3;
@property (nonatomic, retain) IBOutlet UIButton *btnReading4;
@property (nonatomic, retain) IBOutlet UILabel *lblSys1;
@property (nonatomic, retain) IBOutlet UILabel *lblDia1;
@property (nonatomic, retain) IBOutlet UILabel *lblPulse1;
@property (nonatomic, retain) IBOutlet  UIView *bppickerBackView;
@property(nonatomic,retain)  NSMutableArray *arrayFlags;
@property (nonatomic, retain) IBOutlet UIButton *btnEnter;
@property (nonatomic, retain) IBOutlet UILabel *lblDia;
@property (nonatomic, retain) IBOutlet UILabel *lblPulse;
@property(nonatomic,retain)IBOutlet UIButton *btnTake;
@property(nonatomic,retain)IBOutlet UIButton *skip;
//------------------------------
@property(nonatomic,retain)    classAudio * myAudioPlayer;
@property(nonatomic,retain)IBOutlet UILabel * lblTotalBP;
@property (nonatomic,assign)  id<BoolClassBPProtocol>BPdelegate;

-(void)cancel;
//- (IBAction)selectTouchDone:(id)sender;
- (IBAction)TouchDonePicker:(id)sender;
- (IBAction)setDateTime:(id)sender;
- (IBAction)selectSystolic:(id)sender;
- (IBAction)selectdiastolic:(id)sender;
//-(void)selectDateTime:(NSDate *)selectdateTime;
- (IBAction)selectReading:(id)sender;
//∫-(void)setReading:(NSString *)selectedReading;
-(IBAction)DonePicker;
- (IBAction)SelectDiaReading:(id)sender;
-(IBAction)SelectDiaReading:(id)sender;
-(IBAction)selectPulseReading:(id)sender;
-(void)setSys:(NSString *)selectedSys;
-(void)setDia:(NSString *)selectedDia;
-(void)setPulse:(NSString *)selectedPulse;
-(IBAction)saveBPInformation;
//-------------------------------
-(void)setBPFromComponent1:(int)value1 Component2:(int)value2 Component3:(int)value3;
-(void)showMesureBpAlert;
-(void)checkFlag;
-(IBAction)Cancle;
- (void)doneBPEntering;
-(void)setDateTime1:(NSDate *)selectdateTime;
- (IBAction)selectBtnEnter:(id)sender ;
-(IBAction)measureBtnPressed:(id)sender;
-(IBAction)skipPressed:(id)sender;
@end
