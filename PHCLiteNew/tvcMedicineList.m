//
//  tvcMedicineList.m
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 9/17/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "tvcMedicineList.h"
#import "classDatabaseOperations.h"
#import "classUser.h"
#import "classMedicineList.h"
#import "classMedicineTime.h"
#import "classMedicineIndex.h"
#import "classPillBoxNew.h"
#import "classAudio.h"
//---------------------
int indexForArrow=-1;

//---------------------

@implementation tvcMedicineList
@synthesize arrayPillBox;
@synthesize objUser;
@synthesize myAudioPlayer;
@synthesize imgvalue;

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
    
    
       self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;
    [[self tableView] setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]]];

   // self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(logout)] autorelease];
    
    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Add +" style:UIBarButtonItemStylePlain target:self action:@selector(addMedicine)]autorelease] ;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];

    NSLog(@"UserNumber%d",objUser.userId);
    self.tableView.separatorColor=[UIColor blackColor];

    
    self.title=@"Medication";


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
    
    //indexForArrow=[self getArrowIndexAndPlayAudio:YES];
    self.arrayPillBox=[[[NSMutableArray alloc] init] autorelease];
    
    indexForArrow=[self getArrowIndexAndPlayAudio:YES];


    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //    int index;
    //    
    //    for(classMedicine * objMed in self.objUser.medicineList)
    //    {
    //        
    //        if(![self methodCheckMedicneFilledCompletely:objMed])
    //        {
    //            //we will show arrow at this index
    //            indexForArrow =index; 
    //            
    //            break;
    //            
    //            
    //            
    //        }
    //        else
    //        {
    //            
    //            //filledmedicineCount++;
    //            //NSLog(@"Filled medicines %d",filledmedicineCount);
    //            
    //            
    //        }
    //        
    //        index++;
    //        
    //    }
    //    
    //    
    //
    //
    
    
    
    
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
    
    //return NO;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section==1)
    {
        return [self.objUser.medicineList count];
    }
    
       
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(indexPath.section==1)
    {
        return 50;
    }
    
    
    
    if(indexPath.section==2)
    {
        return 200;
    }

    
    
    return 55;
    
    
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if(section==1)
    {
        
        return [NSString stringWithFormat:@"Total: %d",[self.objUser.medicineList count]];
        
    }
    
    return nil;
    
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
    cell.textLabel.font=[UIFont fontWithName:@"Futura" size:15];
    cell.detailTextLabel.font=[UIFont fontWithName:@"Futura" size:13.0];
    cell.accessoryView=nil;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    
    
    if(indexPath.section==0)
    {
        
        cell.textLabel.text=[NSString stringWithFormat:@"%@ %@",self.objUser.firstName, objUser.lastName];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.accessoryView=nil;    
        cell.imageView.image=[UIImage imageNamed:@"member.png"];
        cell.detailTextLabel.text=nil;
        
        
    }
   if(indexPath.section==1)
    {
        
        classMedicine * objMedicine=[self.objUser.medicineList objectAtIndex:indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

        cell.textLabel.text=[NSString stringWithFormat:@"%@",objMedicine.medicineName];
        cell.imageView.image=[UIImage imageNamed:@"medication.png"];
        
        if(objMedicine.medicineDosesFrequency>1)
        {
            cell.detailTextLabel.text=[NSString stringWithFormat:@"Take %@ %d times in a day",objMedicine.medicineName,objMedicine.medicineDosesFrequency];
        }
        else
        {
            
            cell.detailTextLabel.text=[NSString stringWithFormat:@"Take %@ %d time in a day",objMedicine.medicineName,objMedicine.medicineDosesFrequency];
            
        }
        
        
        
        //chek that current medicne is completely filled in pillbox
        if([self methodCheckMedicneFilledCompletely:objMedicine]==YES)
        {
            cell.accessoryView=nil;
            cell.accessoryType=UITableViewCellAccessoryCheckmark;            
            
        }
        
        else if([self methodCheckMedicneFilledCompletely:objMedicine]==NO)
        {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

            if( indexForArrow==indexPath.row && indexForArrow<=[self.objUser.medicineList count] )
            {
                
                UIImageView * imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrowRight.png"]];
                cell.accessoryView=imgView;
                [imgView release];
                
                indexForArrow=indexPath.row;            
            }
            
            
            NSLog(@"arrow index %d", indexForArrow);          
            
        }
        
    }
  
    
    
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  if(indexPath.section==1)
   {
      classPillBoxNew * objPillBox=[[classPillBoxNew alloc] initWithNibName:@"classPillBoxNew" bundle:nil];
       objPillBox.arrayPillbox=self.arrayPillBox;
       [self methodGetFlagValue];
        objPillBox.arrayMedicineIndex=[self splitMedicineAccordingToMedicineTime:[objUser.medicineList objectAtIndex:indexPath.row]];
        objPillBox.selectedMedicine=[objUser.medicineList objectAtIndex:indexPath.row];
       objPillBox.delegate=self;
        objPillBox.myAudioPlayer=self.myAudioPlayer;
       objPillBox.objUser=self.objUser;
    //    objPillBox.imgvalue=self.imgvalue;
       
        UINavigationController * navC=[[UINavigationController alloc] initWithRootViewController:objPillBox];
        
       [self presentModalViewController:navC animated:YES];
       [navC release];
       //[self.navigationController pushViewController:objPillBox animated:YES];
       
   }
    
  
    
    
}
-(void)methodGetFlagValue
{
    NSString *queryString=[NSString stringWithFormat:@"select flag from ImageFlag where userid=%d",objUser.userId];
    imgvalue=[classDatabaseOperations get:queryString];
    //imgvalue=[imgvalue1 intvalue]
    NSLog(@"image%d",imgvalue);
}


//*****************************************************************************************************


-(void)logout
{
//    
//    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Are you sure? Logout?" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
//    alert.tag=189;
//    [alert show];
//    [alert release];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag==189 )
    {
        
        if(buttonIndex==1)
        {
            
            
            //[self.navigationController popViewControllerAnimated:YES];
            [self dismissModalViewControllerAnimated:YES];
            
        }
        
        
    }
    else
        if(alertView.tag==190 )
        {
            
            if(buttonIndex==1)
            {
                
                
                UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Are you sure? Logout?" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
                alert.tag=189;
                [alert show];
                [alert release];
                
            }
            
            
        }
        else if(alertView.tag==123)
        {
            
            if(buttonIndex==1)
            {
            classMedicineList * objMedicineList=[[classMedicineList alloc] initWithStyle:UITableViewStylePlain];
            objMedicineList.objUser=self.objUser;
            objMedicineList.delegate=self;
            objMedicineList.myAudioPlayer=self.myAudioPlayer;
            UINavigationController * navC=[[UINavigationController alloc] initWithRootViewController:objMedicineList];    
            [self presentModalViewController:navC animated:YES];
                [navC release];
            }
        }

    
        
    
    
}

-(void)addMedicine
{
    
    classMedicineList * objMedicineList=[[classMedicineList alloc] initWithStyle:UITableViewStylePlain];
    objMedicineList.objUser=self.objUser;
    objMedicineList.delegate=self;
    objMedicineList.myAudioPlayer=self.myAudioPlayer;
    UINavigationController * navC=[[UINavigationController alloc] initWithRootViewController:objMedicineList];    
    [self presentModalViewController:navC animated:YES];
    [navC release];
}


-(BOOL)methodCheckMedicneFilledCompletely:(classMedicine *)objMedicine
{
    
    int count=0;
    
    for(classMedicineIndex * objIndex in self.arrayPillBox)
    {
        
        
        if(objMedicine.medicineSequenceId==objIndex.medicineId)
        {
            
            
            count++;
        
            NSLog(@"medicne count %d",count);
            
        }
        
        
        
        if(count==objMedicine.medicineDosesFrequency)
        {
            
            
            return YES;
        }
        
        
    }
    
    
    return NO;
    
    
}


-(int)getArrowIndexAndPlayAudio:(BOOL)playAudio
{
    
    int index=0;
    
    for(classMedicine * objMedicine in self.objUser.medicineList)
    {
        
        
    if([self methodCheckMedicneFilledCompletely:objMedicine])
    {
        
        
        index++;
        
    }
        else
        {
            
            if(objUser.audioStatus==YES && playAudio==YES)
            {
                
                if(objUser.language==1)
                {
            
                
                NSMutableArray * array=[[NSMutableArray alloc] init];
                [array addObject:@"selecteMedicine"];
                [self.myAudioPlayer playAudios:array];
                [array release];
                }
                else if(objUser.language==2)
                {
                    
                    
                    NSMutableArray * array=[[NSMutableArray alloc] init];
                    [array addObject:@"2medIndicteByArrow"];
                    [self.myAudioPlayer playAudios:array];
                    [array release];
                
                
                }
                    
                    
            }
                return index;
                
                }
                       


           // return index;// this is the index where  we need to show arrow
            
            
                        
        }
        
        
    
    
    
    if(index>=[self.objUser.medicineList count] && [self.objUser.medicineList count]!=0)
    {
        
        if(objUser.audioStatus==YES)
        {
            if(objUser.language==1)
            {
                NSMutableArray * array=[[NSMutableArray alloc] init];
                [array addObject:@"fillingComplete"];
                [self.myAudioPlayer playAudios:array];
                [array release];
            }
           else if(objUser.language==2)

           {
               
               NSMutableArray * array=[[NSMutableArray alloc] init];
               [array addObject:@"2fillingComplete"];
               [self.myAudioPlayer playAudios:array];
               [array release];
               
           }
        
        
        
        }
        
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Medicine filling complete" message:@"All medicines filled in the pillbox." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Logout", nil];
        alert.tag=190;
        [alert show];
        [alert release];

    }
    else if([self.objUser.medicineList count]==0&& playAudio==YES)
    {
        
        
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"No medicines" message:@"There are no medicines to fill in pillbox, please add medicines." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add Medicines", nil];
        alert.tag=123;
        [alert show];
        [alert release];
        if(objUser.audioStatus==YES)
        {
            
        if(objUser.language==1)
        {
            
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"noMedicines1"];
            [self.myAudioPlayer playAudios:array];
            [array release];
            
            
            
        }
            
            
        else if(objUser.language==2)
        {
            
            
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"2NoMedicine"];
            [self.myAudioPlayer playAudios:array];
            [array release];
            
            
        }
        }
        
    }
    
    return index;
    
}



-(NSMutableArray *)splitMedicineAccordingToMedicineTime:(classMedicine *)objMedicine
{
    NSMutableArray * arrayIndex=[[NSMutableArray alloc] init];
    
    
    for(classMedicineTime * objTime in objMedicine.medicineTimes)
    {
        //NSLog(@"medicine times count: %d",[objMedicine.medicineTimes count]);
        
        if(objTime.times !=nil)
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
    
    
    return [arrayIndex autorelease];
    
    
}



-(void)methodPillBoxFillingCancel
{
    
    [self dismissModalViewControllerAnimated:YES];
    indexForArrow=[self getArrowIndexAndPlayAudio:YES];
    [self.tableView reloadData];

}



-(void)methodPillBoxFillingComplete
{
    
    [self dismissModalViewControllerAnimated:YES];
    indexForArrow=[self getArrowIndexAndPlayAudio:YES];
    [self.tableView reloadData];
    
}

-(void)cancelAddDelete
{
    
    
    [self dismissModalViewControllerAnimated:YES];
 
    
}


-(void)doneAddDelete
{
        
        
    indexForArrow=[self getArrowIndexAndPlayAudio:NO];        
    [self.tableView reloadData];

    
}



-(void)methodSyncComplete
{
    
    indexForArrow=[self getArrowIndexAndPlayAudio:NO];
    [self.tableView reloadData];
    
    
    
}
@end
