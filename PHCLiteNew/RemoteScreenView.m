//
//  RemoteScreenView.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 1/6/13.
//  Copyright (c) 2013 PanHealth Inc. All rights reserved.
//

#import "RemoteScreenView.h"
#import "classUser.h"
#import "classDatabaseOperations.h"
#import "classAudio.h"
#import "classLog.h"
#import "classSynkData.h"
#import "classSetting3.h"
#import "classMesureGlucose1.h"
#import "classMesureWeight2.h"
#import "classGlycoHemoglobin.h"
#import "tvcMedicineList.h"
#import "remindMed.h"
#import "commanFunctions.h"
#import "classHome.h"
#import "classMedicine.h"

@interface RemoteScreenView ()

@end

@implementation RemoteScreenView
@synthesize myAudioPlayer;
@synthesize navC;
@synthesize nav1;
@synthesize nav2;
@synthesize nav3;
@synthesize nav4;
@synthesize nav5;
@synthesize arrayofControllers;
@synthesize aUser;
@synthesize arrayFlags;
@synthesize arrayOfUsers;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self methodGetUserListFromDatabase];
  /*  UverseConnectedManager *uvcMgr = [UverseConnectedManager sharedManager];
   [self registerForNotifications];
    if(uvcMgr.state == LibraryNotReady){
    [uvcMgr startDiscovery];
    }
    if (uvcMgr.state != LibraryReady){
        
       
    }
    
    if (uvcMgr.mostRecentlyEngagedSetTopBox == nil){
        self.title = @"No Receiver";
        [self connectToReceiver];
    }*/
    // Do any additional setup after loading the view from its nib.
}
/*
-(void)uveMgrDidChangeState:(NSNotification *)notification{
    
    UverseConnectedManager *uvcMgr = [UverseConnectedManager sharedManager];
    
    switch(uvcMgr.state) {
        case LibraryReady:{
            NSLog(@"NOTIFICATION UverseConnectedManagerDidChangeState: LibraryReady");
                      
           [self associateToSTBAfterDiscovery];
            
            break;
        }
        case LibraryNotReady:{
         
            NSLog(@"NOTIFICATION UverseConnectedManagerDidChangeState: LibraryNotReady");
            break;
        }
        case DiscoveringNetwork:{
            NSLog(@"NOTIFICATION UverseConnectedManagerDidChangeState: DiscoveringNetwork");
          
            break;
        }
        case LibraryBlocked:{
                     NSLog(@"NOTIFICATION UverseConnectedManagerDidChangeState: LibraryBlocked");
            break;
        }
        case WaitingForWiFiConnection:{
            NSLog(@"NOTIFICATION UverseConnectedManagerDidChangeState: WaitingForWiFiConnection");
           
            break;
        }
    }
}
*/
-(IBAction)ButtonTapMethod:(id)sender
{
    UIButton* button= (UIButton*)sender;
    if (button.tag==0) {
        [self connectToReceiver];
        
    }
    else
    {
        
    }
       
    aUser=[self.arrayOfUsers objectAtIndex:0];
    
    
    classHome *objHome=[[classHome alloc ]initWithNibName:@"classHome" bundle:nil ];
    objHome.tabBarItem.image=[UIImage imageNamed:@"home.png"];
    objHome.aUser=aUser;
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:@"on" forKey:[NSString stringWithFormat:@"audioStatus%d",aUser.userId]];
    [userDefaults setObject:@"1" forKey:[NSString stringWithFormat:@"languageselected%d",aUser.userId]];
    
    objHome.myAudioPlayer=self.myAudioPlayer;
    navC=[[[UINavigationController alloc]initWithRootViewController:objHome ]autorelease];
    
    self.navC.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    
    
    [objHome release];
    arrayofControllers=[[NSMutableArray alloc]initWithObjects:navC,nil];
    
    
    
    //object of classLog
    classLog *objLog=[[classLog alloc]initWithNibName:@"classLog" bundle:nil];
    objLog.tabBarItem.title=@"Log";
    objLog.aUser=self.aUser;
    objLog.tabBarItem.image=[UIImage imageNamed:@"log.png"];
    nav1=[[[UINavigationController  alloc]initWithRootViewController:objLog]autorelease];
    [objLog release];
    
    //    //object of classSynk
    //     classSynkData  *objSynk=[[classSynkData alloc]initWithNibName:@"classSynkData" bundle:nil];
    //    objSynk.objUser=aUser;
    //    objSynk.tabBarItem.title=@"Sync";
    //    objSynk.tabBarItem.image=[UIImage imageNamed:@"synk.png"];
    //    nav2=[[[UINavigationController alloc]initWithRootViewController:objSynk]autorelease];
    //    [objSynk release];
    
    //object of classSetting
    classSetting3 *objSetting=[[classSetting3 alloc]initWithNibName:@"classSetting3" bundle:nil];
    objSetting.tabBarItem.title=@"Setting";
    objSetting.tabBarItem.image=[UIImage imageNamed:@"setting.png"];
    objSetting.aUser=aUser;
    objSetting.myAudioPlayer=self.myAudioPlayer;
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
    
    
    
    
    
    NSDate* currenDate = [NSDate date];
    NSString *CurrentTime =[currenDate description];
    int i=[commanFunctions getTimeSpanOfTime:CurrentTime];
    NSMutableArray  *med= [commanFunctions getMedicineIndexForTimeSpan:i forUser:aUser];
    NSMutableArray *medArray=[classDatabaseOperations generateMedicineListForTime:med:aUser];
    NSLog(@"[classDatabaseOperations generateMedicineListForTime:med:aUser] %@",[classDatabaseOperations generateMedicineListForTime:med:aUser]);
    remindMed *obj_med=[[remindMed alloc]initWithNibName:@"remindMed" bundle:nil];
    obj_med.tabBarItem.title=@"Take Med";
    obj_med.tabBarItem.image=[UIImage imageNamed:@"synk.png"];
    obj_med.medArray=medArray;
    obj_med.arrayFlags=arrayFlags;
    obj_med.myAudioPlayer=self.myAudioPlayer;
    obj_med.aUser=aUser;
    
    if (medArray.count==0) {
        
        nav5=[[UINavigationController alloc] initWithRootViewController:obj_med];
        [obj_med release];
        
    }
    else
    {
        classMedicine *medicine=[medArray objectAtIndex:0];
        obj_med.med_obj=medicine;
        nav5=[[UINavigationController alloc] initWithRootViewController:obj_med];
        [obj_med release];
    }
    
    // arrayofControllers=[[NSMutableArray alloc]initWithObjects:self.navC,self.nav1,self.nav2,self.nav3, nil];
    // navC.navigationBar.tintColor=[UIColor blackColor];
    // navC.navigationItem.leftBarButtonItem=YES;
    
    nav1.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    
    nav2.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    
    nav3.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    
    nav4.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    
    nav5.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    
    [arrayofControllers addObject:nav1];
    //[arrayofControllers addObject:nav2];
    [arrayofControllers addObject:nav3];
    [arrayofControllers addObject:nav4];
    [arrayofControllers addObject:nav5];
    UITabBarController *tabbar=[[UITabBarController alloc]init];
    
    tabbar.viewControllers = arrayofControllers;
    tabbar.moreNavigationController.navigationBar.tintColor = [UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    
    [self presentModalViewController:tabbar animated:YES];
    

}

#pragma mark - IBActions

-(void)associateToSTBAfterDiscovery{
    UverseConnectedManager *uvcMgr = [UverseConnectedManager sharedManager];
    SetTopBox *lastUsedSTB = uvcMgr.mostRecentlyEngagedSetTopBox;
    if (lastUsedSTB != nil){
        if (lastUsedSTB.mode == UverseModeOpen || (lastUsedSTB.mode == UverseModeManaged && lastUsedSTB.isAssociated)){
            [lastUsedSTB associateAndEngageWithOneTimeToken:nil];
            self.title = uvcMgr.mostRecentlyEngagedSetTopBox.friendlyName;
        }else {
            [self connectToReceiver];
        }
    } else {
        [self connectToReceiver];
    }
}

-(void)connectToReceiver
{
    UverseConnectedManager *uvcMgr  = [UverseConnectedManager sharedManager];
    if (uvcMgr.state == LibraryReady && uvcMgr.SetTopBoxes != nil){
        aUser=[self.arrayOfUsers objectAtIndex:0];
        
        
        classHome *objHome=[[classHome alloc ]initWithNibName:@"classHome" bundle:nil ];
        objHome.tabBarItem.image=[UIImage imageNamed:@"home.png"];
        objHome.aUser=aUser;
        NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
        
        [userDefaults setObject:@"on" forKey:[NSString stringWithFormat:@"audioStatus%d",aUser.userId]];
        [userDefaults setObject:@"1" forKey:[NSString stringWithFormat:@"languageselected%d",aUser.userId]];
        
        objHome.myAudioPlayer=self.myAudioPlayer;
        navC=[[[UINavigationController alloc]initWithRootViewController:objHome ]autorelease];
        
        self.navC.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
        
        
        [objHome release];
        arrayofControllers=[[NSMutableArray alloc]initWithObjects:navC,nil];
        
        
        
        //object of classLog
        classLog *objLog=[[classLog alloc]initWithNibName:@"classLog" bundle:nil];
        objLog.tabBarItem.title=@"Log";
        objLog.aUser=self.aUser;
        objLog.tabBarItem.image=[UIImage imageNamed:@"log.png"];
        nav1=[[[UINavigationController  alloc]initWithRootViewController:objLog]autorelease];
        [objLog release];
        
        //    //object of classSynk
        //     classSynkData  *objSynk=[[classSynkData alloc]initWithNibName:@"classSynkData" bundle:nil];
        //    objSynk.objUser=aUser;
        //    objSynk.tabBarItem.title=@"Sync";
        //    objSynk.tabBarItem.image=[UIImage imageNamed:@"synk.png"];
        //    nav2=[[[UINavigationController alloc]initWithRootViewController:objSynk]autorelease];
        //    [objSynk release];
        
        //object of classSetting
        classSetting3 *objSetting=[[classSetting3 alloc]initWithNibName:@"classSetting3" bundle:nil];
        objSetting.tabBarItem.title=@"Setting";
        objSetting.tabBarItem.image=[UIImage imageNamed:@"setting.png"];
        objSetting.aUser=aUser;
        objSetting.myAudioPlayer=self.myAudioPlayer;
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
        
        
        
        
        
        NSDate* currenDate = [NSDate date];
        NSString *CurrentTime =[currenDate description];
        int i=[commanFunctions getTimeSpanOfTime:CurrentTime];
        NSMutableArray  *med= [commanFunctions getMedicineIndexForTimeSpan:i forUser:aUser];
        NSMutableArray *medArray=[classDatabaseOperations generateMedicineListForTime:med:aUser];
        NSLog(@"[classDatabaseOperations generateMedicineListForTime:med:aUser] %@",[classDatabaseOperations generateMedicineListForTime:med:aUser]);
        remindMed *obj_med=[[remindMed alloc]initWithNibName:@"remindMed" bundle:nil];
        obj_med.tabBarItem.title=@"Take Med";
        obj_med.tabBarItem.image=[UIImage imageNamed:@"synk.png"];
        obj_med.medArray=medArray;
        obj_med.arrayFlags=arrayFlags;
        obj_med.myAudioPlayer=self.myAudioPlayer;
        obj_med.aUser=aUser;
        
        if (medArray.count==0) {
            
            nav5=[[UINavigationController alloc] initWithRootViewController:obj_med];
            [obj_med release];
            
        }
        else
        {
            classMedicine *medicine=[medArray objectAtIndex:0];
            obj_med.med_obj=medicine;
            nav5=[[UINavigationController alloc] initWithRootViewController:obj_med];
            [obj_med release];
        }
        
        // arrayofControllers=[[NSMutableArray alloc]initWithObjects:self.navC,self.nav1,self.nav2,self.nav3, nil];
        // navC.navigationBar.tintColor=[UIColor blackColor];
        // navC.navigationItem.leftBarButtonItem=YES;
        
        nav1.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
        
        nav2.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
        
        nav3.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
        
        nav4.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
        
        nav5.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
        
        [arrayofControllers addObject:nav1];
        //[arrayofControllers addObject:nav2];
        [arrayofControllers addObject:nav3];
        [arrayofControllers addObject:nav4];
        [arrayofControllers addObject:nav5];
        UITabBarController *tabbar=[[UITabBarController alloc]init];
        
        tabbar.viewControllers = arrayofControllers;
        tabbar.moreNavigationController.navigationBar.tintColor = [UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
        
        [self presentModalViewController:tabbar animated:YES];
    } else if (uvcMgr.state == LibraryNotReady) {
        [uvcMgr startDiscovery];
    } else {
        // if the middle of Discovery
    }
}

#pragma mark - Notification Callbacks
-(void)uveSTBCommandSucceeded:(NSNotification *)notification
{
    NSLog(@"NOTIFICATION uvcSetTopBoxCommandDidSucceed");
}

-(void)uveMgrErrorOccurred:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSError *error = [userInfo objectForKey:UverseConnectedManagerErrorKey];
    
    NSString *msg = [NSString stringWithFormat:@"Code %d", error.code];
    switch(error.code)
    {
        case uveNotOnAUverseNetwork:
            msg = @"Not on Uverse Network";
            break;
        case uveInternalError:
            msg = @"UVE Internal Error";
            break;
        case uveNetworkError:
            msg = @"Zeus Network Error";
            break;
        case uveApplicationBlocked:
            msg = @"UVE applicaiton has been disabled";
            break;
        case uveDeviceRegistrationError:
            msg = @"UVE Device Registration Error";
            break;
        case uveAuthTokenRequired:
            msg = @"UVE Auth Token Required";
            break;
        case uveAuthTokenInvalid:
            msg = @"UVE Auth Token Invalid";
            break;
        case uveNotOnSubscriberNetwork:
            msg = @"Not on Subscriber Network";
            break;
        case uveDeviceNotAllowedToRun:
            msg = @"This device is not allowed to be used in this household.";
            break;
        case uveLibrarySessionExpired:
            msg = @"Your Session has expired. Please restart discovery";
            [[UverseConnectedManager sharedManager] startDiscovery];
            break;
        default:
            break;
    }
    NSLog(@"NOTIFICATION UverseConnectedManagerErrorOccurred: %@", msg);
    [self performSelectorOnMainThread:@selector(showAlert:) withObject:msg waitUntilDone:YES];
}

-(void)showAlert:(NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void)uveSTBChannelOrProgramChanged:(NSNotification *)notification
{
    
    NSLog(@"program changed!");
}

-(void)uveSTBEngagementFailed:(NSNotification*)notification
{
    NSLog(@"STB Engagement Failed");
    [self performSelectorOnMainThread:@selector(showAlert:) withObject:@"STB Engagement Failed" waitUntilDone:YES];
}

-(void)uveSTBEngagementSucceeded:(NSNotification*)notification
{
    NSLog(@"STB Engagement Successful");
    self.title = [[UverseConnectedManager sharedManager] mostRecentlyEngagedSetTopBox].friendlyName;
    //[self performSelectorOnMainThread:@selector(showAlert:) withObject:@"STB Engagement Successful" waitUntilDone:YES];
}

-(void)methodGetUserListFromDatabase
{
    self.arrayOfUsers=[classDatabaseOperations getUserList];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
