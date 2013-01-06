//
//  careGivingInfo.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 4/9/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classUser.h"
#import "classSetting3.h"
#import "classCareGiver.h"
@interface careGivingInfo : UITableViewController
{
    UIImage *image;
   classUser *aUser;
    classSetting3  *settingObj;
    NSMutableArray *arrayOfCarGiver;
    classCareGiver *classCareGiverObj;
    int i;

}
@property(nonatomic,retain) UIImage *image;
 @property(nonatomic,retain)  classUser *aUser;
@property(nonatomic,retain)  classCareGiver *classCareGiverObj;
-(void)methodGetCareGiverListFromDatabase;

@end
