//
//  classPillBoxNew.m
//  pillBoxGuide
//
//  Created by Avi Kulkarni on 6/25/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classPillBoxNew.h"
//#import "classMedicineNew.h"
//#import "classTime.h"
//#import "PillBox.h"
#import "classAudio.h"

#import "classMedicineIndex.h"
#import "classMedicine.h"
#import "classUser.h"
#import "classMedicineTime.h"
#import "commanFunctions.h"
#import "classDatabaseOperations.h"

int currentMedicineObject;
NSMutableArray * arrayOfTextNumbers;




@implementation classPillBoxNew
@synthesize myTable;
@synthesize btnUndo;

@synthesize lblMedicineName;
@synthesize lblPillQuantity;
@synthesize lblStepDetails1;
@synthesize lblMedicineFrequency;
@synthesize lblStepDetails;
@synthesize lblStep;
@synthesize btnFill1;
@synthesize btnFill2;
@synthesize btnFill3;
@synthesize btnFill4;
@synthesize imgViewArrow;
@synthesize imgViewPillBoxRow1;
@synthesize imgViewPillBoxRow2;
@synthesize imgViewPillBoxRow3;
@synthesize imgViewPillBoxRow4;
@synthesize lblFilledMorning;
@synthesize lblFilledAfternoon;
@synthesize btnSelectMedicine;
@synthesize lblFilledEvening;
@synthesize lblFilledNight;
@synthesize arrayMedicineObjects;
@synthesize myPillBox;
@synthesize viewStepMessage;
@synthesize btnFill;
@synthesize imgViewStep;
@synthesize myAudioPlayer;


@synthesize arrayPillbox;
@synthesize arrayMedicineIndex;
@synthesize objUser;
@synthesize selectedMedicine;
@synthesize delegate=_delegate;

@synthesize strSelectedMedTimeSpan;
@synthesize selectedPillQty;
@synthesize selectedMedName;
@synthesize selctedMedId;

@synthesize arrayOfTextNumbersSapnish;

@synthesize MedFlag;
@synthesize prescQty;
@synthesize audioflag;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        
        
            arrayOfTextNumbers=[[NSMutableArray alloc] initWithObjects:@"zero",@"one",@"two",@"three",@"four",@"five",@"six",@"seven",@"eight",@"nine",@"ten",@"eleven",@"twelve",@"thirteen",@"fourteen",@"fifteen",@"sexteen",@"seventeen",@"eighteen",@"nineteen",@"twenty", nil];
        arrayOfTextNumbersSapnish=[[NSMutableArray alloc]initWithObjects:@"zero",@"2one",@"2two",@"2three",@"2four",@"2five",@"2six",@"2seven",@"2eight",@"2nine",@"2ten",@"2eleven",@"2twelve",@"2thirteen",@"2fourteen",@"fifteen",@"2sexteen",@"2seventeen",@"2eighteen",@"2nineteen",@"2twenty", @"2twenty-one",nil];
        

    }
    return self;
}

- (void)dealloc
{
    [lblMedicineName release];
    [lblMedicineName release];
    [lblMedicineFrequency release];
    [lblStep release];
    [lblStepDetails release];
    [lblPillQuantity release];
    [btnFill1 release];
    [btnFill2 release];
    [btnFill3 release];
    [btnFill4 release];
    [imgViewArrow release];
    [imgViewArrow release];
    [imgViewPillBoxRow1 release];
    [imgViewPillBoxRow2 release];
    [imgViewPillBoxRow3 release];
    [imgViewPillBoxRow4 release];
    [lblFilledMorning release];
    [lblFilledAfternoon release];
    [lblFilledEvening release];
    [lblFilledNight release];
    [lblStepDetails1 release];
    [btnUndo release];
    [myTable release];
    [viewStepMessage release];
    [imgViewStep release];
    [btnFill release];
    [btnSelectMedicine release];
    self.arrayMedicineObjects=nil;
    
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
    
       //reset to zero
    currentMedicineObject=0;
    [self setData];
    
    self.title=@"PillBox";       
    
    self.myTable.backgroundColor=[UIColor clearColor];    
    self.viewStepMessage.backgroundColor=[UIColor clearColor];    
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)] autorelease];
    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Skip" style:UIBarButtonItemStylePlain target:self action:@selector(skipMedicine)] autorelease];
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    if(objUser.audioStatus==YES)
    {
        audioflag=1;
    }
//    NSString *strImg1=@"backImage1.png";
//    UIImageView *logoView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:strImg1]];
//    NSString *strImg=[classDatabaseOperations getNurseImg:objUser.userId];
//    NSLog(@"%@image",strImg);
//    if ([strImg isEqualToString:@"null"])
//    {
//        logoView.image=[UIImage imageNamed:strImg1];
//    }
//    else{
//        NSLog(@"Nurse is %@",strImg);
//        logoView.image=[UIImage imageNamed:strImg];
//    }
//    
//    
//    logoView.frame = CGRectMake(270, 0, 43, 43);
//    
//    
//    [self.navigationController.navigationBar addSubview:logoView];
}



- (void)viewDidUnload
{
    lblMedicineName = nil;
    [self setLblMedicineName:nil];
    [self setLblMedicineFrequency:nil];
    [self setLblStep:nil];
    [self setLblStepDetails:nil];
    [self setLblPillQuantity:nil];
    [self setBtnFill1:nil];
    [self setBtnFill2:nil];
    [self setBtnFill3:nil];
    [self setBtnFill4:nil];
    [self setImgViewArrow:nil];
    [self setImgViewArrow:nil];
    [self setImgViewPillBoxRow1:nil];
    [self setImgViewPillBoxRow2:nil];
    [self setImgViewPillBoxRow3:nil];
    [self setImgViewPillBoxRow4:nil];
    [self setLblFilledMorning:nil];
    [self setLblFilledAfternoon:nil];
    [self setLblFilledEvening:nil];
    [self setLblFilledNight:nil];
    [self setLblStepDetails1:nil];
    [self setBtnUndo:nil];
    [self setMyTable:nil];
    [self setViewStepMessage:nil];
    [self setImgViewStep:nil];
    [self setBtnFill:nil];
    [self setBtnSelectMedicine:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;

}

-(void)setData
{
    btnFill.hidden=NO;
    btnSelectMedicine.hidden=YES;

    NSString * medicineName=selectedMedicine.medicineName;
    int frequency=selectedMedicine.medicineDosesFrequency;

    
    if(currentMedicineObject<[self.arrayMedicineIndex count])
    {
        //classMedicineNew * objMedicine=[self.arrayMedicineObjects objectAtIndex:currentMedicineObject];
        
        // set medicne name
        lblMedicineName.text=medicineName;
        
        //NSLog(@"MY %@",medicineName);
        
        //set frequency
        lblMedicineFrequency.text=[NSString stringWithFormat:@"Take %@ %d time(s) in a day",medicineName,frequency];
        //NSLog(@"MY DOSE %d",selectedMedicine.medicineDosesFrequency);
        //set quantity
        lblPillQuantity.text=[self getPillQuantity];
        
        // set step number
        lblStep.text=[NSString stringWithFormat:@"Step-%d",currentMedicineObject+1];
        
        // ste step message    
        lblStepDetails.text=[self getStepMessage:[selectedMedicine.medicineTimes objectAtIndex:currentMedicineObject]];
        
        if(objUser.audioStatus==YES)
        {
        [self playAudio];
        }
        //animate arrow and button according to time
        [self animateArrowAndFillButton:[selectedMedicine.medicineTimes objectAtIndex:currentMedicineObject]];
        
    }
    else
    {
      if(MedFlag==0)
      {      
        [self medicineFillingComplete];
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@ filled in all compartments",selectedMedicine.medicineName] message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil ];
          alert.tag=101;
            [alert show];
            [alert release];
        
        
        if(objUser.audioStatus==YES)
        {
            
            if(objUser.language== 1)
            {
                NSMutableArray* array=[[NSMutableArray alloc] init];
                [array addObject:@"medicineFilledinAllCompartments"];
                [self.myAudioPlayer playAudios:array];
                [array release];
            }
            
            
          else if(objUser.language== 2)
            {
                NSMutableArray* array=[[NSMutableArray alloc] init];           
                [array addObject:@"2medicineFilledinAllCompartments"];
                [self.myAudioPlayer playAudios:array];
                [array release];
            }

            
        }   

        }
       else
        {
          [self medicineFillingComplete]; 
            if(objUser.audioStatus==YES)
            {
                
                if(objUser.language== 1)
                {
                    NSMutableArray* array=[[NSMutableArray alloc] init];
                    [array addObject:@"medicineFilledinAllCompartments"];
                    [self.myAudioPlayer playAudios:array];
                    [array release];
                }
                
                
                else if(objUser.language== 2)
                {
                    NSMutableArray* array=[[NSMutableArray alloc] init];           
                    [array addObject:@"2medicineFilledinAllCompartments"];
                    [self.myAudioPlayer playAudios:array];
                    [array release];
                }
                
                
            }   

            
//           UIAlertView * alert=[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@ filled in all compartments",selectedMedicine.medicineName] message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil ];
//            alert.tag=101;
//            [alert show];
//           [alert release];

        }
    }
    
}


-(NSString *)getPillQuantity
{
    
    int count1=1;
    int count2=[self.arrayMedicineIndex count];
    
    NSMutableString * strTimeAndQuantity=[[NSMutableString alloc] init];
    
    [strTimeAndQuantity appendString:@"("];
    
    for(classMedicineTime * objMedTime in selectedMedicine.medicineTimes)
    {
        
        if(objMedTime.times!=nil)
        {
           // int timeSapn=[classTime chekTimeSpan:objMed.timeToTake use24HourClock:NO];
            
            
            // append medicine time
            [strTimeAndQuantity appendFormat:@"%@:",objMedTime.timeSpan];
            
            
            // append quantity
            int a=(int)objMedTime.pillQuantity;
            float b=objMedTime.pillQuantity-a;
            
            if(b==0)// if quantity is interger
            {            
                [strTimeAndQuantity appendFormat:@"%d",a];
                
                
            }
            else // if quantity is float e.g. 1.5 or 0.5 etc
            {
                
                [strTimeAndQuantity appendFormat:@"%.1f",objMedTime.pillQuantity];           
                
            }
            
            
            if(count1<count2)// appen quama
            {
                
                
                [strTimeAndQuantity appendFormat:@", "];
                count1++;
            }
            
        
        
        }
        
    }
    
    [strTimeAndQuantity appendString:@")"];  
    return [strTimeAndQuantity autorelease];
}


-(NSString*)getStepMessage:(classMedicineTime *)objMedTime
{
    NSString * strMessage;
    
    int a=(int)objMedTime.pillQuantity;
    float b=objMedTime.pillQuantity-a;
        
    // NSLog(@"MY msg Pill QTY %.1f",objMedTime.pillQuantity);
   
    
    selectedPillQty=objMedTime.pillQuantity;
    strSelectedMedTimeSpan=objMedTime.timeSpan;
   
    
    // NSLog(@"MY msg %@",objMedTime.timeSpan);
    if(b==0)// if quantity is interger
    {            
        int TotalPills=a*7;
        
        strMessage=[NSString stringWithFormat:@"Pick up %d pills for %@ compartments",TotalPills,objMedTime.timeSpan];
        
       // NSLog(@"MY %@",objMedTime.timeSpan);
        if(a>1)
        {
            lblStepDetails1.text=[NSString stringWithFormat:@"and put %d pills in each.",a];
            
        }
        else
        {
            lblStepDetails1.text=[NSString stringWithFormat:@"and put %d pill in each.",a];
            
        }
        
    }
    else // if quantity is float e.g. 1.5 or 0.5 etc
    {
        
        float TotalPills=objMedTime.pillQuantity*7;
        
        strMessage=[NSString stringWithFormat:@"Pick up %.1f pills for %@ compartments",TotalPills,objMedTime.timeSpan];
        
        if(objMedTime.pillQuantity>1.0)
        {   
            lblStepDetails1.text=[NSString stringWithFormat:@"and put %.1f pills in each.",objMedTime.pillQuantity] ;
            
        }
        else
        {
            lblStepDetails1.text=[NSString stringWithFormat:@"and put %.1f pill in each.",objMedTime.pillQuantity] ;
            
            
        }
        
    }
    
  
    return strMessage;
    
}

- (IBAction)selectMedicine:(id)sender
{
    
    
    [self.delegate methodPillBoxFillingComplete];    
}

-(void)animateArrowAndFillButton:(classMedicineTime *)objMedTime
{
    classMedicineIndex * objIndex=[self.arrayMedicineIndex objectAtIndex:currentMedicineObject];

    
    NSString * stringTime=objMedTime.timeSpan;
    
    [ self.imgViewPillBoxRow1 setImage:[UIImage imageNamed:@"pil1.png"]];
    [ self.imgViewPillBoxRow2 setImage:[UIImage imageNamed:@"pil1.png"]];
    [ self.imgViewPillBoxRow3 setImage:[UIImage imageNamed:@"pil1.png"]];
    [ self.imgViewPillBoxRow4 setImage:[UIImage imageNamed:@"pil1.png"]];
    
    
    if([stringTime isEqualToString:@"Morning"])
    {
        
        if([self methodCheckMedicineDoseFilledInPillBox:objIndex])
        {
            
            
            lblFilledMorning.hidden=NO;
            btnFill1.hidden=YES;
            
            
            currentMedicineObject++;            
            
                [self setData];           
            
        }
        
        else
        {
            
            
            lblFilledMorning.hidden=YES;
            
            
            CGPoint position;
            [UIView beginAnimations:@"MoveMessage" context:nil];
            [UIView setAnimationDuration:0.8];
            
            position.x=159;
            position.y=197;        
            self.viewStepMessage.center=position;
            [UIView commitAnimations];
            
            
            [ self.imgViewPillBoxRow1 setImage:[UIImage imageNamed:@"morningPillBoxSmall.png"]];
            
            
        }
        
    }
    else if([stringTime isEqualToString:@"Afternoon"])
        
    {
        
        if([self methodCheckMedicineDoseFilledInPillBox:objIndex])
        {
            lblFilledAfternoon.hidden=NO;
            currentMedicineObject++;
            
            
                [self setData];
            
            
        }
        
        else
        {
            
            lblFilledAfternoon.hidden=YES;
            
            [UIView beginAnimations:@"MoveArrow" context:nil];
            [UIView setAnimationDuration:0.8];
            
            CGPoint position;
            position.x=159;
            position.y=235;        
            self.viewStepMessage.center=position;
            [UIView commitAnimations];
            
            //[ self.imgViewPillBoxRow2 setImage:[UIImage imageNamed:@"greenBays.png"]];
            [ self.imgViewPillBoxRow1 setImage:[UIImage imageNamed:@"afternoonPillBoxSmall.png"]];
            
            
        }
        
    }
    else if([stringTime isEqualToString:@"Evening"])
        
    {
        if([self methodCheckMedicineDoseFilledInPillBox:objIndex])
        {
            lblFilledEvening.hidden=NO;
            currentMedicineObject++;
            
            
                [self setData];
            
            
        }
        
        else
        {
            
            lblFilledEvening.hidden=YES;
            
            [UIView beginAnimations:@"MoveArrow" context:nil];
            [UIView setAnimationDuration:0.8];
            
            CGPoint position;
            position.x=159;
            position.y=274 ;
            self.viewStepMessage.center=position;
            [UIView commitAnimations];            
            
            [ self.imgViewPillBoxRow1 setImage:[UIImage imageNamed:@"eveningPillBoxSmall.png"]];

            
        }
        
    }
    else if([stringTime isEqualToString:@"Night"])
        
    {
        if([self methodCheckMedicineDoseFilledInPillBox:objIndex])
        {
            lblFilledNight.hidden=NO;
            currentMedicineObject++;
            
                [self setData];
            
        }
        
        else
        {
            
            //  btnFill4.hidden=NO;
            lblFilledNight.hidden=YES;
            imgViewArrow.hidden=NO;
            
            [UIView beginAnimations:@"MoveArrow" context:nil];
            [UIView setAnimationDuration:0.8];
            
            CGPoint position;
            position.x=159;
            position.y=312;        
            self.viewStepMessage.center=position;
            [UIView commitAnimations];
            
            
            
            [ self.imgViewPillBoxRow1 setImage:[UIImage imageNamed:@"nightPillBoxSmall.png"]];

            
            
        }
        
    }
    
    
    
}


-(void)showFilledLabel:(classMedicineTime *)objMedTime
{
    
    
        
    
    
    if([objMedTime.timeSpan isEqualToString:@"Morning"])
    {
        
        
        self.lblFilledMorning.hidden=NO;
        
        
    }
    if([objMedTime.timeSpan isEqualToString:@"Afternoon"])
    {
        
        
        self.lblFilledAfternoon.hidden=NO;
        
        
    }
    
    if([objMedTime.timeSpan isEqualToString:@"Evening"])
    {
        
        
        self.lblFilledEvening.hidden=NO;
        
        
    }
    
    if([objMedTime.timeSpan isEqualToString:@"Night"])
    {
        
        
        self.lblFilledNight.hidden=NO;
        
        
    }
    
}



- (IBAction)UndoStep:(id)sender 
{
    
    int index=-1;
    
    if(currentMedicineObject!=0)
    {
        
        currentMedicineObject--;
       // NSLog(@"%d",currentMedicineObject);
        
//        classMedicineNew * objMedicine=[self.arrayMedicineObjects objectAtIndex:currentMedicineObject];
//        
//        for(classMedicineNew * objMed in myPillBox.arrayPillBox)
//        {
//            
//            index++;
//            
//            if([objMed.name isEqualToString:objMedicine.name] &&[objMed.timeToTake isEqualToString:objMedicine.timeToTake])
//            {
//                
//                
//                break;
//                
//            }
//            
//            
//        }
        
        
        
        classMedicineIndex * objIndex=[self.arrayMedicineIndex objectAtIndex:currentMedicineObject];
        
        for(classMedicineIndex * objIndex1 in self.arrayPillbox)
        {
            
            
            index++;
            
            if(objIndex.medicineId==objIndex1.medicineId && objIndex.doseNumber==objIndex1.doseNumber)
            {
                
                break;
                
            }
            
            
            
        }
        
        
        
        if(index!=-1)
        {        
            
            [self.arrayPillbox removeObjectAtIndex:index];
            
            [self setData];
            
        }
        
        
        
    }
    
    
}

- (IBAction)fillPillBox:(UIButton *)sender
{
    
    
    
//    //add medicine object in pilbox object arrya
//    if(currentMedicineObject<[self.arrayMedicineObjects count])
//    {
//    [myPillBox.arrayPillBox addObject:[self.arrayMedicineObjects objectAtIndex:currentMedicineObject]];
//    
//    //show filled on label
//    [self showFilledLabel:[self.arrayMedicineObjects objectAtIndex:currentMedicineObject]];
//    }
//    //increment medicne number,  
//    currentMedicineObject++;
//    
//    // if currentmedicineobject counter is less than arrray lenth then show next medicicn data or show alert
//    
//    [self setData];
//        
        /////////
      
       if(currentMedicineObject<[self.arrayMedicineIndex count])
       {
           
           [self.arrayPillbox addObject:[self.arrayMedicineIndex objectAtIndex:currentMedicineObject]];
           [self showFilledLabel:[selectedMedicine.medicineTimes objectAtIndex:currentMedicineObject]];

           NSLog(@"MY fillBox name %@  ",selectedMedicine.medicineName);
           
               
    
           NSLog(@"MY fillBox seq  dose  %d ",selectedMedicine.medicineSequenceId);
           NSLog(@"MY fillBox dose no. %d ",selectedMedicine.doseNumber);
            NSLog(@"MY fillBox userid %d ",objUser.userId);

        NSLog(@"MY msg Fillbox Pill QTY %.1f",selectedPillQty);
           NSLog(@"MY msg %@",strSelectedMedTimeSpan);

           
           
           selectedMedName=self.selectedMedicine.medicineName;
            selctedMedId =selectedMedicine.medicineSequenceId;
           
       
           [self methodFillBoxInDatabase];
           
           
       }
    
        currentMedicineObject++;
        [self setData];

       
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
  
    if(alertView.tag==101)
    {    if(buttonIndex==0)
    {
        
      //  currentMedicineObject=0; 
        
        
    }
    else if(buttonIndex==1)

    {
        
        //[self.navigationController popViewControllerAnimated:YES];
       
        [self.delegate methodPillBoxFillingComplete];

        
    }
    }
    if(alertView.tag==110)
    {
       if(buttonIndex==0)
       {
           if( audioflag==1)
           {
               objUser.audioStatus=YES;
               
           }
           if(currentMedicineObject<[self.arrayMedicineIndex count])
           {
               if( objUser.audioStatus==YES)
               {
                   [self playAudio]; 
               }
               
           }
           

       }
        else
        {   
            if( audioflag==1)
            {
                objUser.audioStatus=YES;
               
            }
        
            
              if(currentMedicineObject<[self.arrayMedicineIndex count])
              {
               if( objUser.audioStatus==YES)
               {
                  [self playAudio]; 
               }
              
            }
             [self methodFillBoxInDatabaseAgain];
            
        }
    }
    
    if(alertView.tag==111)
    {
        if(buttonIndex==0)
        {
            if( audioflag==1)
            {
                objUser.audioStatus=YES;
                
            }
            if(currentMedicineObject<[self.arrayMedicineIndex count])
            {
                if( objUser.audioStatus==YES)
                {
                    [self playAudio]; 
                }
                
            }

        }
        else
        {
            if( audioflag==1)
            {
                objUser.audioStatus=YES;
            }

            if(currentMedicineObject<[self.arrayMedicineIndex count])
            {

                if( objUser.audioStatus==YES)
                {
                    [self playAudio]; 
                }
                  
            }
            [self methodFillBoxInDatabaseAgainNoon]; 
        }
    }
    
    if(alertView.tag==112)
    {
        if(buttonIndex==0)
        {
            if( audioflag==1)
            {
                objUser.audioStatus=YES;
                
            }
            if(currentMedicineObject<[self.arrayMedicineIndex count])
            {
                if( objUser.audioStatus==YES)
                {
                    [self playAudio]; 
                }
                
            }

        }
       
        else
        {
            if( audioflag==1)
            {
                objUser.audioStatus=YES;
            }

            if(currentMedicineObject<[self.arrayMedicineIndex count])
            {
                if( objUser.audioStatus==YES)
                {
                    [self playAudio]; 
                }

            }
             [self methodFillBoxInDatabaseAgainEvening]; 
        }
    }
    
    if(alertView.tag==113)
    {
        if(buttonIndex==0)
        {
            if( audioflag==1)
            {
                objUser.audioStatus=YES;
                
            }
            if(currentMedicineObject<[self.arrayMedicineIndex count])
            {
                if( objUser.audioStatus==YES)
                {
                    [self playAudio]; 
                }
                
            }

        }
        else
        {
            if( audioflag==1)
            {
                objUser.audioStatus=YES;
            }
            if(currentMedicineObject<[self.arrayMedicineIndex count])
            {

                if( objUser.audioStatus==YES)
                {
                    [self playAudio]; 
                }
              
                  
            }
             [self methodFillBoxInDatabaseAgainNight];
        }
    }
    

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0)
    {
        if(indexPath.row==0)
        {
            
            return 55;
            
        }
        else
        {
            return 45;
        }
    }
    //    else
    //    {
    //        
    //        return 55;
    //        
    //        
    //    }
    
    
	return 0;
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
	return nil;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section==0)
    {
        return 2;
    }
    //    else  if(section==1)
    //    {
    //        return 1;
    //        
    //    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
   
    
    if(indexPath.section==0)
    {
        cell.textLabel.font=[UIFont fontWithName:@"Futura" size:17];
        cell.textLabel.font=[UIFont boldSystemFontOfSize:17.0 ];  
        cell.detailTextLabel.font=[UIFont fontWithName:@"Futura" size:13.0f];
        
        if(indexPath.row==0)
        {
            cell.textLabel.text=selectedMedicine.medicineName;
            
            if(selectedMedicine.medicineDosesFrequency>1)
            {
            cell.detailTextLabel.text=[NSString stringWithFormat:@"Take %@ %d times in a day",selectedMedicine.medicineName,selectedMedicine.medicineDosesFrequency];
            }
            else
            {
                cell.detailTextLabel.text=[NSString stringWithFormat:@"Take %@ %d time in a day",selectedMedicine.medicineName,selectedMedicine.medicineDosesFrequency];
 
                
            }
            if(selectedMedicine.medicineImage==nil)
            {
                
                
                cell.imageView.image=[UIImage imageNamed:@"closedbottal.jpg"];
                
            }
            else
            {
                
                cell.imageView.image=selectedMedicine.medicineImage;
                
                
            }
            
        }
        else if(indexPath.row==1)
            
        {
            cell.textLabel.font=[UIFont fontWithName:@"Futura" size:15.0];
            cell.textLabel.font=[UIFont boldSystemFontOfSize:15.0 ];  
            cell.detailTextLabel.font=[UIFont fontWithName:@"Futura" size:12.0f];
            cell.textLabel.text=@"Prescribed Quantity";
            cell.detailTextLabel.text=[self getPillQuantity];
            
            
        }
        
        
    }
    //    else if(indexPath.section==1)
    //    {
    //        cell.textLabel.font=[UIFont fontWithName:@"Futura" size:18];
    //        cell.textLabel.font=[UIFont boldSystemFontOfSize:18.0 ];  
    //        cell.textLabel.text=@"Prescribed Quantity";
    //        
    //        
    //    }
    
    
    return cell;
    
}

-(void)medicineFillingComplete
{
    
    [UIView beginAnimations:@"MoveArrow" context:nil];
    [UIView setAnimationDuration:0.8];
    
    CGPoint position;
    position.x=159;
    position.y=175;        
    self.viewStepMessage.center=position;
    [UIView commitAnimations];
    
    
    self.lblStep.text=@"Steps Complete";
    self.lblStepDetails.text=[NSString stringWithFormat:@"%@ filled in all compartments",selectedMedicine.medicineName];
    self.lblStepDetails1.text=@"please select next medicine.";
    
    
    btnFill.hidden=YES;
    btnSelectMedicine.hidden=NO;

    
}

-(void)playAudio
{
    
    
    
    
    
    NSMutableArray * array=[[NSMutableArray alloc] init];
    
    classMedicineTime * objMedTime=[selectedMedicine.medicineTimes objectAtIndex:currentMedicineObject];
    //(4)
    int a=(int)objMedTime.pillQuantity;
    int qty=a*7;
if(qty<21)
{
    
    if(objUser.language==1)
    {
    switch (currentMedicineObject)
        {
        case 0:    [array addObject:@"stepOne"];

            
            break;
            
        case 1:    [array addObject:@"stepTwo"];

            
            break;
            
        case 2:    [array addObject:@"stepThree"];

            
            break;
            
        case 3:    [array addObject:@"stepFour"];

            
            break;
   
   
        }   
    }
        else if(objUser.language==2)
        
        {
            switch (currentMedicineObject)
            {
                case 0:    [array addObject:@"2stepOne"];
                    
                    
                    break;
                    
                case 1:    [array addObject:@"2stepTwo"];
                    
                    
                    break;
                    
                case 2:    [array addObject:@"2stepThree"];
                    
                    
                    break;
                    
                case 3:    [array addObject:@"2stepFour"];
                    
                    
                    break;
                    
                    
            }   

            
        }
        
        
        
    
    
    
    
    classMedicineTime * objMedTime=[selectedMedicine.medicineTimes objectAtIndex:currentMedicineObject];
    //(4)
    int a=(int)objMedTime.pillQuantity;
    float b=objMedTime.pillQuantity-a;
    
    //int totalQuantity=a*7; 
    //NSLog(@"%d",totalQuantity);
    
   // NSLog(@"%@",arrayOfTextNumbers);
    if(objUser.language==1)
    {
    NSString * totalQuantityToPickUp=[arrayOfTextNumbers objectAtIndex:((int)(objMedTime.pillQuantity*7))];  
    
    //NSLog(@"%@",totalQuantityToPickUp);
    [array addObject:totalQuantityToPickUp];
    }
    else if(objUser.language==2)
    {
        NSString * totalQuantityToPickUp=[arrayOfTextNumbersSapnish objectAtIndex:((int)(objMedTime.pillQuantity*7))];  
        
        //NSLog(@"%@",totalQuantityToPickUp);
        [array addObject:totalQuantityToPickUp];
        
        
    }
    
    if(b!=0)
    {
        if(objUser.language==1)
        {
        [array addObject:@"andHalf"];
        }
        else if(objUser.language==2)
        {
            
            [array addObject:@"2AndHalf"]; 
            
            
        }
        
        
        
    }

   
    
    //(7)
    NSString * timeSapn= objMedTime.timeSpan;   
    
    
    if([timeSapn isEqualToString:@"Morning"])
    {
        if(objUser.language==1)
        {
 
            [array addObject:@"pillsForMorningCompartments"];
            
        }  
        else if(objUser.language==2)
        {
            [array addObject:@"2pillsForMorningCompartments"];

        }
   
    }
   
    
    else     if([timeSapn isEqualToString:@"Afternoon"])

    {
        if(objUser.language==1)
        {

        [array addObject:@"pillsForAftrnooonCompartments"];
        
        }
         else if(objUser.language==2)
        {
            
            [array addObject:@"2pillsForAftrnooonCompartments"];
            
        }

        
    }
    else     if([timeSapn isEqualToString:@"Evening"])
        
    {
        if(objUser.language==1)
        {
        [array addObject:@"pillsForEveningCompartments"];
        }

        else if(objUser.language==2)
        {
            
            [array addObject:@"2pillsForEveningCompartments"];

            
            
        }
        
        
        
        
    }
    else if([timeSapn isEqualToString:@"Night"])
        
    {
        if(objUser.language==1)
        {
        
        [array addObject:@"pillsForNightCompartments"];
            
        }

            else if(objUser.language==2)
            {
                [array addObject:@"2pillsForNightCompartments"];
 
            }
    }
    
    
    
    //(9)
    
    
    switch (a) 
    {
        case 0: if(objUser.language==1)
        {

            [array addObject:@"half"];
        }
            else if(objUser.language==2)
            {
                
                [array addObject:@"2half"];
                
            }
            break;
            
        case 1:    
            if(objUser.language==1)
            {
            [array addObject:@"one"];
            }
            else if(objUser.language==2)
            {
                
                [array addObject:@"2one"];
            }
            break;
            
        case 2: 
            if(objUser.language==1)
            {
            [array addObject:@"two"];
            }
            else if(objUser.language==2)
            {
                [array addObject:@"2two"]; 
            }
                
                break;
            
        case 3:    
            if(objUser.language==1)
            {

            [array addObject:@"three"];  
                
            }   
            else if(objUser.language==2)
            {
                [array addObject:@"2three"]; 
            }

            break;
            
        case 4: if(objUser.language==1)
        {
   
            [array addObject:@"four"]; 
        }
        else if(objUser.language==2)
        {
            [array addObject:@"2four"]; 
        } 
            
            break;
            
        case 5:    if(objUser.language==1)
        {
            [array addObject:@"five"]; 
        }
        else if(objUser.language==2)
        {
            [array addObject:@"2five"]; 
        }
            break;
            
        case 6: 
            if(objUser.language==1)
        {
 
            [array addObject:@"six"]; 
            
        }
            else if(objUser.language==2)
            {
                [array addObject:@"2six"]; 
            }
            break;
        case 7:     if(objUser.language==1)
        {
            
            [array addObject:@"six"]; 
            
        }
        else if(objUser.language==2)
        {
            [array addObject:@"2six"]; 
        }
            break;
        case 8:     if(objUser.language==1)
        {
            
            [array addObject:@"six"]; 
            
        }
        else if(objUser.language==2)
        {
            [array addObject:@"2six"]; 
        }
            break;
        case 9:     if(objUser.language==1)
        {
            
            [array addObject:@"six"]; 
            
        }
        else if(objUser.language==2)
        {
            [array addObject:@"2six"]; 
        }
            break;        
        case 10:     if(objUser.language==1)
        {
            
            [array addObject:@"six"]; 
            
        }
        else if(objUser.language==2)
        {
            [array addObject:@"2six"]; 
        }
            break;
    }
    
    
    //(10)
    if(b!=0 && a!=0)
    {
        
        if(objUser.language==1)
        {
        [array addObject:@"andHalf"];
        [array addObject:@"PillsInEach"];
        }
        else if(objUser.language==2)
        {
            [array addObject:@"2AndHalf"];
            [array addObject:@"2PillsInEach"]; 
            
            
        }
    }
    else
    {
        
        if(objUser.language==1)
        {
        [array addObject:@"pillInEach"];
    
        }
        else if(objUser.language==2)
        {
            
            [array addObject:@"2pillInEach"];
  
            
            
        }
    }
    
    
    
    
    [self.myAudioPlayer playAudios:array];
 
        
    }   
    
    
    
    else
    {
        NSLog(@"called else Qty ");
        
        
        
        
        
        
        
        
    }
    
    
    
        
        [array release];
}

-(BOOL)methodCheckMedicneFilledCompletely:(classMedicine *)objMedicine
{
    
    int count=0;
    
    for(classMedicineIndex * objIndex in self.arrayPillbox)
    {
        
        
        if(objMedicine.medicineSequenceId==objIndex.medicineId)
        {
            
            count++;
            
            NSLog(@"  dose count %d",count);
            
            
            
        }
        
        
        
        if(count==objMedicine.medicineDosesFrequency)
        {
            
            NSLog(@"if equl = %d",count);

            return YES;
        }
        
        
    }
    
    
    return NO;
    
    
}


-(BOOL)methodCheckMedicineDoseFilledInPillBox:(classMedicineIndex *)objMedTime
{
    
    for(classMedicineIndex * objMedTime1 in self.arrayPillbox)
    {
        
        if(objMedTime.medicineId==objMedTime1.medicineId && objMedTime.doseNumber==objMedTime1.doseNumber)
        { 
            NSLog(@"if equl");
            
            return YES;
            
        }
        
        
    }
    
    
    return NO;
    
}

-(void)cancel
{
    
    
    
    
    [self.delegate methodPillBoxFillingCancel];
    
}

-(void)skipMedicine
{
    
    
   for(classMedicineIndex * objMedIndex in self.arrayMedicineIndex)
   {
       
       if(![self methodCheckMedicineDoseFilledInPillBox:objMedIndex])
       {
         [self.arrayPillbox addObject:objMedIndex];
       }
       
       
   }
    
    
    [self.delegate methodPillBoxFillingComplete];
    
}


-(void)methodFillBoxInDatabase

{
    
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd-MM-yyyy HH:mm"];
    
 NSString *date =[df stringFromDate:myDate];
    
    NSLog(@"date %@",date);
    [df release ];     
    
    
    
    NSArray * arrayDay=[NSArray arrayWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
    
    NSArray * arrayMorning=[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
    
    NSArray * arrayNoon=[NSArray arrayWithObjects:@"8",@"9",@"10",@"11",@"12",@"13",@"14",nil];
    
    NSArray * arrayEvening=[NSArray arrayWithObjects:@"15",@"16",@"17",@"18",@"19",@"20",@"21",nil];
    
    NSArray * arrayNight=[NSArray arrayWithObjects:@"22",@"23",@"24",@"25",@"26",@"27",@"28",nil];
    
    
    
    
    for(int i=0;i<7;i++)
    {
        
        
       if([strSelectedMedTimeSpan isEqualToString:@"Morning"])
       {
           NSString *query=[NSString stringWithFormat:@"select distinct(MedicineFlag) from takemedicine where medicineid=%d and medicinename='%@'and userid=%d and bayno='%@'and timespan='%@'",selctedMedId,selectedMedName,objUser.userId,(int)[arrayMorning objectAtIndex:i],strSelectedMedTimeSpan];
           int result=[classDatabaseOperations get:query];
           NSLog(@"medflag1 %d",result);
           
           prescQty=selectedPillQty;
           NSLog(@"pQty%f",prescQty);
           
           ////------------
           if(result==0)
           {
               MedFlag=0;
                      NSString * queryString=[NSString stringWithFormat:@"insert into takemedicine (medicineid,medicinename,medqty,userid,day,bayno,timespan,state,timestamp,MedicineFlag) values (%d,'%@',%.1f,%d,'%@','%@','%@',0,'Y',1)",selctedMedId,selectedMedName,selectedPillQty,objUser.userId,[arrayDay objectAtIndex:i],(int)[arrayMorning objectAtIndex:i],strSelectedMedTimeSpan];
           NSLog(@"%@",queryString);
               
               
           

           [classDatabaseOperations add:queryString];
           }
           else
           {
               objUser.audioStatus=NO;
               if( audioflag==1)
               {
                   //  objUser.audioStatus=YES;
                   
                   
                   
                   if(objUser.language== 1)
                   {
                       NSMutableArray* array=[[NSMutableArray alloc] init];
                       [array addObject:@"MornDup"];
                       [self.myAudioPlayer playAudios:array];
                       [array release];
                   }
                   
                   
                   else if(objUser.language== 2)
                   {
                       NSMutableArray* array=[[NSMutableArray alloc] init];           
                      // [array addObject:@"MornPresent"];
                      // [self.myAudioPlayer playAudios:array];
                       [array release];
                   }
                   
                   
               }   

               NSLog(@"Hello Good Morning");
               UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:[NSString stringWithFormat:@"Morning Compartment Already Has '%@'.Do You Want To        Continue ? ",selectedMedicine.medicineName] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"Continue" , nil];
               alert.tag=110;
               [alert show];
               [alert release];
               MedFlag=1;
               
               return;

           }
           
           
           
       }
        
       else if([strSelectedMedTimeSpan isEqualToString:@"Afternoon"])
        {
            NSString *query=[NSString stringWithFormat:@"select distinct(MedicineFlag) from takemedicine where medicineid=%d and medicinename='%@'and userid=%d and timespan='%@' and bayno='%@'",selctedMedId,selectedMedName,objUser.userId,strSelectedMedTimeSpan,(int)[arrayNoon objectAtIndex:i]];
            int result=[classDatabaseOperations get:query];
            
            NSLog(@"medflag2 %d",result);
             prescQty=selectedPillQty;
            
            //----------
           if(result==0)
           {
               MedFlag=0;
               NSString * queryString=[NSString stringWithFormat:@"insert into takemedicine (medicineid,medicinename,medqty,userid,day,bayno,timespan,state,timestamp,MedicineFlag) values (%d,'%@',%.1f,%d,'%@','%@','%@',0,'Y',1)",selctedMedId,selectedMedName,selectedPillQty,objUser.userId,[arrayDay objectAtIndex:i],(int)[arrayNoon objectAtIndex:i],strSelectedMedTimeSpan];
            NSLog(@"%@",queryString);
               
            
            [classDatabaseOperations add:queryString];
           }
            else
            {
                 objUser.audioStatus=NO;
                
                if( audioflag==1)
                {
                    // objUser.audioStatus=YES;
                    
                    
                    if(objUser.language== 1)
                    {
                        NSMutableArray* array=[[NSMutableArray alloc] init];
                        [array addObject:@"AftDup"];
                        [self.myAudioPlayer playAudios:array];
                        [array release];
                    }
                    
                    
                    else if(objUser.language== 2)
                    {
                        NSMutableArray* array=[[NSMutableArray alloc] init];           
                      //  [array addObject:@"NoonPresent"];
                       // [self.myAudioPlayer playAudios:array];
                        [array release];
                    }
                    
                    
                }   

                NSLog(@"Hello Good Afternoon");
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:[NSString stringWithFormat:@"Afternoon Compartment Already Has '%@'.Do You Want To Continue? ",selectedMedicine.medicineName] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"Continue" , nil];
                  alert.tag=111;
                [alert show];
                [alert release];
                MedFlag=2;
                
                return;

            }
            

            
            
        }
        
        else if([strSelectedMedTimeSpan isEqualToString:@"Evening"])
        {
            NSString *query=[NSString stringWithFormat:@"select distinct(MedicineFlag) from takemedicine where medicineid=%d and medicinename='%@'and userid=%d and timespan='%@'and bayno='%@'",selctedMedId,selectedMedName,objUser.userId,strSelectedMedTimeSpan,(int)[arrayEvening objectAtIndex:i]];
            int result=[classDatabaseOperations get:query];
            NSLog(@"medflag3 %d",result);
            

             prescQty=selectedPillQty;
            
            ///-----------
            if(result==0)
            {
                MedFlag=0;

            NSString * queryString=[NSString stringWithFormat:@"insert into takemedicine (medicineid,medicinename,medqty,userid,day,bayno,timespan,state,timestamp,MedicineFlag) values (%d,'%@',%.1f,%d,'%@','%@','%@',0,'Y',1)",selctedMedId,selectedMedName,selectedPillQty,objUser.userId,[arrayDay objectAtIndex:i],(int)[arrayEvening objectAtIndex:i],strSelectedMedTimeSpan];
            NSLog(@"%@",queryString);
            
            
            [classDatabaseOperations add:queryString];
            }
            else
            {
                 objUser.audioStatus=NO;   
                if( audioflag==1)
                {
                    // objUser.audioStatus=YES;
                    
                    
                    if(objUser.language== 1)
                    {
                        NSMutableArray* array=[[NSMutableArray alloc] init];
                        [array addObject:@"EvenDup"];
                        [self.myAudioPlayer playAudios:array];
                        [array release];
                    }
                    
                    
                    else if(objUser.language== 2)
                    {
                        NSMutableArray* array=[[NSMutableArray alloc] init];           
                      //  [array addObject:@"EvenPresent"];
                      //  [self.myAudioPlayer playAudios:array];
                        [array release];
                    }
                    
                    
                }   

                NSLog(@"Hello Good Evening");
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:[NSString stringWithFormat:@"Evening Compartment Already Has '%@'.Do You Want To Continue? ",selectedMedicine.medicineName]                                                   delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"Continue" , nil];
                  alert.tag=112;
                [alert show];
                [alert release];
                MedFlag=3;
                return;
                

            }
            
            
        }
    
        else if([strSelectedMedTimeSpan isEqualToString:@"Night"])
        {
            NSString *query=[NSString stringWithFormat:@"select distinct(MedicineFlag) from takemedicine where medicineid=%d and medicinename='%@'and userid=%d and timespan='%@' and bayno='%@'",selctedMedId,selectedMedName,objUser.userId,strSelectedMedTimeSpan,(int)[arrayNight objectAtIndex:i]];
            int result=[classDatabaseOperations get:query];
            NSLog(@"medflag4 %d",result);
             prescQty=selectedPillQty;  
            //-------------
            if(result==0)
            {
            
                MedFlag=0;
            NSString * queryString=[NSString stringWithFormat:@"insert into takemedicine (medicineid,medicinename,medqty,userid,day,bayno,timespan,state,timestamp,MedicineFlag) values (%d,'%@',%.1f,%d,'%@','%@','%@',0,'Y',1)",selctedMedId,selectedMedName,selectedPillQty,objUser.userId,[arrayDay objectAtIndex:i],(int)[arrayNight objectAtIndex:i],strSelectedMedTimeSpan];
            NSLog(@"%@",queryString);
            
            
            [classDatabaseOperations add:queryString];
            }
            else
            {
                 objUser.audioStatus=NO;
                if( audioflag==1)
                {
                    // objUser.audioStatus=YES;
                    
                    
                    if(objUser.language== 1)
                    {
                        NSMutableArray* array=[[NSMutableArray alloc] init];
                        [array addObject:@"NightDup"];
                        [self.myAudioPlayer playAudios:array];
                        [array release];
                    }
                    
                    
                    else if(objUser.language== 2)
                    {
                        NSMutableArray* array=[[NSMutableArray alloc] init];           
                       // [array addObject:@"NightPresent"];
                        //[self.myAudioPlayer playAudios:array];
                        [array release];
                    }
                    
                    
                }   

                NSLog(@"Hello Good Night"); 
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:[NSString stringWithFormat:@"Night Compartment Already Has '%@'.Do You Want To Continue? ",selectedMedicine.medicineName]  delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"Continue" , nil];
                  alert.tag=113;
                [alert show];
                [alert release];
                MedFlag=4;
                return;

            }
            
            
            
        }
    
    
    
    
    
    }
    
    
    
    
    
    
    
}

-(void)methodFillBoxInDatabaseAgain
{
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd-MM-yyyy HH:mm"];
    
    NSString *date =[df stringFromDate:myDate];
    
    NSLog(@"date %@",date);
    [df release ];     
    
    
    
    NSArray * arrayDay=[NSArray arrayWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
    
    NSArray * arrayMorning=[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
    
     
   for(int i=0;i<7;i++)
    {
        
        
         { 
             
             
             NSString *query=[NSString stringWithFormat:@"select distinct(medqty) from takemedicine where medicineid=%d and medicinename='%@' and userid=%d and day='%@'and timespan='Morning' ", selctedMedId,selectedMedName,objUser.userId,[arrayDay objectAtIndex:i]];
             
            
             float medqty=[classDatabaseOperations get:query];
             
             float newmedqty=(medqty+prescQty);
            
             
             NSString *query1=[NSString stringWithFormat:@"update takemedicine set medqty=%.1f where medicineid=%d and medicinename='%@' and userid=%d and day='%@' and timespan='Morning' and bayno='%@'",newmedqty,selctedMedId,selectedMedName,objUser.userId,[arrayDay objectAtIndex:i],(int)[arrayMorning objectAtIndex:i]];; 
             
             [classDatabaseOperations add:query1];
           
           
            
                        
            
            
        }
        
               
        
        
        
        
    }
    
    

}

-(void)methodFillBoxInDatabaseAgainNoon
{
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd-MM-yyyy HH:mm"];
    
    NSString *date =[df stringFromDate:myDate];
    
    NSLog(@"date %@",date);
    [df release ];     
    
    
    
    NSArray * arrayDay=[NSArray arrayWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
    
    NSArray * arrayNoon=[NSArray arrayWithObjects:@"8",@"9",@"10",@"11",@"12",@"13",@"14",nil];
    
        

    
    
    for(int i=0;i<7;i++)
    {
        
        
        {
            NSString *query=[NSString stringWithFormat:@"select distinct(medqty) from takemedicine where medicineid=%d and medicinename='%@' and userid=%d and day='%@'and timespan='Afternoon'", selctedMedId,selectedMedName,objUser.userId,[arrayDay objectAtIndex:i]];
            
            float medqty=[classDatabaseOperations get:query];
            
            float newmedqty=(medqty+prescQty);
                      
            NSString *query1=[NSString stringWithFormat:@"update takemedicine set medqty=%.1f where medicineid=%d and medicinename='%@' and userid=%d and day='%@' and timespan='Afternoon' and bayno='%@'",newmedqty,selctedMedId,selectedMedName,objUser.userId,[arrayDay objectAtIndex:i],(int)[arrayNoon objectAtIndex:i]]; 
            
            [classDatabaseOperations add:query1];
            
         
            
                       
            
            
        }
        
        
        
        
        
        
    }
    
    
    
}

-(void)methodFillBoxInDatabaseAgainEvening
{
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd-MM-yyyy HH:mm"];
    
    NSString *date =[df stringFromDate:myDate];
    
    NSLog(@"date %@",date);
    [df release ];     
    
    
    
    NSArray * arrayDay=[NSArray arrayWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
    
    NSArray * arrayEvening=[NSArray arrayWithObjects:@"15",@"16",@"17",@"18",@"19",@"20",@"21",nil];
    
  

    
    
    for(int i=0;i<7;i++)
    {
        
        
        {
            NSString *query=[NSString stringWithFormat:@"select distinct(medqty) from takemedicine where medicineid=%d and medicinename='%@' and userid=%d and day='%@'and timespan='Evening'", selctedMedId,selectedMedName,objUser.userId,[arrayDay objectAtIndex:i]];
            
          
            float medqty=[classDatabaseOperations get:query];
            
            float newmedqty=(medqty+prescQty);
           
            
            NSString *query1=[NSString stringWithFormat:@"update takemedicine set medqty=%.1f where medicineid=%d and medicinename='%@' and userid=%d and day='%@' and timespan='Evening' and bayno='%@'",newmedqty,selctedMedId,selectedMedName,objUser.userId,[arrayDay objectAtIndex:i],(int)[arrayEvening objectAtIndex:i]]; 
            
            [classDatabaseOperations add:query1];
            
            
            
            
            
            
        
            
            
        }
        
        
        
        
        
        
    }
    
    
    
}


-(void)methodFillBoxInDatabaseAgainNight
{
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd-MM-yyyy HH:mm"];
    
    NSString *date =[df stringFromDate:myDate];
    
    NSLog(@"date %@",date);
    [df release ];     
    
        
    NSArray * arrayDay=[NSArray arrayWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
    
     NSArray * arrayNight=[NSArray arrayWithObjects:@"22",@"23",@"24",@"25",@"26",@"27",@"28",nil];
    
    
    for(int i=0;i<7;i++)
    {
        
        
        {
            
            
            NSString *query=[NSString stringWithFormat:@"select distinct(medqty) from takemedicine where medicineid=%d and medicinename='%@' and userid=%d and day='%@'and timespan='Night'", selctedMedId,selectedMedName,objUser.userId,[arrayDay objectAtIndex:i]];
            
              float medqty=[classDatabaseOperations get:query];
           
            float newmedqty=(medqty+prescQty);
                       
            NSString *query1=[NSString stringWithFormat:@"update takemedicine set medqty=%.1f where medicineid=%d and medicinename='%@' and userid=%d and day='%@' and timespan='Night' and bayno='%@'",newmedqty,selctedMedId,selectedMedName,objUser.userId,[arrayDay objectAtIndex:i],(int)[arrayNight objectAtIndex:i]]; 
            
            [classDatabaseOperations add:query1];
            
           

            
            
            
            
            
    
            
            
        }
        
        
        
        
        
        
    }
    
    
    
}














@end
