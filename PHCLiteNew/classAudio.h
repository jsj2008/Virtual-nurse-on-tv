//
//  classAudio.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/16/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>



@interface classAudio : NSObject  <AVAudioPlayerDelegate>
{
    
    
    AVAudioPlayer * audioPlayer;
    NSMutableArray * arrayOfSoundFiles;
    NSMutableData *concatedData;
    
}

@property(nonatomic,retain) AVAudioPlayer * audioPlayer;
@property(nonatomic,retain)    NSMutableArray * arrayOfSoundFiles;

-(void)playAudios:(NSMutableArray *)arrayOfSoundFilesNames;
-(void)stopAudio;

@end
