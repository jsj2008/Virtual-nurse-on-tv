//
//  classMonthlyDetails.h
//  PHCLiteNew
//
//  Created by Avi Kulkarni on 27/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classUser.h"

@interface classMonthlyDetails : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSString *label;
     classUser *aUser;
    UITableView *table_view;
    NSMutableArray *Array_name;
}
@property (nonatomic, retain) IBOutlet UITableView *table_view;
@property(nonatomic,retain)NSMutableArray *Array_name;
@property(nonatomic,retain)  classUser *aUser;
@property(nonatomic,retain)NSString *label;
-(void)Save;
-(void)Cancel;


@end
