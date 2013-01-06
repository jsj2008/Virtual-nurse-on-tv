//
//  classMedicineTime.h
//  webserviceDemo
//
//  Created by Avi Kulkarni on 7/8/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface classMedicineTime : NSObject
{
    
    int doseNumber;
    NSString *times;
    NSString *timeSpan;
    float pillQuantity;
    
    
    
}

@property(nonatomic,retain)NSString *times;
@property(nonatomic,retain)NSString *timeSpan;

@property(nonatomic) float pillQuantity;
@property(nonatomic)    int doseNumber;


@end
