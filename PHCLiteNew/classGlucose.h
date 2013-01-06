//
//  classGlucose.h
//  PHCLite
//
//  Created by Avi Kulkarni on 8/2/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface classGlucose : NSObject
{

    float glucoseReading;
    NSDate *date;
    NSString *tag;
    
    
}

@property(nonatomic)float glucoseReading;
@property(nonatomic,retain) NSDate *date;
@property(nonatomic,retain)NSString *tag;


@end
