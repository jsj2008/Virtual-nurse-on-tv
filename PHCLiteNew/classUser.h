//
//  classUser.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 7/29/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


 @interface  classUser : NSObject 
{
    
    int  userId,pwdStatus;
    NSString * firstName,*middleName,*lastName,*gender,*emailId,*phoneNo,*password,*memberId,*careGiverEmail,*CareGiverPhone;
    NSMutableArray * medicineList;
    int language;
    BOOL audioStatus;
    UIImage *userImage;
    
}
@property(nonatomic,) int userId,pwdStatus;
@property(nonatomic,retain)NSString * firstName,*middleName,*lastName,*gender,*emailId,*phoneNo,*password,*memberId,*careGiverEmail,*CareGiverPhone;
@property(nonatomic,retain)    NSMutableArray * medicineList;
@property(nonatomic)    BOOL audioStatus;

@property(nonatomic,) int language;
@property(nonatomic,retain)    UIImage *userImage;

@end
