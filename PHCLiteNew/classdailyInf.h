//
//  classdailyInf.h
//  PHCLite_New
//
//  Created by Avi Kulkarni on 08/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class classDiffTime;
@interface classdailyInf : UIViewController {
    
    UITableView *tableview1;
      NSArray *array_name;
    NSMutableArray *arryTime;
    NSArray *array_Time;
    UILabel *lblName1;
    
    classDiffTime *obj_time;
    UITableView *tableView1;
    UIPickerView *Picker_View;
    UIView *BackSideView;
    UIView *PickerBackView;
    UIPickerView *PickerView1;
    UILabel *lbl1;
    
    
}
@property(nonatomic,retain)classDiffTime *obj_time;

@property (nonatomic, retain) IBOutlet UITableView *tableview1;
@property (nonatomic, retain) IBOutlet UILabel *lblName1;
-(void)cancle;
@property (nonatomic, retain) IBOutlet UITableView *tableView1;
@property (nonatomic, retain) IBOutlet UIPickerView *Picker_View;

@property (nonatomic, retain) IBOutlet UIView *BackSideView;
@property (nonatomic, retain) IBOutlet UIView *PickerBackView;
@property (nonatomic, retain) IBOutlet UIPickerView *PickerView1;

@property(nonatomic,retain)UILabel *lbl1;

@end
