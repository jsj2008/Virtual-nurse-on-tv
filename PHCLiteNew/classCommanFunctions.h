//
//  classCommanFunctions.h
//  i_Strips2
//
//  Created by Avi Kulkarni on 6/8/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface classCommanFunctions : NSObject 
{
    
}

+(NSString *)genrateFormatedMemberId:(NSString*)memberId;

+(int)timeSpanInInteger;
+(int)getTimeSpanOfTime:(NSString *)time;
+(NSArray *)marathiAudioMethod:(int )component1:(int )component2:(int )component3;

@end
