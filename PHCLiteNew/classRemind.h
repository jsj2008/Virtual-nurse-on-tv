//
//  classRemind.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 4/26/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  classUser;
@interface classRemind : UITableViewController
{
UITableView *tableView1;
UISwitch *switchWeight;
UISwitch *switchGlucose;
UISwitch *switchBP;
UISwitch *switchHeamo;
UISwitch *switchHba1c;
NSMutableArray *arrayName;
UIBarButtonItem *Btnsave;
    classUser *aUser;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView1;
@property (nonatomic, retain) IBOutlet UISwitch *switchWeight;
@property (nonatomic, retain) IBOutlet UISwitch *switchGlucose;
@property (nonatomic, retain) IBOutlet UISwitch *switchBP;
@property (nonatomic, retain) IBOutlet UISwitch *switchHeamo;
@property (nonatomic, retain) IBOutlet UISwitch *switchHba1c;
@property(nonatomic,retain) IBOutlet classUser *aUser;
-(void)TouchSave;
//-(void)Cancle;
@end
