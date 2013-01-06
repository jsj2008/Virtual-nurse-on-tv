//
//  classPicture.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/22/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classAudio.h"
#import "classUser.h"
#import "classCareGiverInfo.h"
#import "classCareGiver.h"
//#import "AG"
@class classAudio;
@class classUser;
@class classMedicine;
@class classCareGiver;
@interface classPicture : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    classMedicine * objMedicine;    
    UIImageView *imageViewMedicine;
    
    UIImage * imageCamptured;
    classAudio * myAudioPlayer;

    classUser * objUser;
    
    BOOL isUserPhotoMode;
    BOOL isCareGiverMode;
    classCareGiver *classCareGiverbj;

    
}

@property (nonatomic, retain) IBOutlet UIImageView *imageViewMedicine;
@property(nonatomic,retain) classMedicine * objMedicine;
@property(nonatomic,retain)    UIImage * imageCamptured;
@property(nonatomic,retain)classAudio * myAudioPlayer;
@property(nonatomic,retain)    classUser * objUser;
@property(nonatomic)BOOL isUserPhotoMode;
@property(nonatomic)BOOL isCareGiverMode;
@property(nonatomic,retain)classCareGiver *classCareGiverobj;

@property (retain, nonatomic) IBOutlet UIButton *btnPhotoLibrary;


-(void)cancel;
-(IBAction)takePicture;
-(void)setNewImage;
- (IBAction)methodphotolibrary:(id)sender;
- (void)scaleAndRotateImage:(UIImage *)image;

@end
