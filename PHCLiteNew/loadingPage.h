//
//  loadingPage.h
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 2/22/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loadingPage : UIViewController
{

    IBOutlet UIView *modelView ;    
    
    
}

-(void)showSplash;
-(void)hideSplash;
@end
