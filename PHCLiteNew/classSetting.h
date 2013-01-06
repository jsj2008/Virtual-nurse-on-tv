//
//  classSetting.h
//  PHCLite
//
//  Created by Avi Kulkarni on 8/5/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classDatabaseOperations.h"
#import "classUser.h"


@interface classSetting : UITableViewController {
    
    
    NSMutableArray *arrayFlags;
    classUser *userObj;
    
}
@property(nonatomic,retain) NSMutableArray *arrayFlags;



@end
