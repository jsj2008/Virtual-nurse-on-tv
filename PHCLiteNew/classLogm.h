//
//  classLog.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/17/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface classLogm : NSObject 
{
    NSString * memberId,*memberName,*medicineName;    
    NSString * datetime;

    float quantityTaken;
    int doseNumber,logId,medicineId,userId;
    
}

@property(nonatomic,retain) NSString * memberId,*memberName,*datetime,*medicineName;  
@property(nonatomic)float quantityTaken;
@property(nonatomic)int doseNumber,logId,medicineId,userId;

@end
