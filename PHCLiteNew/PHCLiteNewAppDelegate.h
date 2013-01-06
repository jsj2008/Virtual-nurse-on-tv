//
//  PHCLiteNewAppDelegate.h
//  PHCLiteNew
//
//  Created by Avi Kulkarni on 16/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classUser.h"
#import "UverseConnectedManager.h"

//#define __PRODUCTION__ 1
//#define __ZDEV__ 1
#define __FOUNDRY__ 1

#ifdef __PRODUCTION__
#define SERVER_URL @"https://vsapps.asp.att.net/dais/"
#define AAP_RESOURCE_FILE @"prodca.resource"
#define AAP_DEVELOPER_KEY @"prodca.satoken"
#elif defined __ZDEV__
#define SERVER_URL @"https://zdevsa.asp.att.net/dais/"
#define AAP_RESOURCE_FILE @"zdevca.resource"
#define AAP_DEVELOPER_KEY @"zdevca.satoken"
#elif defined __FOUNDRY__
#define SERVER_URL @"https://swsdcs.foundry.att.com/dais/"
#define AAP_RESOURCE_FILE @"testca.resource"
#define AAP_DEVELOPER_KEY @"testca.satoken"
#endif


@class vcUserList;
@class loadingPage;
@interface PHCLiteNewAppDelegate : NSObject <UIApplicationDelegate> 
{
    IBOutlet  UIWindow *window;
    
    vcUserList *objUserList;
    loadingPage *objLoad;
    UINavigationController *navC;
    UINavigationController *nav1;
    UINavigationController *nav2;
    UINavigationController *nav3;
    UINavigationController *nav4;
    UINavigationController *nav5;
    NSMutableArray *arrayofControllers,*arrayOfUsers;
    NSString *memberName;
    NSString *memberId;
    classUser *aUser;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property(nonatomic,retain)vcUserList *objUserList;
@property(nonatomic,retain)UINavigationController *navC,*nav1,*nav2,*nav3,*nav4,*nav5;
@property(nonatomic,retain)NSString *memberName;
@property(nonatomic,retain)NSString *memberId;
@property(nonatomic,retain)loadingPage *objLoad;
@property(nonatomic,retain)classUser *aUser;
@property(nonatomic,retain)   NSMutableArray *arrayofControllers,*arrayOfUsers;
@end
