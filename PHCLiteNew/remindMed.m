//
//  remindMed.m
//  PHCLiteNew
//
//  Created by Avinash Kulkarni on 3/13/12.
//  Copyright (c) 2012 PanHealth Inc. All rights reserved.
//

#import "remindMed.h"
#import "classAudio.h"
#import "classUser.h"
#import "classDatabaseOperations.h"
#import "vcUserList.h"
#import "classMedicine.h"
#import "classMedicineTime.h"
#import "medicineStatus.h"
#import "classAudio.h"
#import "commanFunctions.h"
#import "classMedicineIndex.h"
int timespan;
@class classDatabaseOperations;
@implementation remindMed

@synthesize arrayMedicineIndex;
@synthesize selectedTime;
@synthesize arrayMedicineList;

@synthesize medImg;
@synthesize comLbl;
@synthesize arrayFlags;
@synthesize medArray;
@synthesize aUser;
@synthesize lbl;
@synthesize name;
@synthesize quantity;
@synthesize comments;
@synthesize image;
@synthesize med_tobj;
@synthesize take;
@synthesize skip;
@synthesize remind;
@synthesize qtnLbl;
@synthesize nameLbl;
@synthesize backgImage;
@synthesize med_obj;
@synthesize myAudioPlayer;

@synthesize timeLbl;
@synthesize pre;
@synthesize str;
@synthesize tickImg;
@synthesize dateString;
float qty;
@synthesize strImg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)Cancle
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrayMedicineList=self.aUser.medicineList;
    self.navigationController.navigationBar.hidden=NO;
    self.arrayMedicineIndex=[commanFunctions getMedicineIndexForTimeSpan:selectedTime forUser:self.aUser];
    NSLog(@"Medicine Array %@",medArray);
    NSDateFormatter *formatter;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    dateString = [[NSString alloc] initWithFormat:@"%@", [formatter stringFromDate:[NSDate date]]];
    NSLog(@"Date String %@",dateString);
    [formatter release];
    
    [skipButton setImage:[UIImage imageNamed:@"Skipped11.png"] forState:UIControlStateNormal];
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    
    self.title=@"Take Med";
    UIBarButtonItem *barLogout=[[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(Logout)];
    self.navigationItem.rightBarButtonItem=barLogout;
    [barLogout release];
    
    NSString *strImg1=@"backImage1.png";
    strImg=[classDatabaseOperations getNurseImg:aUser.userId];
    NSLog(@"%@image",strImg);
    if ([strImg isEqualToString:@"null"])
    {
        backgImage.image=[UIImage imageNamed:strImg1];
    }
    else{
        NSLog(@"Nurse is %@",strImg);
        backgImage.image=[UIImage imageNamed:strImg];
    }
    for (int k=0; k<medArray.count; k++) {
        NSLog(@"Query%@",[medArray objectAtIndex:k]);
    }
    /* medArray=[classDatabaseOperations getMedicineListForUser:aUser];
     NSLog(@"Query%d");
     */
    int medCount=medArray.count;
    NSLog(@"Queryis %d",medCount);
    if (medCount==0) {
        
        timeLbl.text=@"";
        nameLbl.text=@"";
        comLbl.text=@"";
        qtnLbl.text=@"";
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:@"You have no medicines to take" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        alert.tag=132;
        [alert release];
        
    }
    else {
        
        
//        NSMutableArray * array=[[NSMutableArray alloc] init];
//        [array addObject:@"Its time to take medicine"];
//        [myAudioPlayer playAudios:array];
//        [array release];
        
        
        
        NSLog(@"  \n   mediciine name %@     %@        ",med_obj.medicineName,med_obj.medicineComments);
        
        // classMedicine *med_obj=[medArray objectAtIndex:0];
        NSLog(@"%@",med_obj.medicineName);
        nameLbl.text=med_obj.medicineName;
        
        NSString *query1=[NSString stringWithFormat:@"select medicinepillquantitytotake from medicinetimedetails where userid=%d and medicineid=%d",aUser.userId,med_obj.medicineSequenceId];
        
        qty =[classDatabaseOperations get:query1];
        NSLog(@"Quantity %f",qty);
        qtnLbl.text = [[NSString alloc]initWithFormat:@"%.1f",qty];
        
        NSString *query2=[NSString stringWithFormat:@"select medicinetime from medicinetimedetails where userid=%d and medicineid=%d",aUser.userId,med_obj.medicineSequenceId];
        str = [[NSString alloc] initWithFormat:@"%@", [classDatabaseOperations getString:query2]];

        NSLog(@"time %@",str);

        timeLbl.text=str;
        comLbl.text=med_obj.medicineComments;
        if(med_obj.medicineImage==NULL)
        {
            medImg.center=CGPointMake(medImg.center.x, medImg.center.y);
            medImg.image=[UIImage imageNamed:@"MediumCircleGray.png"];
        }
        else
        {
            medImg.center=CGPointMake(medImg.center.x, medImg.center.y);
            medImg.image=med_obj.medicineImage;
            
        }
      //  [query2 release];

    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
   [super viewDidAppear:animated];

    
    
}
- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"View did dissapear");

}

- (void)viewDidUnload
{
    [self setNameLbl:nil];
    [self setQtnLbl:nil];
    
    [self setComLbl:nil];
    [self setMedImg:nil];
    [self setName :nil];
    [self setQuantity :nil];
    [self setComments :nil];
    [self setImage :nil];
    [self setTickImg:nil];
    [self setTimeLbl:nil];
    
    
    
    
  //  [backImage release];
  //  backImage = nil;
    [self setBackgImage:nil];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    
    [nameLbl release];
    [qntLbl release];
    [comLbl release];
    [medImg release];
    [name release];
    [quantity release];
    [comments release];
    [image release];
    [tickImg release];
    [timeLbl release];
   // [backImage release];
    
    [backgImage release];
    [super dealloc];
}
- (IBAction)taken:(id)sender {
    if (medArray.count==0) {
        
    }
    else
    {
    tickImg.image=[UIImage imageNamed:@"tick1.png"];
    [UIView beginAnimations:nil context:nil]; 
    tickImg.center=CGPointMake(tickImg.center.x, tickImg.center.y);
    [UIView setAnimationDuration:0.1];
    [UIView commitAnimations];
        NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];

        language=[userDefaults objectForKey:[NSString stringWithFormat:@"languageselected%d",self.aUser.userId]];
        audiosatus=[userDefaults objectForKey:[NSString stringWithFormat:@"audioStatus%d",aUser.userId]];
        NSMutableArray * array=[[NSMutableArray alloc] init];
        
        if ([audiosatus isEqualToString: @"on"]) {
            if([language isEqualToString:@"1"])
            {
                [array addObject:@"taken"];
                [myAudioPlayer playAudios:array];
              
                
            }
            else if([language isEqualToString:@"2"])
            {
                [array addObject:@"27"];
                [myAudioPlayer playAudios:array];
                

            }
            
        }
        [array release];
    UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:@"You have choose taken option" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: @"Cancel",nil];
    alertReading.frame=CGRectMake(5, 5, 100, 100);
    UILabel *mname=[[UILabel alloc]init];
    mname.text=med_obj.medicineName;
   [alertReading addSubview:mname];
        [mname release];
    [alertReading show];
    alertReading.tag=116;
    [alertReading release]; 
    
    
    NSLog(@"Query");
    NSLog(@"Added");
    } 
    
}


- (IBAction)skipMethod:(id)sender {
    if (medArray.count==0) {
        
    }
    else
    { 
    tickImg.image=[UIImage imageNamed:@"tick2.png"];
    [UIView beginAnimations:nil context:nil]; 
    tickImg.center=CGPointMake(tickImg.center.x, tickImg.center.y);
    [UIView setAnimationDuration:0.1];
    [UIView commitAnimations];
    
        NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
        
        language=[userDefaults objectForKey:[NSString stringWithFormat:@"languageselected%d",self.aUser.userId]];
        audiosatus=[userDefaults objectForKey:[NSString stringWithFormat:@"audioStatus%d",aUser.userId]];
        NSMutableArray * array=[[NSMutableArray alloc] init];
        
        if ([audiosatus isEqualToString: @"on"]) {
            if([language isEqualToString:@"1"])
            {
                [array addObject:@"skip"];
                [myAudioPlayer playAudios:array];
                
            }
            else if([language isEqualToString:@"2"])
            {
                [array addObject:@"26"];
                [myAudioPlayer playAudios:array];

            }
            
        }
        [array release];

    UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Thank You!" message:@"You have choose to skip" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: @"Cancel",nil];
    UILabel *mname=[[UILabel alloc]init];
    mname.text=med_obj.medicineName;
    [alertReading addSubview:mname];
        [mname release];
    [alertReading show];
    alertReading.tag=117;
    [alertReading release]; 
    
    }
    
    
    
}

- (IBAction)remindLater:(id)sender {
    if (medArray.count==0) {
        
    }
    else
    {
    tickImg.image=[UIImage imageNamed:@"tick3.png"];
    [UIView beginAnimations:nil context:nil]; 
    tickImg.center=CGPointMake(tickImg.center.x, tickImg.center.y);
    [UIView setAnimationDuration:0.1];
    [UIView commitAnimations];
    
        NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
        
        language=[userDefaults objectForKey:[NSString stringWithFormat:@"languageselected%d",self.aUser.userId]];
        audiosatus=[userDefaults objectForKey:[NSString stringWithFormat:@"audioStatus%d",aUser.userId]];
        NSMutableArray * array=[[NSMutableArray alloc] init];
        
        if ([audiosatus isEqualToString: @"on"]) {
            if([language isEqualToString:@"1"])
            {
                [array addObject:@"remind later"];
            }
            else if([language isEqualToString:@"2"])
            {
                [array addObject:@"25"];
            }
            [myAudioPlayer playAudios:array];
            
        }
        [array release];

    
    

    
    UIAlertView *alertReading=[[UIAlertView alloc]initWithTitle:@"Medicine" message:@"You have choose to remind later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: @"Cancel",nil];
    UILabel *mname=[[UILabel alloc]init];
    mname.text=med_obj.medicineName;
    [alertReading addSubview:mname];
        [mname release];
    [alertReading show];
    alertReading.tag=118;
    [alertReading release]; 
    }
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Date String %@",dateString);
    if(alertView.tag==132)
    {
        if(buttonIndex==0)
        {
        }
    }
    
   else if(alertView.tag==116)
   {
       
       
       if(buttonIndex==0)
       {
           NSLog(@"Medicine Array %d",[medArray indexOfObject:med_obj]);
           
           int   index =0;
           index=[medArray indexOfObject:med_obj];
           NSLog(@"index %d",index);
           NSLog(@"Medicine Sequence Id %d",med_obj.medicineSequenceId);
           NSLog(@"User Id %d",aUser.userId);
           NSLog(@"String %@",str);
           NSMutableArray *result=[[NSMutableArray alloc]init];

           result=[classDatabaseOperations chkStatus:med_obj.medicineSequenceId :aUser.userId:str] ;
           NSLog(@"%d",result.count);
           if (result.count==0) {
               NSLog(@"%f",qty);
               NSString * queryString=[NSString stringWithFormat: @"insert into medicinestatus values ('%d','%d','%@','%@','%@','%@','%@','%f','%@')",aUser.userId, med_obj.medicineSequenceId ,med_obj.medicineName,med_obj.medicineComments,med_obj.medicineImage,@"taken",str,qty,dateString];

               NSLog(@"%@",queryString);
               NSLog(@"added");
               [classDatabaseOperations add:queryString];
               
               
               NSString * imgName = [NSString stringWithFormat:@"%@%@%@",med_obj.medicineName,aUser.firstName,aUser.lastName];
               // covert Medicne image to nsdata
               
               // get path of document directory to save medicne
               NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
               NSString *documentsDir = [documentPaths objectAtIndex:0];
               NSString * documentImagePth = [documentsDir stringByAppendingPathComponent:imgName];
               
               NSFileManager *fileManager = [NSFileManager defaultManager];
               [fileManager removeItemAtPath:documentImagePth error:nil];
               
               // save new image
               [self savePicture];
               
               
               
           }
           else
           {
               
               NSString *query =[[NSString alloc] initWithFormat:@"update medicinestatus set medicinename='%@', medicinecomments='%@', medicineimage='%@',medicinestatus='%@',medicineqty='%f' medicinecurrenttime='%@' where (medicineid='%d' and userid='%d') and medicinetime='%@'",med_obj.medicineName,med_obj.medicineComments,med_obj.medicineImage,@"taken",qty,dateString,med_obj.medicineSequenceId,aUser.userId,str];
               NSLog(@"%@",query);
               [classDatabaseOperations updateFlags:query];
               [query release];
               
           }
           if(++index<medArray.count)
           {
               
               med_obj=[medArray objectAtIndex:index];
               med_tobj=[medArray objectAtIndex:index];
               NSLog(@"%@",med_obj.medicineName);
               
               
               
               
               
               NSString *query =[[NSString alloc] initWithFormat:@"update medicinestatus set medicinename='%@', medicinecomments='%@', medicineimage='%@',medicinestatus='%@',medicinecurrenttime='%@' where medicineid='%d' ",med_obj.medicineName,med_obj.medicineComments,med_obj.medicineImage,@"taken",dateString,med_obj.medicineSequenceId];
               
               [classDatabaseOperations updateFlags:query];
               [query release];
               
               
               
               remindMed *obj_med=[[remindMed alloc]initWithNibName:@"remindMed" bundle:nil];
               //navC=[[UINavigationController alloc]initWithRootViewController:obj_med];
               // obj_glyco.delegate=self;
               obj_med.arrayFlags=arrayFlags;
               //    obj_med.myAudioPlayer=self.audioPlayer;
               obj_med.med_obj=med_obj;
               obj_med.myAudioPlayer=self.myAudioPlayer;
               obj_med.medArray=medArray;
               obj_med.aUser=aUser;
               obj_med.tabBarItem.title=@"Add";
               [self.navigationController pushViewController:obj_med animated:YES];
           
           }
           //}
           else
           {
               
               medicineStatus *obj_med=[[medicineStatus alloc]initWithNibName:@"medicineStatus" bundle:nil];
               obj_med.obj_user =aUser;
               obj_med.med_obj=med_obj;
               obj_med.tabBarItem.title=@"Add";
               [self.navigationController pushViewController:obj_med animated:YES];
               
               
               
           }
           
           
           
       }
       else if(buttonIndex==1)//cancel
       {
           
       }
       
       
   }
    else if (alertView.tag==117)
    {
        if(buttonIndex==0)
        {
            int   index =[medArray indexOfObject:med_obj];
            NSMutableArray *result=[[NSMutableArray alloc]init];

            result=[classDatabaseOperations chkStatus:med_obj.medicineSequenceId :aUser.userId:str] ;
            NSLog(@"%d",result.count);
            if (result.count==0) {
                NSString * queryString=[NSString stringWithFormat: @"insert into medicinestatus values ('%d','%d','%@','%@','%@','%@','%@','%f','%@')",aUser.userId, med_obj.medicineSequenceId ,med_obj.medicineName,med_obj.medicineComments,med_obj.medicineImage,@"skip",str,qty,dateString];
                NSLog(@"%@",queryString);
                NSLog(@"%@",queryString);
                NSLog(@"added");
                [classDatabaseOperations add:queryString];
                
                
                NSString * imgName = [NSString stringWithFormat:@"%@%@%@",med_obj.medicineName,aUser.firstName,aUser.lastName];
                // covert Medicne image to nsdata
                
                // get path of document directory to save medicne
                NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
                NSString *documentsDir = [documentPaths objectAtIndex:0];
                NSString * documentImagePth = [documentsDir stringByAppendingPathComponent:imgName];
                
                NSFileManager *fileManager = [NSFileManager defaultManager];
                [fileManager removeItemAtPath:documentImagePth error:nil];
                
                // save new image
                [self savePicture];
                
                
                
            }
            else 
            {
                NSString *query =[[NSString alloc] initWithFormat:@"update medicinestatus set medicinename='%@', medicinecomments='%@', medicineimage='%@',medicinestatus='%@', medicineqty='%f',medicinecurrenttime='%@' where medicineid='%d' and userid='%d' and medicinetime='%@'",med_obj.medicineName,med_obj.medicineComments,med_obj.medicineImage,@"skip",qty,dateString,med_obj.medicineSequenceId,aUser.userId,str];
                NSLog(@"%@",query);
                [classDatabaseOperations updateFlags:query];
                
            }
            if(++index<medArray.count)
            {
                
                med_obj=[medArray objectAtIndex:index];
                med_tobj=[medArray objectAtIndex:index];
                NSLog(@"%@",med_obj.medicineName);
                remindMed *obj_med=[[remindMed alloc]initWithNibName:@"remindMed" bundle:nil];
                obj_med.arrayFlags=arrayFlags;
                obj_med.myAudioPlayer=self.myAudioPlayer;
                obj_med.med_obj=med_obj;
                obj_med.medArray=medArray;
                obj_med.aUser=aUser;
                obj_med.tabBarItem.title=@"Add";
                [self.navigationController pushViewController:obj_med animated:YES];                
            }  
            //}
            else 
            {
                
                medicineStatus *obj_med=[[medicineStatus alloc]initWithNibName:@"medicineStatus" bundle:nil];
                obj_med.obj_user =aUser;
                obj_med.med_obj=med_obj;
                obj_med.tabBarItem.title=@"Add";
                [self.navigationController pushViewController:obj_med animated:YES];                
                
                            
                
                
                
                
            }
            
            
            
            
            
        }
        else if(buttonIndex==1)
        {
            
        }
        
        
    }
    else if(alertView.tag==118)
    {
        
        if(buttonIndex==0)
        {
            
            int   index =[medArray indexOfObject:med_obj];
             NSMutableArray *result=[[NSMutableArray alloc]init];
            NSLog(@"str %@",str);

            result=[classDatabaseOperations chkStatus:med_obj.medicineSequenceId :aUser.userId:str] ;

            NSLog(@"%d",result.count);
            if (result.count==0) {
                NSString * queryString=[NSString stringWithFormat: @"insert into medicinestatus values ('%d','%d','%@','%@','%@','%@','%@','%f','%@')",aUser.userId, med_obj.medicineSequenceId ,med_obj.medicineName,med_obj.medicineComments,med_obj.medicineImage,@"remindlater",str,qty,dateString];
                NSLog(@"%@",queryString);
                NSLog(@"added");
                [classDatabaseOperations add:queryString];
                
                NSString * imgName = [NSString stringWithFormat:@"%@%@%@",med_obj.medicineName,aUser.firstName,aUser.lastName];
                // covert Medicne image to nsdata
                
                // get path of document directory to save medicne
                NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
                NSString *documentsDir = [documentPaths objectAtIndex:0];
                NSString * documentImagePth = [documentsDir stringByAppendingPathComponent:imgName];
                
                NSFileManager *fileManager = [NSFileManager defaultManager];
                [fileManager removeItemAtPath:documentImagePth error:nil];
                
                // save new image
                [self savePicture];
                
                
                
                
            }
            else 
            {
                
                NSString *query =[[NSString alloc] initWithFormat:@"update medicinestatus set medicinename='%@', medicinecomments='%@', medicineimage='%@',medicinestatus='%@', medicineqty='%f',medicinecurrenttime='%@' where medicineid='%d' and userid='%d' and medicinetime='%@'",med_obj.medicineName,med_obj.medicineComments,med_obj.medicineImage,@"remindlater",qty,dateString,med_obj.medicineSequenceId,aUser.userId,str];
                NSLog(@"%@",query);
                [classDatabaseOperations updateFlags:query];
                
            }
            if(++index<medArray.count)
            {
                
                med_obj=[medArray objectAtIndex:index];
                med_tobj=[medArray objectAtIndex:index];
                NSLog(@"%@",med_obj.medicineName);
                               
                remindMed *obj_med=[[remindMed alloc]initWithNibName:@"remindMed" bundle:nil];
                //navC=[[UINavigationController alloc]initWithRootViewController:obj_med];
                // obj_glyco.delegate=self;
                obj_med.arrayFlags=arrayFlags;
              obj_med.myAudioPlayer=self.myAudioPlayer;
                obj_med.med_obj=med_obj;
                obj_med.medArray=medArray;
                obj_med.aUser=aUser;
                obj_med.tabBarItem.title=@"Add";
                [self.navigationController pushViewController:obj_med animated:YES];                
                
                
                
                
                
            }  
            //}
            else 
            {
                
                medicineStatus *obj_med=[[medicineStatus alloc]initWithNibName:@"medicineStatus" bundle:nil];
                obj_med.obj_user =aUser;
                obj_med.med_obj=med_obj;
                obj_med.tabBarItem.title=@"Add";
                [self.navigationController pushViewController:obj_med animated:YES];                
                
                                
                
                
                
                
            }
            
            
            
            
        }
        else if(buttonIndex==1)
        {
            
        }    }
    
    
}


-(void)savePicture
{
    
    if(med_obj.medicineImage!=nil)
    {
        
        
        //medicine name
        NSString * imgName = [NSString stringWithFormat:@"%@%@%@",med_obj.medicineName,aUser.firstName,aUser.lastName];
        // covert Medicne image to nsdata
        NSData* imageData = UIImagePNGRepresentation(med_obj.medicineImage);
        
        // get path of document directory to save medicne
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString * databasePath = [documentsDir stringByAppendingPathComponent:imgName];
        
        
        
        
        // and then we write it out
        [imageData writeToFile:databasePath atomically:NO];
        
        
    }
    
    
    
    
}

+(NSMutableArray *)getMedicineIndexForTimeSpan:(int)timeSpan forUser:(classUser*)currentUser
{
    
    NSMutableArray * arrayIndex=[[NSMutableArray alloc] init];
    //  NSMutableArray * allMedicines=[classDatabaseOperations getMedicineListForUser:currentUser];
    NSMutableArray * allMedicines=currentUser.medicineList;
    
    
    for(classMedicine * objMedicine in allMedicines)
    {
        
        
        for(classMedicineTime * objTime in objMedicine.medicineTimes)
        {
            //NSLog(@"medicine times count: %d",[objMedicine.medicineTimes count]);
            
            if(objTime.times !=nil)
            {
                
                
                if([commanFunctions getTimeSpanOfTime:objTime.times]==timeSpan || timeSpan==5)// 2nd condition is used in case user need to see all medicines
                {
                    
                    
                    classMedicineIndex * objIndex=[[[classMedicineIndex alloc] init] autorelease];
                    
                    // in each object of index save current medicine id and its dose number
                    objIndex.medicineId=objMedicine.medicineSequenceId;
                    objIndex.doseNumber=objTime.doseNumber;
                    
                    // add this indexObject in arrayIndex
                    [arrayIndex addObject:objIndex];
                    
                    // NSLog(@"medId:%d doseNo:%d",objIndex.medicineId,objIndex.doseNumber);
                    
                    
                }
                
            }
            
            
        }
        
        
        
    }
    
    
    
    
    return [arrayIndex autorelease];
}


-(IBAction)Logout
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
