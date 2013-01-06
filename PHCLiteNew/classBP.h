//
//  classBP.h
//  PHCLite
//
//  Created by Avi Kulkarni on 05/08/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface classBP : NSObject 
{
    float BPReading;
    int SystolicReading;
    int DiastoicReading;
    int PulseReading;
    
    NSDate *date;

    
}
@property(nonatomic)float BPReading;
@property(nonatomic)int SystolicReading;
@property(nonatomic)int DiastolicReading;
@property(nonatomic)int PulseReading;
@property(nonatomic,retain)NSDate *date;

@end
