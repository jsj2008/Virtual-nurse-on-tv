//
//  medicineStatus.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 3/26/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classUser.h"
#import "remindMed.h"
@interface medicineStatus : UITableViewController
{
    NSMutableArray *takenArray;
    NSMutableArray *skipArray;
     NSMutableArray *laterArray;
    classUser *obj_user;
    classMedicine *med_obj;
    int index;
}
@property(nonatomic,retain)NSMutableArray *takenArray;
@property(nonatomic,retain)NSMutableArray *skipArray;
@property(nonatomic,retain)NSMutableArray *laterArray;
@property(nonatomic,retain) classUser *obj_user;
@property(nonatomic,retain) classMedicine *med_obj;
//-(void)Cancel;
@end
