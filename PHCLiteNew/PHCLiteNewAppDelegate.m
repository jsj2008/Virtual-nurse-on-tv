//
//  PHCLiteNewAppDelegate.m
//  PHCLiteNew
//
//  Created by Avi Kulkarni on 16/09/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "PHCLiteNewAppDelegate.h"
#import "classDatabaseOperations.h"
#import "classAudio.h"
#import "vcUserList.h"
#import "loadingPage.h"
#import "classUser.h"
#import "classHome.h"
#import "classLog.h"
#import "classSynkData.h"
#import "classSetting3.h"
#import "tvcMedicineList.h"
#import   "classMedicine.h"
#import "classAudio.h"
#import "RemoteScreenView.h"

@implementation PHCLiteNewAppDelegate
@synthesize objUserList;
@synthesize navC,nav1,nav2,nav3,nav4,nav5;
@synthesize memberId;
@synthesize memberName;
@synthesize window=_window;
@synthesize objLoad;
@synthesize aUser;
@synthesize arrayofControllers,arrayOfUsers;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    /********START: uve setup********/
    NSLog(@"AAP_DEVELOPER_KEY: %@", AAP_DEVELOPER_KEY);
    NSLog(@"AAP_RESOURCE_FILE: %@", AAP_RESOURCE_FILE);
    NSLog(@"SERVER_URL: %@", SERVER_URL);
    NSURL *url = [[NSBundle mainBundle] URLForResource:AAP_DEVELOPER_KEY withExtension:nil];
    NSString *sharedSecret = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:NULL];
    
    UverseConnectedManager *mgr = [UverseConnectedManager sharedManager];
    [mgr.userInfo setObject:sharedSecret forKey:UverseEnabledDeveloperKey];
    
    mgr.fileNameAAP = AAP_RESOURCE_FILE;
    mgr.overrideURL = SERVER_URL;
    /********END: uve setup********/
     UILocalNotification *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:@"1" forKey:[NSString stringWithFormat:@"languageselected"]];
    if (localNotif) { 
    
        classAudio *myAudioPlayer=[[classAudio alloc]init];
         
          
       /*    NSMutableDictionary * currentUserInfo=[[NSMutableDictionary alloc] init];*/
        
         //      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                //   int   userId = [[defaults objectForKey:@"userId"]intValue];
        int userid=[[localNotif.userInfo objectForKey:@"userId"]intValue];                                 
       arrayOfUsers=[classDatabaseOperations getUserList];
        
        for( classUser *obj1  in arrayOfUsers )
        {
           if(obj1.userId == userid) 
           {
               aUser=obj1;
               
               break;
           }
        }
        
        /*
           currentUserInfo=[localNotif setObject:[NSString stringWithFormat:@"%d", objUser.userId] forKey:@"userId"];
           [localNotif setObject:[NSString stringWithFormat:@"%d",Afternoon] forKey:@"timeSpan"];
   
         */ 
           
           
           classHome *obj=[[classHome alloc]initWithNibName:@"classHome" bundle:nil];
          
             obj.aUser=aUser;      
        obj.notification=localNotif;
         obj.myAudioPlayer=myAudioPlayer;
           //obj.myAudioPlayer=[[[classAudio alloc] init] autorelease];
           
           self.navC=[[[UINavigationController alloc]initWithRootViewController:obj]autorelease];
        
        self.navC.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
        
        [obj release];
     /*   arrayofControllers=[[NSMutableArray alloc]initWithObjects:navC,nil];

           
          
        classLog *objLog=[[classLog alloc]initWithNibName:@"classLog" bundle:nil];
        objLog.tabBarItem.title=@"Log";
        objLog.aUser=self.aUser;
        objLog.tabBarItem.image=[UIImage imageNamed:@"log.png"];
        nav1=[[[UINavigationController  alloc]initWithRootViewController:objLog]autorelease];
        [objLog release];
        
        //object of classSynk
        classSynk *objSynk=[[classSynk alloc]initWithNibName:@"classSynk" bundle:nil];
        objSynk.tabBarItem.title=@"Synk";
        objSynk.tabBarItem.image=[UIImage imageNamed:@"synk.png"];
        nav2=[[[UINavigationController alloc]initWithRootViewController:objSynk]autorelease];
        [objSynk release];
        
        //object of classSetting
        classSetting3 *objSetting=[[classSetting3 alloc]initWithNibName:@"classSetting3" bundle:nil];
        objSetting.tabBarItem.title=@"Setting";
        objSetting.tabBarItem.image=[UIImage imageNamed:@"setting.png"];
        objSetting.aUser=aUser;
        objSetting.arrayFlags=arrayFlags;
        nav3=[[[UINavigationController alloc]initWithRootViewController:objSetting]autorelease];
        [objSetting release];
        
        tvcMedicineList * objMedicineList=[[tvcMedicineList alloc] initWithStyle:UITableViewStyleGrouped];    
        objMedicineList.objUser=aUser;
        objMedicineList.myAudioPlayer=self.myAudioPlayer;
        objMedicineList.objUser.medicineList=[classDatabaseOperations getMedicineListForUser:aUser];
        objMedicineList.title=@"Medication";
        objMedicineList.tabBarItem.image=[UIImage imageNamed:@"synk.png"];
        nav4=[[UINavigationController alloc] initWithRootViewController:objMedicineList];  
        
        NSMutableArray  * medArray=[classDatabaseOperations getMedicineListForUser:aUser];
        classMedicine *medicine=[medArray objectAtIndex:0];
        remindMed *obj_med=[[remindMed alloc]initWithNibName:@"remindMed" bundle:nil];
        obj_med.tabBarItem.title=@"Take Med";
        obj_med.tabBarItem.image=[UIImage imageNamed:@"synk.png"];
        obj_med.med_obj=medicine;
        obj_med.medArray=medArray; 
        obj_med.arrayFlags=arrayFlags;
        obj_med.myAudioPlayer=self.myAudioPlayer;
        obj_med.aUser=aUser;
        nav5=[[UINavigationController alloc] initWithRootViewController:obj_med];   
        [obj_med release];    
        
        
        // arrayofControllers=[[NSMutableArray alloc]initWithObjects:self.navC,self.nav1,self.nav2,self.nav3, nil];
        // navC.navigationBar.tintColor=[UIColor blackColor];
        // navC.navigationItem.leftBarButtonItem=YES;
        
        nav1.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
        
        nav2.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
        
        nav3.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
        
        nav4.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
        
        nav5.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
        
        [arrayofControllers addObject:nav1];
        [arrayofControllers addObject:nav2];
        [arrayofControllers addObject:nav3];
        [arrayofControllers addObject:nav4];
        [arrayofControllers addObject:nav5];
        UITabBarController *tabbar=[[UITabBarController alloc]init];
        
        tabbar.viewControllers = arrayofControllers;
        
        [self presentModalViewController:tabbar animated:YES];
           */
        
        
           [self.window addSubview:navC.view];
   
      }
    
      else{
    

         sleep(1);
    // Override point for customization after application launch.
    [classDatabaseOperations checkAndCreateDatabase]; 
    [self.window addSubview:self.objLoad.view];
    [objLoad showSplash];
    
    // check and create database
   
    
//    self.objUserList=[[[vcUserList alloc] initWithStyle:UITableViewStyleGrouped] autorelease]; 
//    self.objUserList.title=@"Member List";
    RemoteScreenView *RemoteScreenViewObject=[[RemoteScreenView alloc]initWithNibName:@"RemoteScreenView" bundle:nil];
          
    RemoteScreenViewObject.myAudioPlayer=[[[classAudio alloc] init] autorelease];
    self.navC=[[[UINavigationController alloc] initWithRootViewController:RemoteScreenViewObject] autorelease];
    
    self.navC.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    
  [self.window addSubview:self.navC.view];
    
      }[self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
