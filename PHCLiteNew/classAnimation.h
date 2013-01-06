//
//  classAnimation.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 4/13/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"classAudio.h"
@interface classAnimation : UIViewController
{
    //
    //  aniomation.h
    //  animation
    //
    //  Created by Avinash Kulkarni on 3/15/12.
    //  Copyright (c) 2012 PanHealth Inc. All rights reserved.
    //
    

        IBOutlet UIImageView *stick;
    classAudio *myAudioPlayer;
} 
   
@property(nonatomic,retain) classAudio *myAudioPlayer;

// -(IBAction)startClicked:(id)sender;

@end