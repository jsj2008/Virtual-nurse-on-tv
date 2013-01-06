//
//  pickerMed.h
//  PickerViewMed
//
//  Created by Avi kulkarni on 18/02/12.
//  Copyright (c) 2012 techindia@panhealth.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classMedicine.h"

@protocol ApperanceMedProtocol
-(void)doneMedApperance;
-(void)cancelMedApperance;

@end

@interface pickerMed : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray * pillSizeArray;
    NSMutableArray * pillShapeImageNameArray;
    NSMutableArray * pillColorNameArray;
    
    IBOutlet UIImageView *imgTab;
    IBOutlet UIPickerView * myPicker;

    int Component1SelectedRow;
    int Component2SelectedRow;
    int Component3SelectedRow;
    
    classMedicine * objMedicine;

}

// Properties
@property (nonatomic,retain) NSMutableArray * pillSizeArray;
@property (nonatomic,retain) NSMutableArray * pillShapeImageNameArray;
@property (nonatomic,retain) NSMutableArray * pillColorNameArray;
@property (retain, nonatomic)  UIPickerView *myPicker;
@property (retain, nonatomic) IBOutlet UIImageView *imgTab;
@property (nonatomic, retain)    classMedicine * objMedicine;



// Methods
-(UIImage * )getImageNameForSize:(int)size forShape:(int)shape forColor:(int)color;
-(void)goBack;
-(void)done;


@end
