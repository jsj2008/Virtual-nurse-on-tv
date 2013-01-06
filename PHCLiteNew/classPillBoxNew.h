//
//  classPillBoxNew.h
//  pillBoxGuide
//
//  Created by Avi Kulkarni on 6/25/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class classMedicineNew;
@class PillBox;
@class classAudio;
@class classUser;
@class classMedicine;
@class classMedicineTime;
@class classMedicineIndex;

@protocol protocolPillBox

-(void)methodPillBoxFillingCancel;
-(void)methodPillBoxFillingComplete;

@end

@interface classPillBoxNew : UIViewController <UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
        
    UILabel *lblMedicineName;
    UILabel *lblPillQuantity;
    UILabel *lblStepDetails1;
    UILabel *lblMedicineFrequency;
    UILabel *lblStepDetails;
    UILabel *lblStep;
    
    UIButton *btnFill1;
    UIButton *btnFill2;
    UIButton *btnFill3;
    UIButton *btnFill4;
    
    UIImageView *imgViewArrow;    
    UIImageView *imgViewPillBoxRow1;
    UIImageView *imgViewPillBoxRow2;
    UIImageView *imgViewPillBoxRow3;
    UIImageView *imgViewPillBoxRow4;
    UILabel *lblFilledMorning;
    UILabel *lblFilledAfternoon;
    UIButton *btnSelectMedicine;
    UILabel *lblFilledEvening;
    UILabel *lblFilledNight;
    
    
    NSMutableArray * arrayMedicineObjects;
    PillBox * myPillBox;
    UIView *viewStepMessage;
    UIButton *btnFill;
    UIImageView *imgViewStep;
    
    UIButton *btnUndo;
    UITableView *myTable;
    
    classAudio * myAudioPlayer;
    
    
    //-------------------------------
    NSMutableArray * arrayMedicineIndex;
    NSMutableArray * arrayPillbox;
    classUser * objUser;
    classMedicine * selectedMedicine;
    NSMutableArray * arrayOfTextNumbersSapnish;    
    
    
    //----------------------------------------for Compartment Area
    
    
    
    
    
    NSString * strSelectedMedTimeSpan;
    float selectedPillQty;
    NSString * selectedMedName;
    int selctedMedId;
    
    int MedFlag;
    float prescQty;
    int audioflag;
    
    

}


@property(nonatomic,assign)id <protocolPillBox>delegate;
@property (nonatomic, retain) IBOutlet UITableView *myTable;
@property (nonatomic, retain) IBOutlet UIButton *btnUndo;
- (IBAction)UndoStep:(id)sender;
- (IBAction)fillPillBox:(id)sender;
-(void)setData;
-(NSString *)getPillQuantity;
-(NSString*)getStepMessage:(classMedicineTime *)objMedTime;
- (IBAction)selectMedicine:(id)sender;
-(void)animateArrowAndFillButton:(classMedicineTime *)objMedTime;
-(void)showFilledLabel:(classMedicineTime *)objMedTime;
-(void)medicineFillingComplete;
-(void)playAudio;
-(void)cancel;
-(void)skipMedicine;


@property (nonatomic, retain) IBOutlet UILabel *lblMedicineName;
@property (nonatomic, retain) IBOutlet UILabel *lblMedicineFrequency;
@property (nonatomic, retain) IBOutlet UILabel *lblPillQuantity;
@property (nonatomic, retain) IBOutlet UILabel *lblStepDetails1;
@property (nonatomic, retain) IBOutlet UILabel *lblStepDetails;
@property (nonatomic, retain) IBOutlet UILabel *lblStep;

@property (nonatomic, retain) IBOutlet UIButton *btnFill1;
@property (nonatomic, retain) IBOutlet UIButton *btnFill2;
@property (nonatomic, retain) IBOutlet UIButton *btnFill3;
@property (nonatomic, retain) IBOutlet UIButton *btnFill4;

@property (nonatomic, retain) IBOutlet UIImageView *imgViewArrow;
@property (nonatomic, retain) IBOutlet UIImageView *imgViewPillBoxRow1;
@property (nonatomic, retain) IBOutlet UIImageView *imgViewPillBoxRow2;
@property (nonatomic, retain) IBOutlet UIImageView *imgViewPillBoxRow3;
@property (nonatomic, retain) IBOutlet UIImageView *imgViewPillBoxRow4;
@property (nonatomic, retain) IBOutlet UILabel *lblFilledMorning;
@property (nonatomic, retain) IBOutlet UILabel *lblFilledAfternoon;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectMedicine;
@property (nonatomic, retain) IBOutlet UILabel *lblFilledEvening;
@property (nonatomic, retain) IBOutlet UILabel *lblFilledNight;

@property (nonatomic, retain)    NSMutableArray * arrayMedicineObjects;
@property(nonatomic,retain) PillBox * myPillBox;
@property (nonatomic, retain) IBOutlet UIView *viewStepMessage;
@property (nonatomic, retain) IBOutlet UIButton *btnFill;
@property (nonatomic, retain) IBOutlet UIImageView *imgViewStep;
@property(nonatomic,retain)    classAudio * myAudioPlayer;


@property(nonatomic,retain)NSMutableArray * arrayMedicineIndex;
@property(nonatomic,retain)NSMutableArray * arrayPillbox;
@property(nonatomic,retain)classUser * objUser;
@property(nonatomic,retain)    classMedicine * selectedMedicine;

//------------------------------------------
-(BOOL)methodCheckMedicneFilledCompletely:(classMedicine *)objMedicine;
-(BOOL)methodCheckMedicineDoseFilledInPillBox:(classMedicineIndex *)objMedTime;

//-------------------------------------------------------

-(void)methodFillBoxInDatabase;

@property(nonatomic,retain)    NSString * strSelectedMedTimeSpan;
@property(nonatomic,assign)    float selectedPillQty;
@property(nonatomic,retain)    NSString * selectedMedName;

@property(nonatomic,assign)        int selctedMedId;
@property(nonatomic,assign)  NSMutableArray * arrayOfTextNumbersSapnish;    

@property(nonatomic,assign)int MedFlag;
@property(nonatomic,assign)float prescQty;
@property(nonatomic,assign) int audioflag;

-(void)methodFillBoxInDatabaseAgain;
-(void)methodFillBoxInDatabaseAgainNoon;
-(void)methodFillBoxInDatabaseAgainEvening;
-(void)methodFillBoxInDatabaseAgainNight;



@end
