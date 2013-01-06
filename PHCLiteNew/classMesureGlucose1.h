//
//  classMesureGlucose1.h
//  PHCLite
//
//  Created by Avi Kulkarni on 8/2/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PHCLiteNewAppDelegate.h"
#import "classGlucose.h"
#import "classWebServices.h"
#import <Foundation/Foundation.h>
#import "classAudio.h"
#import "classMesureBPNew.h"
#import "classUser.h"
@protocol mesureBloodGlucoseProtocol

-(void)mesuringBloodGlucoseDidCancel;
//-(void)mesuringBloodGlucoseDidComplete;

@end
@protocol glucoseBoolClassProtocol <NSObject>

-(void)glucosedoneFlag;
-(void)glucoseskipFlag;


@end

@interface classMesureGlucose1 : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,webServiceDelegateProtocol>
{
 
    int componentOneValue,componentTwoValue,componentThreeValue;
    classGlucose * myGlucose;
    NSMutableArray *arrayFlags;
    UIButton *btnTakeReading;
    UIButton *btnDateTime;
    UIButton *btnTag;
    UITextField *txtGlucoseReading;
    UIPickerView *pickerTag;
    UIView *pickerBackView;
    UIView *DateTimePickerBackView;
    UIDatePicker *dateTimePicker;
    UIView *keyboardBackView;
  
    IBOutlet UIImageView *nurseImgeView;
    IBOutlet UIButton *btnTake;
    IBOutlet UIButton *btnSkip; 
    IBOutlet UIButton *skip;

    id<mesureBloodGlucoseProtocol>delegate;
    UIButton *btnReadingDone;
    UIButton *selectReadingDone;
    UIButton *btnGlucoseReading;
    UIView *GlucosePickerBackView;
    UIPickerView *GlucosePicker;
    NSMutableArray *arrayofglucose,*arrayofglucose1,*arrayofglucose2;
    NSString *strGlucoseValue,*strGlucoseValue1,*strGlucoseValue2;
    UIButton *btnGlucose1;
    UIButton *btnGlucose2;
    UIButton *btnGlucose3;
    NSString *AllGlucoseValue;
    NSString *currentDate;
    NSArray *arrayOfNumberInText1;
    NSMutableArray * arrayOfNumberInText;
   
    NSArray *arrayOfNumberInText2;
    NSArray *arrayofHundredNumberInText;
    UIImageView *led;
    UIView *glucosePickerView;
    
    //----------------------------
    classAudio * myAudioPlayer;
    classUser *aUser;
    classAudio   *audioPlayer; 

    UILabel * lblTotalGlucose;
    
    NSMutableArray *arraymeal;
    
    NSString *strMealTpye;
    NSString *language,*audiosatus;

}
@property(nonatomic,retain)NSString *strMealTpye;

@property(nonatomic,retain) NSArray *arrayOfNumberInText1;
@property(nonatomic,retain)  NSMutableArray * arrayOfNumberInText;
@property(nonatomic,retain)  NSArray * arrayOfNumberInText2;
@property (nonatomic,assign)  id<glucoseBoolClassProtocol>glucosedelegate;

@property(nonatomic,retain)  id<mesureBloodGlucoseProtocol>delegate;
@property(nonatomic,retain)NSString *strGlucoseValue;
@property (nonatomic, retain) IBOutlet UIButton *btnTakeReading;
@property (nonatomic, retain) IBOutlet UIButton *btnDateTime;
@property (nonatomic, retain) IBOutlet UIButton *btnTag;
@property (nonatomic, retain) IBOutlet UITextField *txtGlucoseReading;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerTag;
@property (nonatomic, retain) IBOutlet UIView *pickerBackView;
@property (nonatomic, retain) IBOutlet UIView *DateTimePickerBackView;
@property (nonatomic, retain) IBOutlet UIDatePicker *dateTimePicker;
@property (nonatomic, retain) IBOutlet UIView *keyboardBackView;
@property (nonatomic,retain)NSString *AllGlucoseValue;
@property (nonatomic,retain)classGlucose * myGlucose;
@property (nonatomic, retain) IBOutlet UIButton *btnReadingDone;
@property (nonatomic, retain) IBOutlet UIButton *btnGlucoseReading;
@property (nonatomic, retain) IBOutlet UIView *GlucosePickerBackView;
@property (nonatomic, retain) IBOutlet UIPickerView *GlucosePicker;
@property (nonatomic, retain) IBOutlet UIButton *btnGlucose1;
@property (nonatomic, retain) IBOutlet UIButton *btnGlucose2;
@property (nonatomic, retain) IBOutlet UIButton *btnGlucose3;
@property(nonatomic,retain)NSString *currentDate;
@property(nonatomic,retain) classAudio * myAudioPlayer;
  @property(nonatomic,retain)  classAudio   *audioPlayer; 
@property(nonatomic,retain) NSMutableArray *arrayFlags;
@property (nonatomic,retain) classUser *aUser;
@property (nonatomic, retain) IBOutlet UIView *glucosePickerView;
@property(nonatomic,retain)IBOutlet UIButton *btnTake;
@property(nonatomic,retain)IBOutlet UIButton *skip;
@property(nonatomic,retain)IBOutlet UIImageView *led;
@property(nonatomic,retain)      NSMutableArray *arraymeal;

//-----------------------------------------------
@property(nonatomic,retain)IBOutlet UILabel * lblTotalGlucose;

- (void)takeGlucoseReading;
- (IBAction)doneReadingTaking:(id)sender;
- (IBAction)selectDateTime:(id)sender;
- (IBAction)selectTag:(id)sender;
- (IBAction)doneDateTimeSelection:(id)sender;
- (IBAction)doneTagSelection:(id)sender;
-(void)setDateTime:(NSDate *)selectedDate;
-(void)setTag:(NSString *)selectedTag;
-(void)cancel;

- (IBAction)selectGlucoseReading:(id)sender;
- (IBAction)TouchGlucoseDone:(id)sender;
-(void)setGlucose:(NSString *)selectedGlucose;
-(void)setGlucose1:(NSString *)selectedGlucose1;
-(void)setGlucose2:(NSString *)selectedGlucose2;
-(IBAction)saveGlucoseInformation;
- (IBAction)selectBtnGlucose1:(id)sender;
- (IBAction)selectBtnGlucose2:(id)sender;
- (IBAction)selectBtnGlucose3:(id)sender;
- (void)doneGlucoseEntering;

-(IBAction)skipPressed:(id)sender;
-(IBAction)DonePicker;

//-------------------------------
-(void)setweightFromComponent1:(int)value1 Component2:(int)value2 Component3:(int)value3;
-(void)checkFlag; 
-(IBAction)Cancle;
-(void)playAudio:(int )component1:(int )component2:(int )component3;

@end
