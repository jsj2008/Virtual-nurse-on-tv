//
//  ClassAddMedicationNew.h
//  i_strip
//
//  Created by Avi Kulkarni on 4/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classTotalQuantity.h"
//#import "classUser.h"
//#import "classAudio.h"

@class classAudio;
@class classUser;
@class classTotalQuantity;

@protocol addMedicineProtocol

-(void)addMedicineDidCancel;
-(void)addMedicineDidComplete;

@end

@class classMedicine;
@interface ClassAddMedicationNew : UITableViewController<UITextViewDelegate,UITextFieldDelegate,totalQuantityProtocol,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    classUser * objUser;
	classMedicine * objMedicine;
    BOOL isUpdateMode;
   // id<addMedicineProtocol>delegate;
    
	
	UITextView		*textViewComments;
	UIBarButtonItem * btnSave,*btnUpdate;	
    
    classAudio * myAudioPlayer;
    float countMed;
}

-(void)saveMedicine;
-(void)cancel;
-(void)updateMedicine;
-(void)deleteMedicine;
-(void)playAudio;
-(void)savePicture;

// these methods are used to validate medicne name, its time, frequency etc.
-(BOOL)checkMedicineNameAndShowAlert :(BOOL)showAlert;
-(BOOL)checkDosageFrequencyAndShowAlert:(BOOL)showAlert;
-(BOOL)checkMedicineTimeAndShowAlert:(BOOL)showAlert;
-(BOOL)checkPillQuantityAndShowAlert:(BOOL)showAlert;
-(BOOL)checkTotalPillQuantityAndShowAlert:(BOOL)showAlert;

@property(nonatomic,retain)classUser * objUser;
@property(nonatomic)BOOL isUpdateMode;
@property(nonatomic,assign) id<addMedicineProtocol>delegate;

@property(nonatomic,retain)	classMedicine * objMedicine;
@property(nonatomic,retain) UITextView *textViewComments;
@property(nonatomic,retain) UIBarButtonItem * btnSave,*btnUpdate;	

@property(nonatomic,retain)classAudio * myAudioPlayer;

@property (nonatomic,assign)float countMed;
-(int)countofmedicine:(classUser*)obj;



@end
