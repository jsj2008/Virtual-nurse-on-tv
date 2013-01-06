//
//  classNotification.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 4/19/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classUser.h"
@interface classNotification : UITableViewController
{
    classUser *aUser;
    NSString *label;
}
@property(nonatomic,retain) classUser *aUser;
@property(nonatomic,retain)NSString *label;
@end
