//
//  careGivingInfo.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 4/9/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classUser.h"

@interface careGivingInfo : UITableViewController
{
    UIImage *image;
   classUser *aUser;
}
@property(nonatomic,retain) UIImage *image;
 @property(nonatomic,retain)  classUser *aUser;
@end
