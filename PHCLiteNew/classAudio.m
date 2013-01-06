//
//  classAudio.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/16/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classAudio.h"

int audioIndex;

@implementation classAudio
@synthesize audioPlayer;
@synthesize arrayOfSoundFiles;


-(void)playAudios:(NSMutableArray *)arrayOfSoundFilesNames 
{
    [self.audioPlayer stop];
    
    
    
    
    
    audioIndex=0;
    self.arrayOfSoundFiles=arrayOfSoundFilesNames;
    
    if([self.arrayOfSoundFiles count]!=0)
    {
        
        
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: [arrayOfSoundFilesNames objectAtIndex:audioIndex] ofType: @"aiff"];
        
        NSLog(@"%@",soundFilePath);
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:soundFilePath]){
            NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
            
            
            
            AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil ];
            [newPlayer prepareToPlay];
            [fileURL release];
            
            self.audioPlayer = newPlayer;
            self.audioPlayer.delegate=self;
            
            [newPlayer release];
            [self.audioPlayer play];
        }
  
    }

    
//    [self.audioPlayer stop];
//    concatedData=[[NSMutableData alloc]init];
//    audioIndex=0;
//    self.arrayOfSoundFiles=arrayOfSoundFilesNames;
//    for (int i=0; i<[arrayOfSoundFilesNames count]; i++) {
//        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: [arrayOfSoundFilesNames objectAtIndex:i] ofType: @"wav"];
//        if(soundFilePath== nil)
//        {
//            soundFilePath=[[NSBundle mainBundle] pathForResource: [arrayOfSoundFilesNames objectAtIndex:i] ofType: @"aiff"];
//            
//        }
//        [concatedData appendData:[[NSData alloc] initWithContentsOfFile:soundFilePath]];
//
//    }
//    NSLog(@"array of Sound %@",arrayOfSoundFilesNames);
//        if([self.arrayOfSoundFiles count]!=0)
//        {
//           AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithData:concatedData error:nil];
//            
//            
////            [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryAmbient error: nil];
////            
////            UInt32 sessionCategory = kAudioSessionCategory_AmbientSound;
////            AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
//            
//            newPlayer.numberOfLoops=0;
//            [newPlayer setDelegate:self];
//            [newPlayer prepareToPlay];
//            self.audioPlayer= newPlayer; 
//            self.audioPlayer.delegate=self;
//            
//            [newPlayer release]; 
//               }
//    [self.audioPlayer play];

}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{   NSLog(@"Hiiiiiiiiii");}
                                                                                            


-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    audioIndex++;
    
    if(audioIndex<[self.arrayOfSoundFiles count])
    {
        
        
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: [self.arrayOfSoundFiles objectAtIndex:audioIndex] ofType: @"aiff"];
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
        AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil ];    
        [fileURL release];
        
        self.audioPlayer = newPlayer; 
        [self.audioPlayer prepareToPlay];
        self.audioPlayer.delegate=self;
        
        [newPlayer release];   
        [self.audioPlayer play];
        
        //NSLog(@"Audio index:%d",audioIndex);
       // audioPlayer.currentTime=0;
        
        
    }
    else
    {
        
        [self.arrayOfSoundFiles removeAllObjects];
        
    }
    
    
    
}


-(void)stopAudio
{
    
    
    [self.audioPlayer stop];
    [self.arrayOfSoundFiles removeAllObjects];
    
    
}


@end
