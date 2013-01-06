//
//  classDiffTime.h
//  PHCLite_New
//
//  Created by Avi Kulkarni on 06/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol parsetheProtocol 

-(void)selectCancle;



@end

@interface classDiffTime : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    id<parsetheProtocol>delegate;
    
    UILabel *lblName;
    NSArray *array_name;
    NSString *strName;
    NSString *str_Name2;
   // UISwitch *SwitchButton;
    UISwitch *BtnSwitch;
   
    
    
    UITableView *tableViewNew;
}

@property (nonatomic, retain) IBOutlet UILabel *lblName;
@property(nonatomic,retain) NSString *strName;
@property(nonatomic,retain)NSString *str_Name2;
//-----------------------------------------------------
@property (nonatomic, retain) IBOutlet UISwitch *SwitchButton;
@property(nonatomic,retain)UISwitch *BtnSwitch;
-(void)selectSwitchBtn;
@property(nonatomic,retain)id<parsetheProtocol>delegate;

@property (nonatomic, retain) IBOutlet UITableView *tableViewNew;

-(void)Save;
-(void)cancle;
@end
