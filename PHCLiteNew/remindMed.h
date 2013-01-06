//
//  remindMed.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 3/13/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classAudio.h"
//#import "classWebServices.h"
#import "classUser.h"
#import "classAudio.h"
#import "classDatabaseOperations.h"

@class classMedicine;

@interface remindMed : UIViewController
{
    
  //  int i;
    int selectedTime;
    NSMutableArray * arrayMedicineList,*arrayMedicineIndex;    

    classMedicine *med_obj;
    classMedicineTime *med_tobj;
    NSMutableArray *arrayFlags;
    classAudio *myAudioPlayer;
    classUser *aUser;
    NSMutableArray *medArray;
    
    IBOutlet UIImageView *tickImg;
    IBOutlet UIImageView *backgImage;
    IBOutlet UILabel *timeLbl;
    NSTimer *take;
    NSTimer *skip;
    NSTimer *remind;
    NSString *str,*dateString;
    NSString *strImg,*language,*audiosatus;
    IBOutlet UILabel *lbl;
    IBOutlet UILabel *nameLbl;
    IBOutlet UILabel *qntLbl;
    IBOutlet UILabel *comLbl;
    IBOutlet UIButton *skipButton;
}

@property(nonatomic)int selectedTime;
@property(nonatomic,retain)    NSMutableArray * arrayMedicineList,*arrayMedicineIndex;


@property (retain, nonatomic) IBOutlet UIImageView *backgImage;
@property (retain, nonatomic) IBOutlet UIImageView *medImg;
@property (retain, nonatomic) IBOutlet UIImageView *tickImg;
@property (retain, nonatomic) IBOutlet UILabel *comLbl;
@property (retain, nonatomic) IBOutlet UILabel *qtnLbl;
@property (retain, nonatomic) IBOutlet UILabel *nameLbl;

@property(nonatomic,retain) classAudio * myAudioPlayer;
@property(nonatomic,retain)NSMutableArray *arrayFlags;
@property(nonatomic,retain)NSMutableArray *medArray;
@property(nonatomic,retain) classUser *aUser;
@property(nonatomic,retain)NSString *strImg;
@property(nonatomic,retain)NSString *str;
@property(nonatomic,retain)NSString *dateString;
@property(nonatomic,retain)  IBOutlet UILabel *lbl;
@property(nonatomic,retain) NSTimer *take;
@property(nonatomic,retain) NSTimer *skip;
@property(nonatomic,retain) NSTimer *remind;
@property(nonatomic,retain) NSTimer *pre;
@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *quantity;
@property (retain, nonatomic) IBOutlet UILabel *timeLbl;
@property (retain, nonatomic) IBOutlet UILabel *comments;
@property (retain, nonatomic) IBOutlet UILabel *image;
@property(nonatomic,retain) classMedicine *med_obj;
@property(nonatomic,retain) classMedicineTime *med_tobj;
- (IBAction)taken:(id)sender;
- (IBAction)skipMethod:(id)sender;
- (IBAction)remindLater:(id)sender;
-(void)savePicture;
-(IBAction)Cancle;
-(IBAction)Logout;
@end
