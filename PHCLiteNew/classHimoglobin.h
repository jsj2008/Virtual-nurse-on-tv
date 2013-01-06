//
//  classHimoglobin.h
//  PHCLite
//
//  Created by Avi Kulkarni on 18/08/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "classAudio.h"
#import "classWebServices.h"
#import "classUser.h"
@protocol mesureHimoblobinProtocol

-(void)mesuringHimoblobinDidComplete;
-(void)mesuringHimoblobinDidCancel;

@end

@protocol BoolClassHemoglobinProtocol <NSObject>

-(void)hemoglobinDoneFlag;
-(void)hemoglobinskipFlag;


@end
@interface classHimoglobin : UIViewController<webServiceDelegateProtocol,mesureHimoblobinProtocol,UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    id<mesureHimoblobinProtocol>delegate;
    int componentOneValue,componentTwoValue,componentThreeValue;
    NSMutableArray *arrayFlags;
    
    UIButton *btnHimoglobin;
    UILabel *lblHG;
    UIButton *btnDateTime;
    UIButton *btnTag;
    
    IBOutlet UIButton *btnTake;
    IBOutlet UIButton *btnSkip; 
    IBOutlet UIImageView *nurseImgeView;

    UIView *pickerBackSide;
    NSMutableArray *arrayHB1,*arrayHB2,*arrayHB3;
    NSString *str_HG,*str_HG1,*str_HG2;
    UIPickerView *Picker_HB;
    UIView *DateTimeBackView;
    UIDatePicker *DatePickerTime;
    UIBarButtonItem *barBtnDone,*barBtnCancel,*barBtnLogout;
    UIButton *btnHimoglobin1;
    UIButton *btnHimoglobin2;
    NSString *TotalHGValue;
    NSString *currentDate;
    NSString *audiosatus,*language;
    UIView *hbPickerBackView;
    UIButton *btnEnter;
    NSMutableArray *arrayofHundredNumberInText,*arrayOfNumberInText1,*arrayOfNumberInText2;
    //------------------------
    classAudio * myAudioPlayer;
    classUser *aUser;

    UILabel * lblTotalHimoglobin;
}
@property (nonatomic, retain) IBOutlet UIButton *btnHimoglobin;
@property (nonatomic, retain) IBOutlet UILabel *lblHG;
@property (nonatomic, retain) IBOutlet UIButton *btnDateTime;
@property (nonatomic, retain) IBOutlet UIButton *btnTag;
@property(nonatomic,retain)NSString *TotalHGValue;
@property (nonatomic, retain) IBOutlet UIView *pickerBackSide;
@property(nonatomic,retain)NSMutableArray *arrayHB1,*arrayHB2,*arrayHB3;
@property (nonatomic, retain) IBOutlet UIPickerView *Picker_HB;
@property (nonatomic, retain) IBOutlet UIView *DateTimeBackView;
@property (nonatomic, retain) IBOutlet UIDatePicker *DatePickerTime;
@property (nonatomic, retain) IBOutlet UIButton *btnHimoglobin1;
@property (nonatomic, retain) IBOutlet UIButton *btnHimoglobin2;
@property(nonatomic,retain)NSString *currentDate;
@property(nonatomic,retain)    id<mesureHimoblobinProtocol>delegate;
@property(nonatomic,retain)    classAudio * myAudioPlayer;
@property(nonatomic,retain)IBOutlet UILabel * lblTotalHimoglobin;
@property(nonatomic,retain)NSMutableArray *arrayFlags;
@property(nonatomic,retain)classUser *aUser;
@property(nonatomic,retain)IBOutlet UIView *hbPickerBackView;
@property(nonatomic,retain)IBOutlet UIButton *btnEnter;
@property(nonatomic,retain)IBOutlet UIButton *btnTake;
@property(nonatomic,retain)IBOutlet UIButton *skip;
@property (nonatomic,assign)  id<BoolClassHemoglobinProtocol>hemoglobindelegate;

//- (IBAction)TouchDone:(id)sender;
- (IBAction)selectHimoglobinBtn:(id)sender;
- (IBAction)selectDateTime:(id)sender;
- (IBAction)selectTag:(id)sender;
- (IBAction)TouchDoneDateTime:(id)sender;
-(IBAction)Cancle;
-(void)setDateTime:(NSDate *)selectedDate;
-(IBAction)DonePicker;
-(IBAction)saveHGInformation;
- (IBAction)selectHB1:(id)sender;
- (IBAction)selectHB2:(id)sender;
//-------------------------------
-(void)showMesureHimoglobinAlert;
-(void)setHimoglobinFromComponent1:(int)value1 Component2:(int)value2 Component3:(int)value3;
-(void)checkFlag;
- (void)doneHBEntering;
- (IBAction)TouchDoneDateTime:(id)sender; 
- (IBAction)selectBtnEnter:(id)sender; 

-(IBAction)skipPressed:(id)sender;
@end
