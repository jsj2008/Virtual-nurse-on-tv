//
//  classMedicineName1.h
//  i_StripsPro
//
//  Created by Avi Kulkarni on 7/10/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "classAudio.h"
@class classMedicine;
@class classAudio;
@class classUser;
//#import "classUser.h"

@interface classMedicineName1 : UIViewController  <UIWebViewDelegate>
{
    
    UIToolbar *barBtnCancel;
    UIBarButtonItem *barBtnSearch;
    UIBarButtonItem *btnBarDone;
    UITextField *txtMedicineName;
    UIWebView *webViewMedicineInfo;
    UIBarButtonItem *barBtnnext;
    UIBarButtonItem *barBtnBack;
    
    classMedicine * objMedicine;
    
    classAudio * myAudioPlayer;

    classUser * objUser;

    UIImageView *imgInfo;
}
@property (nonatomic, retain) IBOutlet UIImageView *imgInfo;

@property (nonatomic, retain) IBOutlet UIToolbar *barBtnCancel;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *barBtnSearch;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *btnBarDone;

@property (nonatomic, retain) IBOutlet UITextField *txtMedicineName;
@property (nonatomic, retain) IBOutlet UIWebView *webViewMedicineInfo;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *barBtnnext;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *barBtnBack;

@property (nonatomic, retain) classMedicine * objMedicine;

@property(nonatomic,retain)classAudio * myAudioPlayer;
@property(nonatomic,retain)    classUser * objUser;



-(BOOL)validate:(NSString*)value;
- (IBAction)cencel:(id)sender;
- (IBAction)search:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)back:(id)sender;
-(void)playAudio;


@end
