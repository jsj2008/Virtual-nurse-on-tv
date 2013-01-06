//
//  classMedicineList.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/7/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classMedicineList.h"
#import "commanFunctions.h"
#import "classUser.h"
#import "classDatabaseOperations.h"
//#import "ClassAddMedicationNew.h"
#import "classAudio.h"

int totalRows;
int currentSelectedRow;

@implementation classMedicineList
@synthesize objUser;
@synthesize delegate=_delegate;

@synthesize myAudioPlayer;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        // Custom initialization
        
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

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
    
    // set title
    self.title=@"Add medicines";
    // set total rows 
    totalRows=[objUser.medicineList count];
    
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)] autorelease];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewMedicine)];
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    [self.tableView  setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    self.tableView.separatorColor=[UIColor blackColor];
    self.navigationController.navigationBar.hidden=NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(objUser.audioStatus==YES)
    {

    [self playAudio];
    }
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
    return totalRows;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    

    cell.textLabel.font=[UIFont fontWithName:@"Futura" size:15.0f];
    cell.detailTextLabel.font=[UIFont fontWithName:@"Futura" size:13.0f];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.detailTextLabel.textColor=[UIColor darkGrayColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView=nil;
    
    classMedicine * objMedicine=[self.objUser.medicineList objectAtIndex:indexPath.row];
    cell.textLabel.text=objMedicine.medicineName;
    
    if(objMedicine.medicineImage!=nil)
    {
        
        CGSize newSize;
        newSize.width=47.0f;
        newSize.height=56.0f;
        // Create a graphics image context
        UIGraphicsBeginImageContext(newSize);
        
        // Tell the old image to draw in this new context, with the desired
        // new size
        [objMedicine.medicineImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        
        // Get the new image from the context
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // End the context
        UIGraphicsEndImageContext();
        
        // Return the new image.
        
             
        cell.imageView.image=newImage;
        
    

        
    }
    else
    {
        
        cell.imageView.image=[UIImage imageNamed:@"Placeholder.png"];
        
    }
       cell.detailTextLabel.text=[NSString stringWithFormat:@"Total quantity left in hand: %.1f",objMedicine.totalPillQuantity];
    
    
    return cell;
}





-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    
//    if(indexPath.row>=1)
//    {
//        
//        if(indexPath.row%2!=0)
//        {
//            
//            cell.backgroundColor=[UIColor lightGrayColor];
//            
//            
//            
//        }
//        else
//        {
//            
//            cell.backgroundColor=[UIColor whiteColor];
//            
//            
//            
//        }
//        
//        
//        
//    }
//    else if(indexPath.row==0)
//    {
//        
//        cell.backgroundColor=[UIColor whiteColor];
//        
//        
//    }
//    
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
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    // create objec of addmedicne class 
//    ClassAddMedicationNew * objAddMedicine=[[ClassAddMedicationNew alloc] initWithStyle:UITableViewStyleGrouped];
//    
//    // set current user
//    objAddMedicine.objUser=self.objUser;
//    
//    
//    
    
    // set current selected row
    currentSelectedRow=indexPath.row; 
    
    
    
    
    UIActionSheet * actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:@"Edit", nil];
    [actionSheet setBackgroundColor:[UIColor clearColor]];
    
    
    [actionSheet showInView:self.view.window];
    [actionSheet release];
    
    
    
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(buttonIndex==0)// delete
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Do You Want To Delete Medicine ?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"Delete", nil];
        [alert show];
        alert.tag=100;
        [alert release];
        
        // get the medicine whiche you want to updte
//        classMedicine * objMed=[self.objUser.medicineList objectAtIndex:currentSelectedRow];
//        // query to delete medicne
//        NSString * queryString=[NSString stringWithFormat:@"delete from medicine where medicineid=%d and userid=%d",objMed.medicineSequenceId,objUser.userId];
//        if([classDatabaseOperations add:queryString]==0)
//        {
//            
//            
//            // onece the medicin is deleted delete all its time and quantity
//            NSString * queryString=[NSString stringWithFormat:@"delete from medicinetimedetails where medicineid=%d and userid=%d",objMed.medicineSequenceId,objUser.userId];
//            [classDatabaseOperations add:queryString];
//            
//            // also delete image form document directory
//            
//            // Delete the file using NSFileManager
//            
//            //medicine name
//            NSString * imgName = [NSString stringWithFormat:@"%@%@%@",objMed.medicineName,objUser.firstName,objUser.lastName];
//            // covert Medicne image to nsdata
//                      
//            // get path of document directory to delete medicne
//            NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
//            NSString *documentsDir = [documentPaths objectAtIndex:0];
//            NSString * documentImagePth = [documentsDir stringByAppendingPathComponent:imgName];
//            
//            NSFileManager *fileManager = [NSFileManager defaultManager];
//            [fileManager removeItemAtPath:documentImagePth error:nil];
//            
//            
//            [self resetMedicineList];
//            [self.delegate doneAddDelete];
//            
//            
//            
//            if([self.objUser.medicineList count]==0)
//            {
//                if(objUser.language==1)
//                {
//                    
//                
//                NSMutableArray * array=[[NSMutableArray alloc] init];
//                [array addObject:@"PleaseAddNewMedicne"];
//                [myAudioPlayer playAudios:array];
//                [array release];          
//                }
//                
//                
//                else if(objUser.language==2)
//                {
//                    NSMutableArray * array=[[NSMutableArray alloc] init];
//                    [array addObject:@"2TapAddTOMEd"];
//                    [myAudioPlayer playAudios:array];
//                    [array release];   
//                    
//                    
//                }
//            }
//            else
//                
//            if(objUser.audioStatus==YES)
//            {
//                if(objUser.language==1)
//                {
//            NSMutableArray * array=[[NSMutableArray alloc] init];
//            [array addObject:@"medicineDeleted"];
//            [myAudioPlayer playAudios:array];
//            [array release];  
//                }
//                else if(objUser.language==2)
//                {
//                    
//                    NSMutableArray * array=[[NSMutableArray alloc] init];
//                    [array addObject:@"2medicineDeleted"];
//                    [myAudioPlayer playAudios:array];
//                    [array release];  
//                    
//                    
//                    
//                    
//                    
//                    
//                }
//                    
//                
//        
//            }
//            
            
//        }
//        else
//        {
//            
//            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Unable to delete %@",objMed.medicineName] message:@"error occured while deleteing medicine" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            alert.tag=130;
//            [alert show]; 
//            [alert release];
//            
//            
//        }
        
        
    }
    else if(buttonIndex==1)// update
    { 
        
        
        
        // create objec of addmedicne class 
        ClassAddMedicationNew * objAddMedicine=[[ClassAddMedicationNew alloc] initWithStyle:UITableViewStyleGrouped];
        objAddMedicine.delegate=self;
        // set current user
        objAddMedicine.objUser=self.objUser;
        
        objAddMedicine.title=@"Update Medicine";
        objAddMedicine.isUpdateMode=YES;
        objAddMedicine.myAudioPlayer=self.myAudioPlayer;
        
        // set selected medicne  object
        objAddMedicine.objMedicine=[commanFunctions createCopyOfMedicine:[self.objUser.medicineList objectAtIndex:currentSelectedRow]];
        
        
        // finally preset addMedicneClass modaly
        UINavigationController * navC=[[UINavigationController alloc] initWithRootViewController:objAddMedicine];    
        [self presentModalViewController:navC animated:YES];
        [objAddMedicine release];
        [navC release];
        
    }
    else if(buttonIndex==2)// cancel
    { 
        
        NSLog(@"2222");
        
    }
    
    
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==100)
    {
        if(buttonIndex==0)
        {
                    }
        if(buttonIndex==1)
          {
              classMedicine * objMed=[self.objUser.medicineList objectAtIndex:currentSelectedRow];
              // query to delete medicne
              NSString * queryString=[NSString stringWithFormat:@"delete from medicine where medicineid=%d and userid=%d",objMed.medicineSequenceId,objUser.userId];
              if([classDatabaseOperations add:queryString]==0)
              {
                  
                  //            // onece the medicin is deleted delete all its time and quantity
                  NSString * queryString=[NSString stringWithFormat:@"delete from medicinetimedetails where medicineid=%d and userid=%d",objMed.medicineSequenceId,objUser.userId];
                  [classDatabaseOperations add:queryString];
                  
                  //            // also delete image form document directory
                  //            
                  //            // Delete the file using NSFileManager
                  //            
                  //            //medicine name
                  NSString * imgName = [NSString stringWithFormat:@"%@%@%@",objMed.medicineName,objUser.firstName,objUser.lastName];
                  //            // covert Medicne image to nsdata
                  //                      
                  //            // get path of document directory to delete medicne
                  NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
                  NSString *documentsDir = [documentPaths objectAtIndex:0];
                  NSString * documentImagePth = [documentsDir stringByAppendingPathComponent:imgName];
                  
                  NSFileManager *fileManager = [NSFileManager defaultManager];
                  [fileManager removeItemAtPath:documentImagePth error:nil];
                  
                  
                  [self resetMedicineList];
                  [self.delegate doneAddDelete];
                  //            
                  
                  //            
                  if([self.objUser.medicineList count]==0)
                  {
//                      if(objUser.language==1)
//                      {
//                          
//                          
                          NSMutableArray * array=[[NSMutableArray alloc] init];
                          [array addObject:@"PleaseAddNewMedicne"];
                          [myAudioPlayer playAudios:array];
                          [array release];          
//                      }
//                      
//                      else if(objUser.language==2)
//                      {
//                          NSMutableArray * array=[[NSMutableArray alloc] init];
//                          [array addObject:@"2TapAddTOMEd"];
//                          [myAudioPlayer playAudios:array];
//                          [array release];   
//                          
//                          
//                      }
                  }
                  else
                      
                      if(objUser.audioStatus==YES)
                      {
//                          if(objUser.language==1)
//                          {
                              NSMutableArray * array=[[NSMutableArray alloc] init];
                              [array addObject:@"medicineDeleted"];
                              [myAudioPlayer playAudios:array];
                              [array release];  
//                          }
//                          else if(objUser.language==2)
//                          {
//                              
//                              NSMutableArray * array=[[NSMutableArray alloc] init];
//                              [array addObject:@"2medicineDeleted"];
//                              [myAudioPlayer playAudios:array];
//                              [array release];  
//                                                  
                  
//                          }
//                          
                          
                          
                      }
                  
                  
              }
              else
              {
                  
                  UIAlertView * alert=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Unable to delete %@",objMed.medicineName] message:@"error occured while deleteing medicine" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                  alert.tag=130;
                  [alert show]; 
                  [alert release];
                  //            
                  //            
              }

          }
        if(buttonIndex==2)
        {
            [self methoddeleteMedicine];         
        }
    }
    
}


-(void)resetMedicineList
{
    
    self.objUser.medicineList=[classDatabaseOperations getMedicineListForUser:self.objUser];
    totalRows=[objUser.medicineList count];
    
    
    NSIndexSet * indexSet=[NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    
    
    
}


-(void)addMedicineDidCancel
{
    
    //[self dismissModalViewControllerAnimated:YES];
    
    [self.delegate cancelAddDelete];
    
}


-(void)addMedicineDidComplete
{
    
    
    [self resetMedicineList]; 
    [self.delegate doneAddDelete];
    [self dismissModalViewControllerAnimated:YES];
    
    
}



-(void)playAudio
{
    NSMutableArray * array=[[NSMutableArray alloc] init];
    
    if([self.objUser.medicineList count]==0)
    {
//        if(objUser.language==1)
//        {
        [array addObject:@"PleaseAddNewMedicne"];

//        }
//        
//        
//        else if(objUser.language==2)
//        {
//            
//            [array addObject:@"2TapAddTOMEd"];
//
//            
//        }
            
        
        
    }
    else
    {
//        if(objUser.language==1)
//        {
        [array addObject:@"editDeletemedicine"];
            
//        }
//        else if(objUser.language==2)
//        {   
//            [array addObject:@"2editDeletemedicine"];
//
//        }
    }
    
    [myAudioPlayer playAudios:array];
    [array release];
    
    

    
}



-(void)addNewMedicine
{
    
    ClassAddMedicationNew * objAddMedicine=[[ClassAddMedicationNew alloc] initWithStyle:UITableViewStyleGrouped];
    
    // set current user
    objAddMedicine.objUser=self.objUser;  
    
    objAddMedicine.title=@"Add Medicine";
    objAddMedicine.isUpdateMode=NO;
    objAddMedicine.delegate=self;
    objAddMedicine.myAudioPlayer=self.myAudioPlayer;
    // set an empty medicine object
    objAddMedicine.objMedicine=[[[classMedicine alloc] init] autorelease];
   // objAddMedicine.objMedicine.medicineTimes=[[[NSMutableArray alloc] init] autorelease];
    
   // for(int i=0; i<=5;i++)
   // {
   //     [objAddMedicine.objMedicine.medicineTimes addObject:[[[classMedicineTime alloc]init]autorelease]];
        
   // } 
    
    
    // finally preset addMedicneClass modaly
    UINavigationController * navC=[[UINavigationController alloc] initWithRootViewController:objAddMedicine];    
    [self presentModalViewController:navC animated:YES];
    [objAddMedicine release];
    [navC release];
    
    
    
    
    
    
}


-(void)cancel
{
    [self.myAudioPlayer stopAudio];
    [self dismissModalViewControllerAnimated:YES];
    
    
}

-(void)methoddeleteMedicine
{
    classMedicine * objMed=[self.objUser.medicineList objectAtIndex:currentSelectedRow];
    // query to delete medicne
    NSString * queryString=[NSString stringWithFormat:@"delete from medicine where medicineid=%d and userid=%d",objMed.medicineSequenceId,objUser.userId];
    if([classDatabaseOperations add:queryString]==0)
    {
        
        //            // onece the medicin is deleted delete all its time and quantity
        NSString * queryString=[NSString stringWithFormat:@"delete from medicinetimedetails where medicineid=%d and userid=%d",objMed.medicineSequenceId,objUser.userId];
        [classDatabaseOperations add:queryString];
        
        
        NSString * queryTakeMed=[NSString stringWithFormat:@"delete from takemedicine where medicineid=%d and userid=%d",objMed.medicineSequenceId,objUser.userId];
        [classDatabaseOperations add:queryTakeMed];
        
        //            // also delete image form document directory
        //            
        //            // Delete the file using NSFileManager
        //            
        //            //medicine name
        NSString * imgName = [NSString stringWithFormat:@"%@%@%@",objMed.medicineName,objUser.firstName,objUser.lastName];
        //            // covert Medicne image to nsdata
        //                      
        //            // get path of document directory to delete medicne
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString * documentImagePth = [documentsDir stringByAppendingPathComponent:imgName];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:documentImagePth error:nil];
        
        
        [self resetMedicineList];
        [self.delegate doneAddDelete];
        //            
        
        //            
        if([self.objUser.medicineList count]==0)
        {
//            if(objUser.language==1)
//            {
//                
                
                NSMutableArray * array=[[NSMutableArray alloc] init];
                [array addObject:@"PleaseAddNewMedicne"];
                [myAudioPlayer playAudios:array];
                [array release];          
//            }
//            
//            else if(objUser.language==2)
//            {
//                NSMutableArray * array=[[NSMutableArray alloc] init];
//                [array addObject:@"2TapAddTOMEd"];
//                [myAudioPlayer playAudios:array];
//                [array release];   
//                
//                
//            }
        }
        else
            
            if(objUser.audioStatus==YES)
            {
//                if(objUser.language==1)
//                {
                    NSMutableArray * array=[[NSMutableArray alloc] init];
                    [array addObject:@"medicineDeleted"];
                    [myAudioPlayer playAudios:array];
                    [array release];  
//                }
//                else if(objUser.language==2)
//                {
//                    
//                    NSMutableArray * array=[[NSMutableArray alloc] init];
//                    [array addObject:@"2medicineDeleted"];
//                    [myAudioPlayer playAudios:array];
//                    [array release];  
                                   
              //  }
                
                
                
            }
        
        
    }
    else
    {
        
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Unable to delete %@",objMed.medicineName] message:@"error occured while deleteing medicine" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        alert.tag=130;
        [alert show]; 
        [alert release];
        //            
        //            
    }

    
}


@end
