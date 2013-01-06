//
//  changePass.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 4/14/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classUser.h"

@interface changePass : UITableViewController<UITextFieldDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>
{  
    IBOutlet UITextField *coText;
    IBOutlet UITextField *nText;
    IBOutlet UITextField *cText;
    IBOutlet UILabel *coPass;
    IBOutlet UILabel *nPass;
    IBOutlet UILabel *cPass;
    UITextField *nameField;
    UITableViewCell *cPassword;
    UITableViewCell *nPassword;
    UITableViewCell *coPassword;
    classUser *aUser;
    IBOutlet UITableViewCell *forgetPassword;

}
@property(nonatomic,retain) IBOutlet UITextField *coText;
@property(nonatomic,retain)IBOutlet UITextField *nText;
@property(nonatomic,retain) IBOutlet UITextField *cText;
@property(nonatomic,retain)classUser *aUser;
-(IBAction)forgetPasswordMethod;
- (void)savePass;
- (void)cancelPass;



@end
