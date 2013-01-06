//
//  classMesureWeight2.h
//  PHCLiteNew
//
//  Created by Avi Kulkarni on 23/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classUser.h"
#import "classWebServices.h"
@class classAudio;

@protocol BoolWeightClassProtocol <NSObject>

-(void)weightskipFlag;
-(void)weightdoneFlag;


@end

@interface classMesureWeight2 : UIViewController<webServiceDelegateProtocol>{

    NSMutableArray *arrayFlags;
    int componentOneValue,componentTwoValue,componentThreeValue;
    UILabel *lblTotalWeight;
    UIButton *btndateTime;
    UILabel *lblWeight;
    UIPickerView *PickerWeight;
     NSString *strTotalWeightValue,*strTotalWeightValue1,*strTotalWeightValue2;
    NSMutableArray *arrayNumber,*arrayNumber1,*arrayNumber2;
    NSString *AllTotalWeightValue;
    NSArray *arrayOfNumberInText;
    NSArray *arrayOfNumberInText1;
    NSArray *arrayOfNumberInText2;
    NSString *language,*audiosatus;
    IBOutlet UIImageView *nurseImgeView;
    UIView *hbPickerBackView;
    UIButton *btnEnter;
    UIButton *skip;
    NSArray *arrayofHundredNumberInText;
    classAudio   *audioPlayer; 
    classUser *aUser;
}
@property (nonatomic,assign)  id<BoolWeightClassProtocol>delegate;

@property (nonatomic, retain) IBOutlet UILabel *lblTotalWeight;
@property (nonatomic, retain) IBOutlet UIButton *btndateTime;
@property (nonatomic, retain) IBOutlet UILabel *lblWeight;
@property (nonatomic, retain) IBOutlet UIPickerView *PickerWeight;
@property(nonatomic,retain)NSMutableArray *arrayNumber,*arrayNumber1,*arrayNumber2;
@property(nonatomic,retain)NSString *AllTotalWeightValue;
@property(nonatomic,retain) NSArray *arrayOfNumberInText;
@property(nonatomic,retain) NSArray *arrayOfNumberInText1;
@property(nonatomic,retain) NSArray *arrayOfNumberInText2;
@property (nonatomic,retain) classAudio *audioPlayer;
@property(nonatomic,retain) NSMutableArray *arrayFlags;
@property (nonatomic,retain) classUser *aUser;
@property(nonatomic,retain)IBOutlet UIView *hbPickerBackView;
- (IBAction)selectDateTime:(id)sender;
- (void)doneHBEntering ;
-(void)setweightFromComponent1:(int)value1 Component2:(int)value2 Component3:(int)value3;
-(IBAction)Cancle;
-(void)setDateTime:(NSDate *)selectdateTime;
-(void)checkFlag;
-(IBAction)skipPressed:(id)sender; 
-(IBAction)DonePicker;

-(void)playAudio:(int )component1:(int )component2:(int )component3;

@end
