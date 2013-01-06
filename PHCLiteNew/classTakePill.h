//
//  classTakePill.h
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 11/16/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classCompartmentData.h"

@class classUser;
@class classMedicine;
@class classAudio;
@interface classTakePill : UIViewController <UIScrollViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
{
    
    NSString *strDay;
    int userid;
    
    int bayno;
    int pagecreated;
    
    
    
    UILabel *lblDay;
    UILabel *lblPillsQty;
    UILabel *lblSpan;
    
    NSMutableArray *arrayMed;
    classCompartmentData * objCompartment;
    classMedicine *objMedicine;
    
    
    IBOutlet UIView *myView;
    IBOutlet UIButton *btnCompatrment;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UISegmentedControl *segmentControl;
    
    UILabel *lblMedName;
    UILabel *lblMedQty;


    NSMutableArray *arrayButton;

    NSMutableArray *arrayMedName;
    UILabel *lblTotalMedicine;
    
    
    
    //--------------------------------
    
    UIView *viewFirst;
    UIView *viewSec;
    UIView *viewFourth;
    UIView *viewThird;
    
   
    
    
    
    UIButton *btnNext;
    UIButton *btnPrev;
    UILabel *lblpage;
    UIImageView *imgFirstTic;
    UIImageView *imgSecTic;
    UIImageView *imgThirdTic;
    
    
    
    classUser * objUser;
  classAudio * myAudioPlayer;

    
    
    
    
}


@property(nonatomic,retain)classAudio * myAudioPlayer;

@property (nonatomic, retain) IBOutlet UIButton *btnPrev;
@property (nonatomic, retain) IBOutlet UILabel *lblpage;
@property (nonatomic, retain) IBOutlet UIButton *btnNext;
@property (nonatomic, retain) IBOutlet UILabel *lblTotalMedicine;
- (IBAction)MethodanimateView:(id)sender;
@property (nonatomic, retain) IBOutlet UILabel *lblMedQty;
@property (nonatomic, retain) IBOutlet UILabel *lblMedName;
@property (nonatomic, retain) IBOutlet UILabel *lblDay;
@property (nonatomic, retain) IBOutlet UILabel *lblPillsQty;
@property (nonatomic, retain) IBOutlet UILabel *lblSpan;
@property (nonatomic,retain) NSString *strTimeSpan;
@property(nonatomic,assign)        int userid;
@property(nonatomic,assign)        int bayno;
@property(nonatomic,assign)        int pagecreated;

@property(nonatomic,assign)        classCompartmentData * objCompartment;

@property(nonatomic,assign)    NSMutableArray *arrayButton;
@property(nonatomic,retain)    IBOutlet UIView *myView;

@property(nonatomic,assign)    NSMutableArray *arrayMedName;

-(void)methodMedicineTaken:(UIButton *)aButton :(UILabel *)lblMName:(UILabel *)lblMQty;
//-(void)buttonCreatedAnimatically;
-(void)done;
-(void)print;
-(void)timespan;



@property (nonatomic, retain) IBOutlet UIView *viewFirst;
@property (nonatomic, retain) IBOutlet UIView *viewSec;
@property (nonatomic, retain) IBOutlet UIView *viewFourth;
@property (nonatomic, retain) IBOutlet UIView *viewThird;
-(void)nexmedlist;
-(void)nexmedlist2;
-(void)methodAddSubViews;
//- (IBAction)methodAnimate:(id)sender;

//-(void)done:(UIButton *)btn;
-(void)createViews ;

-(void)clearView;
@property (nonatomic, retain) IBOutlet UIImageView *imgFirstTic;
@property (nonatomic, retain) IBOutlet UIImageView *imgSecTic;


@property (nonatomic, retain) IBOutlet UIImageView *imgThirdTic;



@property(nonatomic,retain)    classUser * objUser;

@property(nonatomic,retain)    classMedicine *objMedicine;

-(void)displyCompartment:(int)bayno1;

-(void)decrementTotalQuantity:(classMedicine *)objMedicine:(float)pillQuantityToTaken;

-(void)checkReoderLevel;



@end
