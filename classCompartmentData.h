//
//  classCompartmentData.h
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 11/16/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface classCompartmentData : NSObject
{
   
    NSString *bayMedName;
    NSString *bayMedTimeSpan;
    NSString *bayMedDay;
    int bayno;
    float bayMedQty;
    int state; 
    int medicineID;
    
    
    
    
    
}


@property (nonatomic,retain)    NSString *bayMedName;

@property (nonatomic,retain)    NSString *bayMedTimeSpan;


@property (nonatomic,retain)    NSString *bayMedDay;


@property(nonatomic,assign)    int bayno;
@property(nonatomic,assign)    int state;
@property(nonatomic,assign)    float bayMedQty;
@property(nonatomic,assign)     int medicineID;




@end
