//
//  classMedicine.h
//  istrips_bpsi
//
//  Created by Avi Kulkarni on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class classMedicineTime;
@interface classMedicine : NSObject
{
	
	int      medicineSequenceId;
	NSString *medicineName;
	
	int		 medicineDosesFrequency;
	NSString *medicineComments;     
    
    float totalPillQuantity;
    ///Users/bpsi_avi/Desktop/PHCLite 14/PHCLiteNew/classMedicine.m;
    int reorderLevel;
    
    UIImage *medicineImage;
    NSString * audioFileName;
    
	NSMutableArray * medicineTimes;
    
    int doseNumber;
	
    
    
	
	//medicine side effects etc
	
}



@property(nonatomic,retain)NSString *medicineName,*medicineComments;
@property(nonatomic) int  medicineSequenceId,medicineDosesFrequency;
@property(nonatomic)     float totalPillQuantity;
@property(nonatomic)        int reorderLevel;
@property(nonatomic)int doseNumber;
@property(nonatomic,retain)    UIImage *medicineImage;
@property(nonatomic,retain)    NSString * audioFileName;


@property(nonatomic,retain)NSMutableArray * medicineTimes;

@end
