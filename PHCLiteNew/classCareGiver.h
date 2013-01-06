//
//  classCareGiver.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 9/10/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface classCareGiver : NSObject
{
int  userId;
NSString *Name,*emailId,*phoneNo;
int language;
UIImage *caregiverImage;

}
@property(nonatomic,) int userId;
@property(nonatomic,retain)NSString *Name,*emailId,*phoneNo;
@property(nonatomic,retain)    UIImage *caregiverImage;
@end
