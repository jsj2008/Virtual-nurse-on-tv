//
//  classGlycoHemoglobin.h
//  PHCLite
//
//  Created by Avi Kulkarni on 30/08/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classAudio.h"
#import "classWebServices.h"
#import "classUser.h"
#import "classDatabaseOperations.h"
@protocol mesureGlycoHimoblobinProtocol

-(void)mesuringGlycoHimoblobinDidComplete;
-(void)mesuringGlycoHimoblobinDidCancel;

@end

@protocol BoolClassGlycoHemoglobinProtocol <NSObject>

-(void)glycohemoglobinDoneFlag;
-(void)glycohemoglobinskipFlag;


@end

@interface classGlycoHemoglobin : UIViewController<webServiceDelegateProtocol,mesureGlycoHimoblobinProtocol>
{
    id<mesureGlycoHimoblobinProtocol>delegate;
    
    NSMutableArray *arrayFlags;
    
    classAudio *myAudioPlayer;
    UILabel *lblHBA1c;
    UIButton *btnDateTime;
    UIPickerView *Picker_HBA1c;
    NSMutableArray *arrayHba1c1,*arrayHba1c2,*arrayHba1c3,*arrayofHundredNumberInText,*arrayOfNumberInText1,*arrayOfNumberInText2;
    NSString *currentDate;
    NSString *TotalHBA1cValue;
    NSString *language,*audiosatus;
    classUser *aUser;
    
    IBOutlet UIImageView *nurseImgeView;
    IBOutlet UIButton *btnTake;
    IBOutlet UIButton *btnSkip; 
    
    UIView *hbPickerBackView;
    UIButton *btnEnter;
    
   int componantOneValue,componantTwoValue,componantThreeValue;
    
}
@property(nonatomic,retain)NSString *TotalHBA1cValue;
@property(nonatomic,retain)  id<mesureGlycoHimoblobinProtocol>delegate;
@property(nonatomic,retain)NSString *currentDate;
@property (nonatomic, retain) IBOutlet UILabel *lblHBA1c;
@property (nonatomic, retain) IBOutlet UIButton *btnDateTime;
- (IBAction)selectDateTime:(id)sender;
@property (nonatomic, retain) IBOutlet UIPickerView *Picker_HBA1c;
@property(nonatomic,retain) NSMutableArray *arrayHba1c1,*arrayHba1c2,*arrayHba1c3;
@property(nonatomic,retain)classAudio *myAudioPlayer;
@property(nonatomic,retain)classUser *aUser;

@property(nonatomic,retain)IBOutlet UIView *hbPickerBackView;
@property(nonatomic,retain)IBOutlet UIButton *btnEnter;
@property(nonatomic,retain)NSMutableArray *arrayFlags;
@property(nonatomic,retain)IBOutlet UIButton *btnTake;
@property(nonatomic,retain)IBOutlet UIButton *skip;
@property (nonatomic,assign)  id<BoolClassGlycoHemoglobinProtocol>glycohemoglobindelegate;

-(void)showMesureGlycoHimoglobinAlert;
-(void)setGlycoHimoglobinFromComponent1:(int)value1 Component2:(int)value2 Component3:(int)value3;
-(IBAction)Cancle;
-(IBAction)DonePicker;
-(void)setDateTime:(NSDate *)selectedDate;
-(IBAction)saveGlycoHGInformation;
-(void)mesuringGlycoHimoblobinDidComplete;
-(void)mesuringGlycoHimoblobinDidCancel;
-(IBAction)saveGlycoHGInformation;
-(void)checkFlag;
- (void)doneHBEntering;
-(IBAction)skipPressed:(id)sender;

@end
