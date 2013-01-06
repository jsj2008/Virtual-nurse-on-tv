//
//  ClassAddMedicationNew.m
//  i_strip
//
//  Created by Avi Kulkarni on 4/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClassAddMedicationNew.h"
#import "classMedicine.h"
#import "classMedicineName1.h"
#import "classDosageFrequency.h"
#import "classSelectedTime.h"
#import "classMedicineTime.h"
#import "classTotalQuantity.h"
#import "classDatabaseOperations.h"
#import "classPicture.h"
#import "commanFunctions.h"
#import "pickerMed.h"
// private variables
BOOL totalQuantityEntered;

@implementation ClassAddMedicationNew
@synthesize objMedicine,textViewComments,btnSave,btnUpdate;
@synthesize objUser;
@synthesize isUpdateMode;
@synthesize delegate=_delegate;
@synthesize countMed;


@synthesize myAudioPlayer;

- (id)initWithStyle:(UITableViewStyle)style 
{
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style]))
	{
        self.title = @"Add Medicines";
        UIImage* anImage = [UIImage imageNamed:@"94-pill.png"];
        UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:@"Add Medicine" image:anImage tag:0];
        self.tabBarItem = theItem; [theItem release];
        
        // self.modalTransitionStyle=uim;
       // self.modalPresentationStyle=UIModalTransitionStyleCrossDissolve;
        

    }
    return self;
}



- (void)viewDidLoad 
{
    [super viewDidLoad];
	
  	
	totalQuantityEntered=NO;
	
	    
    // creat and show cancel button
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)] autorelease];	
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    [[self tableView] setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]]];
    self.tableView.separatorColor=[UIColor blackColor];
     if(isUpdateMode==NO)
        {
            // create and show save button 
            self.btnSave=[[[UIBarButtonItem alloc]initWithTitle: @"Save" style:UIBarButtonItemStyleDone  target:self action:@selector(saveMedicine)] autorelease];
            self.navigationItem.rightBarButtonItem =self.btnSave;
        }
        else
        {
        
        self.btnUpdate=[[[UIBarButtonItem alloc]initWithTitle: @"Update" style:UIBarButtonItemStyleDone  target:self action:@selector(updateMedicine)] autorelease];
        self.navigationItem.rightBarButtonItem =self.btnUpdate;
   
        
        
            }
	
    
   /* else
    {
        //UIAlertView * alertError=[[UIAlertView alloc]initWithTitle:@"Upgrade To iStrips Pro Premium" message:@"To add More Medicine Please Upgrade to iStrips Pro Premium" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Ok", nil];
        
        UIAlertView * alertError=[[UIAlertView alloc]initWithTitle:@"Upgrade To iStrips Pro Premium" message:@"To add More Medicine Please Upgrade to iStrips Pro Premium" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alertError show];
		[alertError release];        
        
    }*/

	//create textview for commetn
	UITextView * tempTextView=[[UITextView alloc] initWithFrame:CGRectMake(15, 7,280 , 60)];	
	tempTextView.textColor = [UIColor blackColor];
	tempTextView.font = [UIFont fontWithName:@"Arial" size:14];
	tempTextView.delegate=self;	
	self.textViewComments=tempTextView;
	[tempTextView release];
	
	[self playAudio];
	
}






/*- (void)viewWillAppear:(BOOL)animated
 {
 
 
 
 [super viewWillAppear:animated];
 
 [self.tableView reloadData];
 
 }*/


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text 
{ 
	if([text isEqualToString:@"\n"])
	{
		[self.textViewComments resignFirstResponder]; 
		
	}
	
	return YES;
}


- (void)viewDidAppear:(BOOL)animated 
{
    [super viewDidAppear:animated];
	
	[self.tableView reloadData];
	
}

/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if(section==1)
	{
		return @"Medicine Comments";
        
	}
	
	return nil;
}




// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if(section==0)
    {
		
        return 6;
		
    }
    else if(section==1)
    {
        return 1;
        
    }
    
    
	return 0;
}


//setting for cell width added by sunil-this is a delegate method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.section==1)
	{ 	
		if(indexPath.row==0)
		{
			return 85;				
		}
	}
	else if(indexPath.section==0)
    {
        
        if(indexPath.row==4)
        {
            
            return 62;
            
        }
        
        
    }
	
	return 40;
	
}


-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    
    
    if(section==1)
    {
        
        
        return @"(Optional)\ne.g. Take medicine after lunch";
    }
    
    return nil;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	
    
    
	if(indexPath.section==0)
	{
        
        
        cell.textLabel.font=[UIFont fontWithName:@"Futura" size:14.0f];
        cell.detailTextLabel.font=[UIFont fontWithName:@"Futura" size:14.0f];
        cell.textLabel.textColor=[UIColor grayColor];
        cell.detailTextLabel.textColor=[UIColor darkTextColor];
        

		cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
		
		switch (indexPath.row)
		{
			case 0: cell.textLabel.text=@"Medicine Name:";						
				
				if(self.objMedicine!=nil&&[self checkMedicineNameAndShowAlert:NO])
				{
                    
					cell.detailTextLabel.text=self.objMedicine.medicineName;
					cell.accessoryType=UITableViewCellAccessoryCheckmark;
				}
				else
				{
					cell.detailTextLabel.text=nil;
				}
				
				
				break;
				
            case 1:	cell.textLabel.text=@"Quantity in hand:";
				
				if([self checkTotalPillQuantityAndShowAlert:NO]==YES)
				{
					cell.detailTextLabel.text=[NSString stringWithFormat:@"%.1f",self.objMedicine.totalPillQuantity];					
					cell.accessoryType=UITableViewCellAccessoryCheckmark;
				}
				else
				{
					cell.detailTextLabel.text=nil;
				}		
				
				break;		
				
                
			case 2:	cell.textLabel.text=@"Dosage frequency:";
				
				if(self.objMedicine!=nil&&[self checkDosageFrequencyAndShowAlert:NO] )
				{
					cell.detailTextLabel.text=[NSString stringWithFormat:@"%d",self.objMedicine.medicineDosesFrequency];					
					cell.accessoryType=UITableViewCellAccessoryCheckmark;
				}
				else
				{
					cell.detailTextLabel.text=nil;
                    
                    
				}		
				
				break;		
				
				
			case 3: cell.textLabel.text= @"Dose time & pill quantity:";
				
				if(self.objMedicine!=nil&&[self checkMedicineTimeAndShowAlert:NO])
				{				
					
					cell.detailTextLabel.text=@"selected";
					cell.accessoryType=UITableViewCellAccessoryCheckmark;	
				}
				else
				{
					cell.detailTextLabel.text=nil;
				}
				
				break;
                
            case 4: cell.textLabel.text= @"Take Medicine Picture";
				
				if(self.objMedicine!=nil&&objMedicine.medicineImage!=nil)
				{				
					
					//cell.detailTextLabel.text=@"Taken";
					cell.accessoryType=UITableViewCellAccessoryCheckmark;
                    UIImageView * medicineImage=[[UIImageView alloc] initWithImage:objMedicine.medicineImage];
                    [medicineImage setFrame:CGRectMake(0, 0, 50, 50)];
                    cell.accessoryView=medicineImage;
                    [medicineImage release];
                    
				}
				else
				{
					cell.detailTextLabel.text=nil;
                    UIImageView * imgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Placeholder.png"]];
                    cell.accessoryView=imgView;
                    [imgView release];
				}
				
				break;
                
            case 5: cell.textLabel.text=@"Medicine Appearance"; 
				

				
		}//end of switch
		
	}//end of section 0
	
	else if(indexPath.section==1)// also set comments
	{
        if(![objMedicine.medicineComments isEqualToString:@"(null)"])
        {
             self.textViewComments.text=self.objMedicine.medicineComments;
        }
		
		[cell addSubview:textViewComments];
		
	}
	
	
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // search the medicne
    if(indexPath.section==0 && indexPath.row==0)
    {
        
        
        classMedicineName1 * objMedicineName=[[classMedicineName1 alloc] initWithNibName:@"classMedicineName1" bundle:nil];			
        objMedicineName.objMedicine=self.objMedicine;
        objMedicineName.myAudioPlayer=self.myAudioPlayer;
        objMedicineName.objUser=self.objUser;
        [self presentModalViewController:objMedicineName animated:YES];
        
    }
    
    else if(indexPath.section==0 && indexPath.row==1)		
    {			
        if([self checkMedicineNameAndShowAlert:YES])
        {
            classTotalQuantity* objTotalQuantity=[[classTotalQuantity alloc]initWithNibName:@"classTotalQuantity" bundle:nil];
            objTotalQuantity.objMedicine=self.objMedicine;
            objTotalQuantity.delegate=self;
            objTotalQuantity.myAudioPlayer=self.myAudioPlayer;
            objTotalQuantity.objUser=self.objUser;

            
            UINavigationController * navc=[[UINavigationController alloc] initWithRootViewController:objTotalQuantity];
            [self presentModalViewController:navc animated:YES];
            
            [objTotalQuantity release];
            [navc release];
        }	
        
		
	}
    // set medicine frequency
    else if(indexPath.section==0 && indexPath.row==2)		
    {			
        if([self checkMedicineNameAndShowAlert:YES])
        {
            classDosageFrequency* objDosageFrequency=[[classDosageFrequency alloc]initWithStyle:UITableViewStyleGrouped];
            objDosageFrequency.objMedicine=self.objMedicine;
            objDosageFrequency.myAudioPlayer=self.myAudioPlayer;
            objDosageFrequency.objUser=self.objUser;
            UINavigationController * navc=[[UINavigationController alloc] initWithRootViewController:objDosageFrequency];
            [self presentModalViewController:navc animated:YES];
            
            [objDosageFrequency release];
            [navc release];
        }	
        
		
	}
    //select time for medicine	
    else if(indexPath.section==0 && indexPath.row==3)
    {
        if([self checkMedicineNameAndShowAlert:YES] && [self checkDosageFrequencyAndShowAlert:YES])
        {
            classSelectedTime * objSelectedTime=[[classSelectedTime alloc]initWithStyle:UITableViewStyleGrouped];
            
            objSelectedTime.objMedicine= self.objMedicine;
            objSelectedTime.objMedicineLocal=[commanFunctions createCopyOfMedicine:self.objMedicine];
            objSelectedTime.objUser=self.objUser;
            objSelectedTime.myAudioPlayer=self.myAudioPlayer;            
            UINavigationController * navc=[[UINavigationController alloc] initWithRootViewController:objSelectedTime];
            [self presentModalViewController:navc animated:YES];
            [navc release];
            [objSelectedTime release];
        }
        
    }

    else if(indexPath.section==0 & indexPath.row==4)
    {
        
        
        if([self checkMedicineNameAndShowAlert:YES] &&  [self checkDosageFrequencyAndShowAlert:YES]&&[self checkMedicineTimeAndShowAlert:YES] )
        {
            
            //[self TakePicture];
            
            classPicture * takePicture=[[classPicture alloc] init];
            takePicture.objMedicine=self.objMedicine;
            takePicture.myAudioPlayer=self.myAudioPlayer;
            takePicture.objUser=self.objUser;
            [self.navigationController pushViewController:takePicture animated:YES];
            [takePicture release];
        
        }
        
        
        
    }
     else if(indexPath.section==0 & indexPath.row==5) 
     {
         pickerMed *pickM=[[pickerMed alloc]initWithNibName:@"pickerMed" bundle:nil];
         pickM.objMedicine=self.objMedicine;
         UINavigationController * navc=[[[UINavigationController alloc] initWithRootViewController:pickM]autorelease];
         [self presentModalViewController:navc animated:YES];     
         [navc release];
         [pickM release];
     }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
	
}




/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

//************************************************************************************

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    
	
}

#pragma mark hide keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	[textField resignFirstResponder];
	
	return YES;
}









- (void)dealloc 
{
	
	self.objMedicine=nil;	
	
	self.textViewComments=nil;
	self.btnSave=nil;
	
	
    [super dealloc];
}


-(void)saveMedicine
{
    
	[self.textViewComments resignFirstResponder];
	
	
	
	if([self checkMedicineNameAndShowAlert:YES]==YES)
	{
        
        if([self checkTotalPillQuantityAndShowAlert:YES]==YES)
        {
            if([self checkDosageFrequencyAndShowAlert:YES]==YES)
            {
                
                
                if([self checkMedicineTimeAndShowAlert:YES]==YES)
                {
                    
                    
                    if([self checkPillQuantityAndShowAlert:YES]==YES)
                    {
                        // set comments
                        objMedicine.medicineComments=textViewComments.text;                       
                        
                        // (1) our query string to add medicine                      
                        NSString * queryString=[NSString stringWithFormat:@"insert into medicine (medicinename,medicinetotalpillquantity, medicinefrequency,reorderlevel,medicinecomments,userid) values ('%@',%.1f,%d,%d,'%@',%d)",objMedicine.medicineName,objMedicine.totalPillQuantity,objMedicine.medicineDosesFrequency,objMedicine.reorderLevel,objMedicine.medicineComments,objUser.userId];
                        NSLog(@"%@",queryString);
                        
                        // get result back of adding medicine
                         [self savePicture];
                        int result=[classDatabaseOperations add:queryString];
                        
                        if(result==0)// 0 for success, medicine added succsfully
                        {
                            
                            //(2) now get id of just added medicine
                            NSString * queryString=[NSString stringWithFormat:@"select medicineid from medicine where medicinename='%@' and userId=%d",objMedicine.medicineName,objUser.userId];
                            int medicineId=[classDatabaseOperations get:queryString ];
                            
                            // now add medicine id and its time,quantity in timequantitydetails table
                            for(classMedicineTime * objMedicineTime in objMedicine.medicineTimes)
                            {
                                
                                if(objMedicineTime.times !=nil)
                                {
                                    
                                    //(3)
                                   NSString * queryString=[NSString stringWithFormat:@"insert into medicinetimedetails (medicineid,medicinetime,medicinepillquantitytotake,doseNumber,userid) values (%d,'%@',%.1f,%d,%d)",medicineId,objMedicineTime.times,objMedicineTime.pillQuantity,objMedicineTime.doseNumber,self.objUser.userId];
                                   [classDatabaseOperations add:queryString];
                                    
                                    //savePicture of medicine
                                   
                                    

                                    
                                }
                            }
                            
                            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ saved\nsuccessfully",objMedicine.medicineName] message:@"Medicine added successfully in your personal medicine list." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                            alert.tag=150;
                            [alert show];
                            [alert release];
                            
                            
                            if(objUser.audioStatus==YES)
                            {
//                                if(objUser.language==1)
//                                {
                            NSMutableArray * array=[[NSMutableArray alloc] init];
                            [array addObject:@"medicineSaved"];
                            [myAudioPlayer playAudios:array];
                            [array release];
                                //}
                                
                               // else if(objUser.language==2)
                                //{
//                                    NSMutableArray * array=[[NSMutableArray alloc] init];
//                                    [array addObject:@"2MedSaveSucc"];
//                                    [myAudioPlayer playAudios:array];
//                                    [array release];
                                    
                                    
                                    
                               // }
                                
                                
                           }
                        }
                        else
                        {
                            NSLog(@" result: %d",result);
                            if(result==19)
                            {
                                UIAlertView * alert=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Unable to add %@",objMedicine.medicineName] message:@"Duplicate medicine." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                //alert.tag=150;
                                [alert show];
                                [alert release]; 
                            }
                            else
                            {
                            
                            UIAlertView * alert=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Unable to add %@",objMedicine.medicineName] message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                            //alert.tag=150;
                            [alert show];
                            [alert release];
                            }
                            
                        }
                    }
					
				}
				
			}
			
		}
		
	}
	
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(alertView.tag==150)
    {
        
        [self.delegate addMedicineDidComplete];
        
    }
    
    if(alertView.tag==151)
    {
        // same delegate method used for add and update
        [self.delegate addMedicineDidComplete];
        
    }
    
    if(alertView.tag==260)
    {
        
        [self dismissModalViewControllerAnimated:YES];
        
        
    }
    
}


-(BOOL)checkMedicineTimeAndShowAlert:(BOOL)showAlert;
{
    
	int count=0;
	
    
    
    // check that times are selected or not
    for(int i= 0; i<self.objMedicine.medicineDosesFrequency;i++)
    {
        
        classMedicineTime * objTime= [self.objMedicine.medicineTimes objectAtIndex:i];
        
        if(objTime.times!=nil && ![objTime.times isEqualToString:@""])
        {
            count++;
            
        }
        
    }
    
    
	if(count==objMedicine.medicineDosesFrequency && objMedicine.medicineDosesFrequency !=0)
	{
		return YES;
	}
	
	if(showAlert)
	{
		UIAlertView * alertError=[[UIAlertView alloc]initWithTitle:@"Please selecte medicine dose time" message:@"select time & pill quantity to take for each dose." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alertError show];
		[alertError release];
        
        
        if(objUser.audioStatus==YES)
      {
//            if(objUser.language==1)
//            {
        NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"pleaseSelectMedicineDsoeTime", nil];
        [myAudioPlayer playAudios:array ];
        [array release];
          //  }
//            else if(objUser.language==2)
//            {
//          NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"2pleaseSelectMedicineDsoeTime", nil];
//                [myAudioPlayer playAudios:array ];
//                [array release];
//
//                
//                
//            }
                
        }
        
	}
	return  NO;
    
}

-(BOOL)checkMedicineNameAndShowAlert :(BOOL)showAlert;
{
	//if medicine name is not empty string or nill then return true/yes
	if(![objMedicine.medicineName isEqualToString:@""] && objMedicine.medicineName!=nil)
	{
        
		return YES;
        
	}
	
	if(showAlert ==YES)
	{
		UIAlertView * alertError=[[UIAlertView alloc]initWithTitle:@"Please enter medicine name" message:@"Medicine name not entered." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alertError show];
		[alertError release];
        
        if(objUser.audioStatus==YES)
        {
//            if(objUser.language==1)
//            {
        NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"pleaseEnterMedicineName", nil];
        [myAudioPlayer playAudios:array ];
        [array release];
           // }
//            else if(objUser.language==2)
//            {
//                
//                NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"2EnterMedName", nil];
//                [myAudioPlayer playAudios:array ];
//                [array release];
//                
//                
//            }
                
            }
	}
	return NO;
}


-(BOOL)checkDosageFrequencyAndShowAlert:(BOOL)showAlert;
{
	//if medicine dosage frequency is grater tahn zero return yes
	if(objMedicine.medicineDosesFrequency>0)
	{
        
		return  YES;
        
	}
	
	if(showAlert==YES)
	{
        
		UIAlertView * alertError=[[UIAlertView alloc]initWithTitle:@"Please select medicine dosage frequency" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alertError show];
		[alertError release];
        
        if(objUser.audioStatus==YES)
        {
//            if(objUser.language==1)
//            {
        NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"pleaseSelectMedicineDosageFrequency", nil];
        [myAudioPlayer playAudios:array ];
        [array release];
        //    }
//            else if(objUser.language==2)
//            {
//                NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"2pleaseSelectMedicineDosageFrequency", nil];
//                [myAudioPlayer playAudios:array ];
//                [array release];
//  
//                
//                
//            }
        }
	}
	return NO;
}



-(BOOL)checkPillQuantityAndShowAlert:(BOOL)showAlert
{
    
    int count=0;
    
    // check that quantitys are selected or not
    for(int i= 0; i<objMedicine.medicineDosesFrequency;i++)
    {
        
        classMedicineTime * objTime= [objMedicine.medicineTimes objectAtIndex:i];
        
        if(objTime.pillQuantity!=0)
        {
            count++;
            
        }
        
    }
    
	
	
	
	
	if(count==objMedicine.medicineDosesFrequency && objMedicine.medicineDosesFrequency!=0)
	{
		return YES;
		self.btnSave.enabled=YES;
	}
	
	if(showAlert)
	{
		UIAlertView * alertError=[[UIAlertView alloc]initWithTitle:@"Please enter total pill quantiy in hand" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alertError show];
		[alertError release];
        
        if(objUser.audioStatus==YES)
        {
//            if(objUser.language==1)
//            {
            
        NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"pleaseSelectMedicinePillQuantity", nil];
        [myAudioPlayer playAudios:array];
        [array release];
          //  }
//            else if(objUser.language==2)
//            {
//                
//                
//                
//                NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"2pleaseSelectMedicinePillQuantity", nil];
//                [myAudioPlayer playAudios:array];
//                [array release];
//                
//            }
//            
            
            }
	}	
	
	
	return NO;
}


-(BOOL)checkTotalPillQuantityAndShowAlert:(BOOL)showAlert
{
    
    if(objMedicine.totalPillQuantity>0 || totalQuantityEntered==YES || isUpdateMode==YES)
    {
        
        
        return YES;
    }
    
    if(showAlert==YES)
    {
    UIAlertView * alertError=[[UIAlertView alloc]initWithTitle:@"Please enter total pill quantity in hand." message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertError show];
    [alertError release];
        
        if(objUser.audioStatus==YES)
        {
//            if(objUser.language==1)
//            {
        NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"totalPillQuantityMessage", nil];
        [myAudioPlayer playAudios:array];
        [array release];
           // }
//            else if(objUser.language==2)
//            {
//                NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"2EnterMedQtyInHand", nil];
//                [myAudioPlayer playAudios:array];
//                [array release];
//                
//            }
//            
            }

    }
    
        
    
    return NO;
}



-(void)doneTotalQuantityEntering
{
    
    totalQuantityEntered=YES;
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void)cancelTotalQuantityEntering
{
    
    
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void)cancel
{
    
    
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void)updateMedicine
{
    
    [self.textViewComments resignFirstResponder];
	
	
	
	if([self checkMedicineNameAndShowAlert:YES]==YES)
	{
        
		if([self checkDosageFrequencyAndShowAlert:YES]==YES)
		{
            
			
			if([self checkMedicineTimeAndShowAlert:YES]==YES)
			{
                
				
				if([self checkPillQuantityAndShowAlert:YES]==YES)
				{
					// set comments
                    objMedicine.medicineComments=textViewComments.text;
                    
                    
                    // (1) our query string to add medicine                      
                    NSString * queryString=[NSString stringWithFormat:@"update medicine set medicinename='%@' , medicinefrequency=%d, medicinetotalpillquantity=%.1f, reorderlevel=%d, medicinecomments='%@' where medicineid=%d and userid=%d",objMedicine.medicineName,objMedicine.medicineDosesFrequency,objMedicine.totalPillQuantity,objMedicine.reorderLevel,objMedicine.medicineComments, objMedicine.medicineSequenceId,objUser.userId];
                    NSLog(@"%@",queryString);
                    
                    // get result back of updating medicine
                    int result=[classDatabaseOperations add:queryString];
                    
                    if(result==0)// 0 for success, medicine updated succsfully
                    {
                        
                        // now delete medicines old image
                        //medicine name
                        NSString * imgName = [NSString stringWithFormat:@"%@%@%@",objMedicine.medicineName,objUser.firstName,objUser.lastName];
                        // covert Medicne image to nsdata
                        
                        // get path of document directory to save medicne
                        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
                        NSString *documentsDir = [documentPaths objectAtIndex:0];
                        NSString * documentImagePth = [documentsDir stringByAppendingPathComponent:imgName];
                        
                        NSFileManager *fileManager = [NSFileManager defaultManager];
                        [fileManager removeItemAtPath:documentImagePth error:nil];

                        // save new image
                        [self savePicture];
                        
                        
                        
                        
                        // get the mdicines id
                        int medicineId=objMedicine.medicineSequenceId;
                        
                        //1st delete all time details of this medicine and then save new times
                        
                        NSString * queryString=[NSString stringWithFormat:@"delete from medicinetimedetails where userid=%d and medicineid=%d",objUser.userId,medicineId];
                        [classDatabaseOperations add:queryString];
                        NSLog(@"%@",queryString);

                        
                        // now add medicine id and its time,quantity in timequantitydetails table
                        for(classMedicineTime * objMedicineTime in objMedicine.medicineTimes)
                        {
                            // now add medicine id and its time,quantity in timequantitydetails table
                                                            
                                if(objMedicineTime.times !=nil)
                                {
                                    
                                    //(3)
                                    NSString * queryString=[NSString stringWithFormat:@"insert into medicinetimedetails (medicineid,medicinetime,medicinepillquantitytotake,doseNumber,userid) values (%d,'%@',%.1f,%d,%d)",medicineId,objMedicineTime.times,objMedicineTime.pillQuantity,objMedicineTime.doseNumber,self.objUser.userId];
                                   int result= [classDatabaseOperations add:queryString];
                                    
                                    NSLog(@"New frequency%d, doseNumber %d and result%d",objMedicine.medicineDosesFrequency,objMedicineTime.doseNumber,result);
                                }
                            
                           
                        }
                        
                        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ updated\nsuccessfully",objMedicine.medicineName] message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        alert.tag=150;
                        [alert show];
                        [alert release];
                        
                        
                        if(objUser.audioStatus==YES)
                        {
//                            if(objUser.language==1)
//                            {
                        NSMutableArray * array=[[NSMutableArray alloc] init];
                        [array addObject:@"medicineUpdated"];
                        [myAudioPlayer playAudios:array];
                        [array release];
                          //  }
                            
//                          else  if(objUser.language==2)
//                            {
//                                
//                                NSMutableArray * array=[[NSMutableArray alloc] init];
//                                [array addObject:@"2medicineUpdated"];
//                                [myAudioPlayer playAudios:array];
//                                [array release];
//
//                                
//                            }

                        }
                        
                    }
                    else
                    {
                        
                        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Unable to update %@",objMedicine.medicineName] message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        alert.tag=150;
                        [alert show];
                        [alert release];
                        
                        
                    }

					
					
				}
				
			}
			
		}
		
	}

  
    
    
    
}
-(void)deleteMedicine
{
    
    
    
    
    
    
}

-(void)playAudio
{
    if(isUpdateMode)
    {
        
        
        
    }
    else
    {
//        if(objUser.language==1)
//        {
    NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"addNewMedicine", nil];
    [myAudioPlayer playAudios:array ];
    [array release];
      //  }
//        else if(objUser.language==2)
//        {
//            NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"2TapAddTOMEd", nil];
//            [myAudioPlayer playAudios:array ];
//            [array release];
//
//            
//            
//        }
        
    }
    
}


-(void)savePicture
{
    
    if(objMedicine.medicineImage!=nil)
    {
        
      
        //medicine name
        NSString * imgName = [NSString stringWithFormat:@"%@%@%@",objMedicine.medicineName,objUser.firstName,objUser.lastName];
        // covert Medicne image to nsdata
        NSData* imageData = UIImagePNGRepresentation(objMedicine.medicineImage);
        
        // get path of document directory to save medicne
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        NSString * databasePath = [documentsDir stringByAppendingPathComponent:imgName];
        
        
        
        
        // and then we write it out
        [imageData writeToFile:databasePath atomically:NO];
        
        
    }
    
    
    
    
}


-(int)countofmedicine:(classUser*)obj
{
    NSString * queryString=[NSString stringWithFormat:@"select count (*) from medicine where userid =%d",objUser.userId];
    NSLog(@"%@",queryString);
    
    
    float result=[classDatabaseOperations get:queryString];    
    NSLog(@" RESULT COUNT %@",result);
    return result;
    
}



@end

