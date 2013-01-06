 	//
//  vcUserList.m
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 9/15/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "vcUserList.h"
#import "classUser.h"
#import "classDatabaseOperations.h"
#import "classNewUser.h"
#import "classDeleteMember.h"
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
#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

@implementation vcUserList

@synthesize myAudioPlayer;
@synthesize arrayOfUsers;
@synthesize navC;
@synthesize objMesureGlucose;
@synthesize nav1;
@synthesize nav2;
@synthesize nav3;
@synthesize nav4;
@synthesize nav5;
@synthesize arrayofControllers;
@synthesize arrayFlags;
@synthesize aUser;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    
    [arrayOfUsers release];
    [super dealloc];
    
}



//-(void)setArrayOfUsers:(NSMutableArray *)newArray
//{
//    
//    if(newArray!=arrayOfUsers)
//    {
//        [arrayOfUsers release];
//        
//        arrayOfUsers=[newArray mutableCopy];
//        
//        
//        
//    }
//    
//    return;
//    
//    
//}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    
    
    
    [super viewDidLoad];

        self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(methodAddNewMember)] autorelease];
   
   
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete.png"] style:UIBarButtonItemStylePlain target:self action:@selector(methodDeleteMember)] autorelease];
    [self.tableView setSeparatorColor:[UIColor blackColor]];
    
    [[self tableView] setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]]];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];

    [self methodGetUserListFromDatabase];
    //[self customAudio];
    
       }

-(void)customAudio
{
    NSMutableArray * array=[[NSMutableArray alloc] init];
    if(!mediaPath)
    {
		mediaPath = [[NSString stringWithFormat:@"%@/welcome", DOCUMENTS_FOLDER] retain];
        if(soundID)	{
            
            AudioServicesDisposeSystemSoundID(soundID);
            
        }
        NSURL *filePath = [NSURL fileURLWithPath:mediaPath isDirectory:NO];
        NSLog(@"File Path %@",filePath);
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:mediaPath];
        NSLog(@"File Path %d",fileExists);
        if (fileExists==YES) {
            AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
            //Use audio services to play the sound
            AudioServicesPlaySystemSound(soundID);
        }
        else
        {
            [array addObject:@"welcome"];
            
        }
    }
	
	
    
    [self.myAudioPlayer playAudios:array];
    [array release];

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [self methodGetUserListFromDatabase];
    [self.tableView reloadData];
      [super viewWillAppear:animated];

       
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];

     //[self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.arrayOfUsers count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *idLabel,*userLabel;
   NSInteger DATE_LABEL_TAG = 1001;
	NSInteger AmtLabelTag=1002;
    static NSString *CellIdentifier = @"Cell";

  
    idLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, 180, 50)];
    userLabel=[[UILabel alloc]initWithFrame:CGRectMake(60,0, 125, 40)];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

        cell.textLabel.font=[UIFont fontWithName:@"Futura" size:14.0f];
        cell.detailTextLabel.font=[UIFont fontWithName:@"Futura" size:12.0f];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryView=nil;
        
        idLabel.tag=AmtLabelTag;
        idLabel.backgroundColor = [UIColor clearColor];
        idLabel.textColor = [UIColor grayColor];
        idLabel.font = [UIFont systemFontOfSize:12.0f];
        idLabel.textAlignment=UITextAlignmentLeft;
        [cell.contentView addSubview:idLabel];
       
        userLabel.tag=DATE_LABEL_TAG;
        userLabel.backgroundColor = [UIColor clearColor];
        userLabel.font = [UIFont systemFontOfSize:15.0f];
        [cell.contentView addSubview:userLabel];
           

        
    }
    aUser=[self.arrayOfUsers objectAtIndex:indexPath.row];

    if([aUser.memberId isEqualToString:@""])
    {
        idLabel.text=@"Not registered with Panhealth";
       NSString * imgName = [NSString stringWithFormat:@"%@%@",aUser.firstName, aUser.lastName];
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
       NSString *documentsDir = [documentPaths objectAtIndex:0];
       NSString * databasePath = [documentsDir stringByAppendingPathComponent:imgName];
       UIImage * medicineImage=[UIImage imageWithContentsOfFile:databasePath];
     UIImageView *userImage=[[UIImageView alloc]initWithImage:medicineImage];
        [cell.contentView addSubview:userImage];
        [userImage setFrame:CGRectMake(5, 5, 40, 40)];
       [userImage release];
        
   userLabel.text=[NSString stringWithFormat:@"%@ %@",aUser.firstName,aUser.lastName ];
       }
    
    else
    {

        userLabel.text=[NSString stringWithFormat:@"%@ %@",aUser.firstName,aUser.lastName ];
        idLabel.text=[NSString stringWithFormat:@"Panhealth Id: %@",aUser.memberId];
          NSLog(@"%@ %@",aUser.firstName,aUser.lastName);
        NSLog(@"%@",aUser.memberId);

        NSString * imgName = [NSString stringWithFormat:@"%@%@",aUser.firstName, aUser.lastName];
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString * databasePath = [documentsDir stringByAppendingPathComponent:imgName];
        UIImage * medicineImage=[UIImage imageWithContentsOfFile:databasePath];
        UIImageView *userImage=[[UIImageView alloc]initWithImage:medicineImage];
       [userImage setFrame:CGRectMake(5, 5, 40, 40)];
       [cell.contentView addSubview:userImage];
        [userImage release];

    }
    // Configure the cell...
    // get path of document directory to get medicne image
       return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
	
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
     cell.textLabel.backgroundColor =[UIColor clearColor] ;
    cell.detailTextLabel.backgroundColor=[UIColor clearColor];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self methodGetUserListFromDatabase];
    
  
    aUser=[self.arrayOfUsers objectAtIndex:indexPath.row];
    
      [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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

#pragma mark instance methods
//************************************************************************************************
// instance methds
-(void)methodGetUserListFromDatabase
{
    
    self.arrayOfUsers=[classDatabaseOperations getUserList];
    [self.tableView reloadData];
    
    
}
-(void)methodAddNewMember
{
    
    
    classNewUser * objNewMember=[[classNewUser alloc] initWithNibName:@"classNewUser" bundle:nil];
    objNewMember.tabBarItem.title=@"New Member";
    objNewMember.tabBarItem.image=[UIImage imageNamed:@"userImage"];
    objNewMember.delegate=self;
    objNewMember.myAudioPlayer=self.myAudioPlayer;
    objNewMember.arrayOfUsers=self.arrayOfUsers;
    self.navC=[[[UINavigationController alloc] initWithRootViewController:objNewMember] autorelease];
    [objNewMember release];
    
   /* //object of classLog
    classLog *objLog=[[classLog alloc]initWithNibName:@"classLog" bundle:nil];
    objLog.tabBarItem.title=@"Log";
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
      nav3=[[[UINavigationController alloc]initWithRootViewController:objSetting]autorelease];
    [objSetting release];
    
    
    
       
    arrayofControllers=[[NSMutableArray alloc]initWithObjects:navC,nav1,nav2,nav3, nil];
    
    UITabBarController *tabbar=[[UITabBarController alloc]init];
    
    tabbar.viewControllers = arrayofControllers;
    
    [self presentModalViewController:tabbar animated:YES];*/
    
    

    
    [self presentModalViewController:navC animated:YES];
    
    
}
-(void)methodDeleteMember
{
    
    
    classDeleteMember * objDeleteMember=[[classDeleteMember alloc] initWithStyle:UITableViewStyleGrouped];
    objDeleteMember.title=@"Delete Member";
    objDeleteMember.arrayOfUsers=self.arrayOfUsers;
   objDeleteMember.myAudioPlayer=self.myAudioPlayer;

    objDeleteMember.delegate=self;
    UINavigationController * navC1=[[[UINavigationController alloc] initWithRootViewController:objDeleteMember] autorelease];
    [objDeleteMember release];
    [self presentModalViewController:navC1 animated:YES];
    
    
    
    
    
}

#pragma mark protocol delegate  methods
//********************************************************************************************************
// protocol delegate methods

-(void)doneAddingNewUser
{
    
    
    [self dismissModalViewControllerAnimated:YES];
    [self.tableView reloadData];
    
    
}

-(void)cancelAddingNewUser
{
    
    
    [self dismissModalViewControllerAnimated:YES];
    
    
}


-(void)doneDeletingMember
{
    
    
    [self.tableView reloadData];

    
    
}
-(void)cancelDeletingMember
{
    
    
    [self dismissModalViewControllerAnimated:YES];

    
}



@end
