//
//  classMesureWeight.h
//  PHCLite
//
//  Created by Avi Kulkarni on 8/3/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classWeight1.h"
#import "classWebServices.h"
#import "classAudio.h"
#import "classMesureGlucose1.h"
#import <Foundation/Foundation.h>

@protocol mesureWeightProtocol

-(void)mesuringWeightDidComplete;
-(void)mesuringWeightDidCancel;

@end

@interface classMesureWeight : UIViewController<UITextFieldDelegate,webServiceDelegateProtocol>
{
    
    id<mesureWeightProtocol>delegate;
    
    classWeight1 *my_weight;
    
    UIButton *btndatetime;
    UITextField *txtWeight;
    UIDatePicker *DatePicker;
    UIBarButtonItem *selectDone;
    UIView *DatePickerbackView;
    UIView *BacksideView;
    UIButton *btnDoneTouch;
    UIButton *selectTouchDone;
    UIButton *btnWeightReading;
    UIView *WeightPickerBackView;
    NSMutableArray *arrayofWeight1,*arrayofWeight50,*arrayofWeight100;
    NSString *strWeightvalue,*strWeightValue1,*strWeightValue2;
    NSString *strTotalWeightValue,*strTotalWeightValue1,*strTotalWeightValue2;
    NSString *AllTotalWeightValue;
    
    UIButton *btnWeight1;
    UIButton *btnWeight2;
    UIButton *btnWeight3;
    NSString *currentDate;
    UIPickerView *pickerWeight;
    
    //----------------------------
    UILabel * lblTotalWight;
    classAudio * myAudioPlayer;
    
//    
//    //......Variable for Parsing.......	
//	
//	NSMutableData *webData;
//	NSMutableString *soapResults;
//	NSString *soapMsg;
//	NSURLConnection *conn;
//    NSString *str_location;
//	NSURL *url;
//	NSXMLParser *xmlParser;
//	NSMutableString *strData;
//	
//	NSMutableURLRequest *req;
//	
//
//    
    
}
@property(nonatomic,retain)NSString *currentDate;
@property(nonatomic,retain)classWeight1 *my_weight;
@property(nonatomic,retain)id<mesureWeightProtocol>delegate;
@property(nonatomic,retain)NSString *strWeightvalue;
@property (nonatomic, retain) IBOutlet UIButton *btndatetime;
@property (nonatomic, retain) IBOutlet UIView *DatePickerbackView;
@property (nonatomic, retain) IBOutlet UITextField *txtWeight;
@property (nonatomic, retain) IBOutlet UIDatePicker *DatePicker;
@property(nonatomic,retain)NSString *strTotalWeightValue,*strTotalWeightValue1,*strTotalWeightValue2;
@property (nonatomic, retain) IBOutlet UIView *BacksideView;
@property (nonatomic, retain) IBOutlet UIButton *btnDoneTouch;
@property (nonatomic, retain) IBOutlet UIButton *btnWeightReading;
@property (nonatomic, retain) IBOutlet UIView *WeightPickerBackView;
@property(nonatomic,retain)NSString *AllTotalWeightValue;
@property (nonatomic, retain) IBOutlet UIButton *btnWeight1;
@property (nonatomic, retain) IBOutlet UIButton *btnWeight2;
@property (nonatomic, retain) IBOutlet UIButton *btnWeight3;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerWeight;
@property(nonatomic,retain) IBOutlet UILabel * lblTotalWight;
@property(nonatomic,retain) classAudio * myAudioPlayer;

-(void)cancel;
- (IBAction)selectDateTime:(id)sender;
- (IBAction)DoneBack:(id)sender;
- (IBAction)Touchdone:(id)sender;
-(void)takeWeightReading;
-(void)showGlucoseMessage;
- (IBAction)selectTouchdone1:(id)sender;
- (IBAction)selectWeightReading:(id)sender;

-(void)setWeight:(NSString *)selectedWeight;
-(IBAction)saveWeightInformation;
- (IBAction)selectWeight1:(id)sender;
- (IBAction)selectWeight2:(id)sender;
- (IBAction)selectWeight3:(id)sender;
-(void)DonePicker;
-(void)showMesureWightAlert;

//-------------------------------
-(void)setweightFromComponent1:(int)value1 Component2:(int)value2 Component3:(int)value3;

@end
