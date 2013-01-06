//
//  classTakePill.m
//  PillBoxOffline
//
//  Created by Avi Kulkarni on 11/16/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classTakePill.h"


#import "classCompartmentSelection.h"
#import "classDatabaseOperations.h"
#import "classUser.h"
#import "classCompartmentData.h"
#import "classBayMedicationList.h"
#import "classLog.h"
#import "ClassRefillMedicine.h"
#import "classMedicine.h"
#import "classMedicineTime.h"
#import "classRefillingOption.h"
#import "classAudio.h"
#import "classLogm.h"

#define morning 1
#define afternoon 2
#define evening 3
#define night 4



@implementation classTakePill
@synthesize imgFirstTic;
@synthesize imgSecTic;
@synthesize imgThirdTic;
@synthesize btnPrev;
@synthesize lblpage;
@synthesize btnNext;
@synthesize lblTotalMedicine;
@synthesize lblMedQty;
@synthesize lblMedName;
@synthesize lblDay;
@synthesize lblPillsQty;
@synthesize lblSpan;
@synthesize strTimeSpan;
@synthesize objCompartment;
@synthesize arrayButton;
@synthesize bayno;
@synthesize userid;
@synthesize arrayMedName;
@synthesize myView;

@synthesize viewFirst;
@synthesize viewSec;
@synthesize viewFourth;
@synthesize viewThird;
@synthesize pagecreated;
@synthesize objUser;
@synthesize objMedicine;
@synthesize myAudioPlayer;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title =@"Take Medicine";
    }
    return self;
}

- (void)dealloc
{
    [lblDay release];
    [lblSpan release];
    [lblMedName release];
    [lblMedQty release];
    [scrollView release];
    [myView release];
    [lblPillsQty release];
    [lblTotalMedicine release];
    [btnCompatrment release];
    [btnNext release];
    [btnPrev release];
    [lblpage release];
    [imgFirstTic release];
    [imgSecTic release];
    [imgThirdTic release];
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
    
    if(self.objUser.audioStatus==YES)
    {
        if(self.objUser.language==1)
        {
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"tapbox"];
            
            [self.myAudioPlayer playAudios:array];
            [array release];
        }
        
        else if(self.objUser.language==2)
        {
            
            NSMutableArray * array=[[NSMutableArray alloc] init];
            [array addObject:@"2TapBoxTakeMed"];
            
            [self.myAudioPlayer playAudios:array];
            [array release];
            
            
        }
        
    }

//    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Take Medicine " message:@"Tap Box to take Medicine " Delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Take Medicine " message:@"Tap Box to take Medicine " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    
    
    
    alert.tag=100;
    

    [alert show];
    [alert release];
        
    viewFirst.hidden=YES;
    viewSec.hidden=YES;
    viewThird.hidden=YES;
    viewFourth.hidden=YES;
      btnNext.hidden=YES;
    btnPrev.hidden=YES;
    
    
    //btnCompatrment.backgroundColor=[UIColor grayColor];
    
    myView.hidden=YES;
    
    //[self.view addSubview:myView];
    

   // [myView addSubview:scrollView];
    
    UIBarButtonItem *rightbtn =[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem=rightbtn;
    UIBarButtonItem *leftbtn =[[UIBarButtonItem alloc]initWithTitle:@"Medicine List" style:UIBarButtonItemStyleDone target:self action:@selector(methodMedList)];
    self.navigationItem.leftBarButtonItem=leftbtn;
    

    
    
    NSDate *date =[NSDate date];
    NSDateFormatter *df1 = [NSDateFormatter new];
    [df1 setDateFormat:@"EEEE"];  
    strDay=[df1 stringFromDate:date];
    lblDay.text=strDay;
    
    [self timespan];
    arrayMed=[classDatabaseOperations getBayMedicineListForUser:userid :bayno];
    pagecreated=[arrayMed count]/3;

    if([arrayMed count]%3==0)
    {
        pagecreated=[arrayMed count]/3;
        
    
    }
    else
    {
        
        
        
        
        pagecreated=pagecreated+1;
        
         // NSLog(@"%d",pagecreated);
        
    }
  
     NSLog(@" page %d",pagecreated);
    //[self buttonCreatedAnimatically];
    [self print];
    
    
    [self displyCompartment:bayno];

    
}
- (void)viewDidUnload
{
    [self setLblDay:nil];
    [self setLblSpan:nil];
    [self setLblMedName:nil];
    [self setLblMedQty:nil];
    [scrollView release];
    scrollView = nil;
    [myView release];
    myView = nil;
    [self setLblPillsQty:nil];
    [self setLblTotalMedicine:nil];
    [btnCompatrment release];
    btnCompatrment = nil;
    [self setBtnNext:nil];
    [self setBtnPrev:nil];
    [self setLblpage:nil];
    [self setImgFirstTic:nil];
    [self setImgSecTic:nil];
    [self setImgThirdTic:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)done
{
        
    [self dismissModalViewControllerAnimated:YES];
    
}



-(void)print
{
    for(classCompartmentData *aMedicine in arrayMed) 
    {
        
        //lblMedName.text=aMedicine.bayMedName;
        //lblMedQty.text=[aMedicine.bayMedQty]myFloatLabel.text = [NSString stringWithFormat:@"$%3.2f", [self.floatValue floatValue]]
        //lblMedQty.text = [NSString stringWithFormat:@"%.1f",aMedicine.bayMedQty];
        NSLog(@"%@",aMedicine.bayMedName);
        NSLog(@"%.1f",aMedicine.bayMedQty);
    }
    
      
    
    NSString *query=[NSString stringWithFormat:@"select sum (medqty) from takemedicine where bayno=%d and userid=%d ",bayno,userid];
    NSLog(@"%@",query);
    float result=[classDatabaseOperations get:query];
    
    
    
    NSString *query1=[NSString stringWithFormat:@"select count (medicinename) from takemedicine where bayno=%d and userid=%d ",bayno,userid];
    NSLog(@"%@",query1);
    float result1=[classDatabaseOperations get:query1];
    
    
    lblTotalMedicine.text=[NSString stringWithFormat:@"%.1f ",result1];
    
    lblPillsQty.text=[NSString stringWithFormat:@"%.1f",result];

    
    if(result==0 && result1 ==0)
    {
        
        
        UILabel *msg=[[UILabel alloc]initWithFrame:CGRectMake(20, 200, 250, 50)];
        msg.text=@"All Pills Taken Successfully !!! ";
        [self.view addSubview:msg];
        btnCompatrment.enabled=NO;
        btnCompatrment.hidden=YES;
        lblDay.hidden=YES;
        lblSpan.hidden=YES;
        
    
    
    }
    
    
    
        
    
    
    
}

-(void)timespan
{
    
    
    int i;
    
    i=[classCompartmentSelection timeSpanInInteger];
    
    if(i==1)
        
    {
        lblSpan.text=@"Morning";
        
    }
    
    if(i==2)
        
    {
        lblSpan.text=@"Afternoon";
        
    }
    if(i==3)
        
    {
        lblSpan.text=@"Evening";
        
    }
    if(i==4)
        
    {
        lblSpan.text=@"Night";
        
    }

    
     
    
}





//-(void)buttonCreatedAnimatically
//{
//    
//    
//    
//    int i=0;
//    for(classCompartmentData *aMedicine in arrayMed) 
//     {
//         /*       if(aMedicine.state==0)
//       {
//         if(i==0)
//         {
//             [aButton setBackgroundImage:[UIImage imageNamed:@"tab4.png"] forState:UIControlStateNormal];
//         }
//        else if(i==1)
//         {
//             [aButton setBackgroundImage:[UIImage imageNamed:@"tab3.png"] forState:UIControlStateNormal];
//         }
//         
//         else if(i==2)
//         {
//             [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
//         }
//         
//         else if(i==3)
//         {
//             [aButton setBackgroundImage:[UIImage imageNamed:@"tab2.png"] forState:UIControlStateNormal];
//         }
//         
//         else
//         {   
//             if(i%2)
//             {
//                 [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
//        
//             }    
//
//             else
//             {
//        [aButton setBackgroundImage:[UIImage imageNamed:@"tab2.png"] forState:UIControlStateNormal];
//        
//             }
//    
//    
//         }
//       
//         
//                   
//           
//           
//           
//           
//           
//           
//       }
//          
//          else
//          {
//          aButton.enabled=NO;
//          UIImage *newPressedImage = [UIImage imageNamed:@"tic.png"];
//          [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
//          
//          }*/
//                  
//         
//         
//         
//        // NSString *name=aMedicine.bayMedName ;
//         
//         
//         
//         if(i%2==0)
//         
//         {
//         
//         UIButton* aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//         aButton.frame = CGRectMake(10.0+i*80, 30.0, 90.0, 40.0);
//                         
//        NSString *qty=[NSString stringWithFormat:@"%.1f",aMedicine.bayMedQty];
//
//         
//         UILabel *lblName=[[UILabel alloc]initWithFrame:CGRectMake(10.0+i*80, 70.0, 90.0, 40.0)];
//         
//         UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10.0+i*80, 100.0, 90.0, 40.0)];
//         
//         lblName.text=[NSString stringWithFormat:@"%@",aMedicine.bayMedName];
//         lblQty.text=[NSString stringWithFormat:@"Qty %@",qty];
//         lblQty.textColor=[UIColor purpleColor];
//         
//         [aButton setTitle:aMedicine.bayMedName forState:UIControlStateNormal]; 
//        [aButton setBackgroundImage:[UIImage imageNamed:@"tab4.png"] forState:UIControlStateNormal];
//             aButton.titleLabel.hidden=YES;
//         [aButton setTag:i];
//         [lblName setTag:i];
//         [arrayMedName insertObject:lblName.text atIndex:i];
//         [lblQty setTag:i];
//         [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
//             
//             
//             if(aMedicine.state==0)
//             {
//             [aButton setBackgroundImage:[UIImage imageNamed:@"tab4.png"] forState:UIControlStateNormal];
//
//             
//                 
//             }
//             else
//             {
//                 aButton.enabled=NO;
//                 UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                 [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
//                 
//             }           
//             
//             
//             
//             
//             
//         
//       // [scrollView addSubview:img];
//         [scrollView addSubview:aButton];
//         [scrollView addSubview:lblQty];
//         [scrollView addSubview:lblName];
//         
//         }
//         
//         
//      else
//      {
//          UIButton* aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//          aButton.frame = CGRectMake(i*80-70, 25.0+(i%2)*130, 90.0, 40.0);
//          
//          NSString *qty=[NSString stringWithFormat:@"%.1f",aMedicine.bayMedQty];
//          
//          
//          UILabel *lblName=[[UILabel alloc]initWithFrame:CGRectMake(i*80-70, 65.0+(i%2)*130, 90.0, 40.0)];
//          
//          UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(i*80-70, 100.0+(i%2)*130, 90.0, 40.0)];
//          
//          lblName.text=[NSString stringWithFormat:@"%@",aMedicine.bayMedName];
//          lblQty.text=[NSString stringWithFormat:@"Qty %@",qty];
//          lblQty.textColor=[UIColor purpleColor];
//          //[aButton setBackgroundImage:[UIImage imageNamed:@"tab3.png"] forState:UIControlStateNormal];        
//          [aButton setTitle:aMedicine.bayMedName forState:UIControlStateNormal]; 
//          
//          aButton.titleLabel.hidden=YES;
//          [aButton setTag:i];
//          [lblName setTag:i];
//          [arrayMedName insertObject:lblName.text atIndex:i];
//          [lblQty setTag:i];
//          [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
//          
//                  
//          
//          if(aMedicine.state==0)
//          {
//              [aButton setBackgroundImage:[UIImage imageNamed:@"tab3.png"] forState:UIControlStateNormal];
//              
//              
//              
//          }
//          else
//          {
//              aButton.enabled=NO;
//              UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//              [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
//              
//          }                     
//          
//          
//          
//          
//          
//          
//          
//          
//          
//          
//          
//          // [scrollView addSubview:img];
//          [scrollView addSubview:aButton];
//          [scrollView addSubview:lblQty];
//          [scrollView addSubview:lblName];
//          
//          
//          
//          
//          
//          
//          
//      }
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             NSLog(@"called");
//             i++; 
//             
//             
//             
//            // [arrayButton addObject:aButton]; 
//             
//        
//             
//}
//    NSLog(@"value i %d",i);
//   
//    scrollView.contentSize = CGSizeMake(90*i,scrollView.frame.size.height);
//        
//    
//    
////    for(classCompartmentData *aMedicine in arrayMed) 
////
////    {
////        
////        
////        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(10.0+i*152, 65.0, 50.0, 50.0)];
////        if(i==0){
////            img.image=[UIImage imageNamed:@"tab1.png"];
////            
////        }
////        
////        
////        if(i==1)
////        {
////            img.image = [UIImage imageNamed:@"tab2.png"];
////            
////        }
////        if(i==2)
////        {
////            img.image = [UIImage imageNamed:@"tab3.png"];
////            
////        }
////
////        if(i==3)
////        {
////            img.image = [UIImage imageNamed:@"tab4.png"];
////            
////        }
////
////        
////        [scrollView addSubview:img];
////        
////        
////    }
//    
//    
//    
//    
//    
//}
//
//







- (IBAction)MethodanimateView:(id)sender 
{
    btnCompatrment.enabled=NO;
    
      [self createViews];
    [self methodAddSubViews];
  
    
    
    
//    btnCompatrment.enabled=NO;
//    
//    myView.hidden=NO;
//   
//   [ myView addSubview:scrollView];
//
//    
//    [self.view addSubview:myView];
//    
//    
//
//
//    
//    [UIView beginAnimations:@"MethodanimateView" context:NULL];
//    [UIView setAnimationDuration:0.8];	
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.myView cache:YES];	
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.myView cache:YES];	
//    
//    [UIView commitAnimations];
    
    
}



-(void)methodMedicineTaken:(UIButton *)aButton :(UILabel *)lbl:(UILabel *)lblQty
{
    NSLog(@"Called");
    
    //int i =[arrayMed count];
//&& (lblMName.tag==i) && (lblMQty.tag ==i)    
    for (int i=0 ; i<[arrayMed count]; i++) 
    {
        
    
    if(aButton.tag == i )
    {
        
        if(i==0||i==3||i==6||i==9||i==12||i==15)
        {
            
            imgFirstTic.hidden=NO;   
            [viewFirst addSubview:imgFirstTic];
            
        
        }
        
        if(i==1||i==4||i==7||i==10||i==13||i==16)
        {
            
            imgSecTic.hidden=NO;   
            [viewSec addSubview:imgSecTic];
            
            
        }
        
        if(i==2||i==5||i==8||i==11||i==14||i==17)
        {
            
            imgThirdTic.hidden=NO;   
            [viewThird addSubview:imgThirdTic];
            
            
        }
        

        
        
        
        
        
        aButton.enabled=NO;
//        UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//        [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
       // NSString *strMedname=[NSString stringWithFormat:@"%@",[arrayMedName objectAtIndex:i]];
    
        classCompartmentData *objMed=[arrayMed objectAtIndex:i];
        
        
        NSString *strMedname=objMed.bayMedName;
        
        NSLog(@"NAME %@ ,%d",strMedname,i);
        
        [classDatabaseOperations updateTakeMedicine:objUser.userId :bayno :strMedname];

  
        
        
        
        //[classDatabaseOperations updateQuantityTakenForMedicine:[lblMQty.text floatValue] forDoseNumber:2 forMemberId:userid byQyantity:<#(float)#>]
        
        int i=[classCompartmentSelection timeSpanInInteger];
        
 //  [classDatabaseOperations updateQuantityTakenForMedicine:objMed.medicineID forDoseNumber:i forMemberId:@"NULL" byQyantity:objMed.bayMedQty];
        
        
        
        
        
        
        
        NSDateFormatter * dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];       
        NSString * currentDate=[dateFormatter stringFromDate:[NSDate date]];   
        
        NSString * query=[NSString stringWithFormat:@"insert into dailylog (medicineid,doseNumber,quantitytaken,date,userid) values (%d,%d,%.1f, '%@', %d)",objMed.medicineID,i,objMed.bayMedQty,currentDate,userid];
        [classDatabaseOperations add:query];
                
       
        
        // also save log in all log table, this contain all days transactions
        classLogm * aLog=[[classLogm alloc]init] ;
        
        // set userId
        aLog.userId=userid;
        
        // set username
        NSString * userName=[NSString stringWithFormat:@"%@ %@",objUser.firstName,objUser.lastName];
        //NSLog(@"%@",userName);
        
        aLog.memberName=userName;
        aLog.medicineId=objMed.medicineID;
        aLog.medicineName=objMed.bayMedName;
        aLog.doseNumber=i;
        aLog.quantityTaken=objMed.bayMedQty;
        
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd h:mm:00 a"];       
        NSString * currentDateTime=[dateFormatter stringFromDate:[NSDate date]];
        
        [dateFormatter release];
        // current Time          
        aLog.datetime=currentDateTime;
        
        // create query
        NSString * queryString=[NSString stringWithFormat:@"insert into log (userid,membername,medicineid,medicinename,quantitytaken,dosenumber,datetime) values (%d,'%@',%d,'%@',%.1f,%d,'%@')",aLog.userId,aLog.memberName,aLog.medicineId,aLog.medicineName,aLog.quantityTaken,aLog.doseNumber,aLog.datetime];
        [classDatabaseOperations add:queryString];
        
        [aLog release];
        
        
        
        
        NSString *query1=[NSString stringWithFormat:@"select medicinetotalpillquantity from medicine where userid=%d and medicineid=%d",objUser.userId,objMed.medicineID];
        
        float qty =[classDatabaseOperations get:query1];
        
        objMedicine=[[classMedicine alloc]init];
        objMedicine.totalPillQuantity=qty;
        
        objMedicine.medicineSequenceId=objMed.medicineID;
        
        [self decrementTotalQuantity:objMedicine :objMed.bayMedQty];
        [self checkReoderLevel];
        
        
        
        
        
        
        
        [objMed release];
    }   
        
     
    }
    
    
    
    
}



-(void)createViews  
{  
    //[self methodAddSubViews];
    
    [self.view addSubview:viewFirst];
    
    [self.view addSubview:viewSec];
    
    [self.view addSubview:viewThird];
    
   // [self.view addSubview:viewFourth];
    
//    viewFirst.hidden=YES;
//    viewSec.hidden=YES;
//    viewThird.hidden=YES;
//    viewFourth.hidden=YES;
    
    
    
    CGPoint position;
    position=viewFirst.center;
    position.x=160;
    position.y=410;
    self.viewFirst.center=position;
    //[UIView beginAnimations:@"viewFirst" context:nil];
    //[UIView setAnimationDuration:1];
    [UIView beginAnimations:@"viewFirst" context:NULL];
    [UIView setAnimationDuration:1.0];	
    //[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.viewFirst cache:YES];   
    position.x=160;
    position.y=153;        
    self.viewFirst.center=position;
    [UIView commitAnimations];
    
    CGPoint position1;
    position1=viewSec.center;
    position1.x=160;
    position1.y=410;
    self.viewSec.center=position1;
    
    //[UIView beginAnimations:@"viewSec" context:nil];
    //[UIView setAnimationDuration:0.8];
    [UIView beginAnimations:@"viewSec" context:NULL];
    [UIView setAnimationDuration:1.8];	
    //[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.viewSec cache:YES];   
    position1.x=68;
    position1.y=272;        
    self.viewSec.center=position1;
    [UIView commitAnimations];
    
    
    CGPoint position2;
    position2=viewThird.center;
    position2.x=160;
    position2.y=410;
    self.viewThird.center=position2;
    
    //[UIView beginAnimations:@"viewThird" context:nil];
    //[UIView setAnimationDuration:0.8];
    [UIView beginAnimations:@"viewThird" context:NULL];
    [UIView setAnimationDuration:2.5];	
    //[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.viewThird cache:YES]; 
    position2.x=255;
    position2.y=272;        
    self.viewThird.center=position2;
    [UIView commitAnimations];
    
    
    
//    CGPoint position3;
//    position3=viewFourth.center;
//    position3.x=160;
//    position3.y=410;
//    self.viewFourth.center=position3;
//    //[UIView beginAnimations:@"viewFourth" context:nil];
//    //[UIView setAnimationDuration:0.8];
//    [UIView beginAnimations:@"viewFourth" context:NULL];
//    [UIView setAnimationDuration:3.5];	
//    //[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.viewFourth cache:YES];
//    position3.x=245;
//    position3.y=268;        
//    self.viewFourth.center=position3;
//    [UIView commitAnimations];
    
}

-(void)methodAddSubViews
{
    int i=0;
    btnPrev.hidden=YES;
    
    [self clearView];    

    
  lblpage.text=[NSString stringWithFormat: @"Page No. 1/%d",pagecreated];
    
    viewFirst.backgroundColor = [UIColor whiteColor];
    viewSec.backgroundColor = [UIColor whiteColor];
    viewThird.backgroundColor = [UIColor whiteColor];
   // viewFourth.backgroundColor = [UIColor whiteColor];    
    
    for(classCompartmentData *aMedicine in arrayMed) 
    {
        
        if(i==0)
        {            
            viewFirst.hidden=NO;

            
            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            
//            UILabel * lblNO=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 20, 30)];
//            lblNO.text=@"1";
                    
            
            aButton.frame=CGRectMake(10, 20, 80, 40);
            //aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
           // [aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal]; 
            aButton.titleLabel.hidden=YES;
            
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            

            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",aMedicine.bayMedQty];

            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            lblQty.text=qty;
            
            
           // [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            aButton.tag=i;
            lblQty.tag=i;
            lbl.tag=i;
            [viewFirst addSubview:lbl];
            [viewFirst addSubview:lblQty];
          //  [viewFirst addSubview:lblNO];
            [viewFirst addSubview:aButton];
            //[arrayButton addObject:aButton];
       
            [viewFirst addSubview:imgFirstTic];
            
            if(aMedicine.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"janumet.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"janumet.png"] forState:UIControlStateDisabled];

                [viewFirst addSubview:imgFirstTic];
                imgFirstTic.hidden=NO;
                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setImage:newPressedImage forState:UIControlStateDisabled];
//                
            }           
            
        
        
        
        
        }
        
    
        
        
        else if(i==1)
        {
            
            viewSec.hidden=NO;

            
            
            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);            //aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
            //[aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",aMedicine.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            lblQty.text=qty;
            // [aButton setBackgroundImage:[UIImage imageNamed:@"tab2.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            aButton.tag=i;
            lblQty.tag=i;
            lbl.tag=i;
            [viewSec addSubview:lbl];
            [viewSec addSubview:lblQty];
            
            [viewSec addSubview:aButton];
          
            
            
            
            
            if(aMedicine.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"lipitor.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"lipitor.png"] forState:UIControlStateDisabled];

                imgSecTic.hidden=NO;
                [viewSec addSubview:imgSecTic]; 

                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
                
            }           
            

            
            
            
        }
        
        else if(i==2)
        {
            
            
            
            viewThird.hidden=NO;

            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);          //  aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
            //   [aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",aMedicine.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            lblQty.text=qty;
            
            //[aButton setBackgroundImage:[UIImage imageNamed:@"tab3.png"] forState:UIControlStateNormal];
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            aButton.tag=i;
            
            lblQty.tag=i;
            lbl.tag=i;
            [viewThird addSubview:lbl];
            [viewThird addSubview:lblQty];
            
            [viewThird addSubview:aButton];
            
            if(aMedicine.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"Zocor.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                
                [aButton setBackgroundImage:[UIImage imageNamed:@"Zocor.png"] forState:UIControlStateDisabled];

                imgThirdTic.hidden=NO;
                [viewThird addSubview:imgThirdTic]; 
                
                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
                
            }           
            

            
            
            
            
            
        }
                
        else if(i>=3)
        {
            NSLog(@"called Btn ");
            
            btnNext.hidden=NO;
            
        [btnNext addTarget:self action:@selector(nexmedlist) forControlEvents:UIControlEventTouchUpInside];            
            
                       
        }
        
        i++;
        
    }
    
    
    
}

-(void)nexmedlist
{
    [self clearView];    

    lblpage.text=[NSString stringWithFormat: @"Page No. 2/%d",pagecreated];

    
    viewFirst.hidden=YES;
    viewSec.hidden=YES;
    viewThird.hidden=YES;
    viewFourth.hidden=YES;
    btnNext.hidden=YES;
    btnPrev.hidden=NO;

   [btnPrev addTarget:self action:@selector(methodAddSubViews) forControlEvents:UIControlEventTouchUpInside];        

    
    
    for (int i=3; i<[arrayMed count]; i++) 
    {
        
        if(i==3)
        {            
            viewFirst.hidden=NO;

            
            
            
            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);
            //aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
           // [aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
            //[aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",obj.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            lblQty.text=qty;
            
            
            lblQty.tag=i;
            lbl.tag=i;
          
            [viewFirst addSubview:lblQty];
            
            
            
            aButton.tag=i;
            
              [viewFirst addSubview:lbl];
            
            [viewFirst addSubview:aButton];
            
            
            if(obj.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateDisabled];

                
                [viewFirst addSubview:imgFirstTic];
                imgFirstTic.hidden=NO;

                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
                
            }           
            

            
            
            
            
            
            
            
            
            //[arrayButton addObject:aButton];
        }
        
        
        else if(i==4)
        {
            
            
            viewSec.hidden=NO;

            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);            //aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
          //  [aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
           // [aButton setBackgroundImage:[UIImage imageNamed:@"tab3.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            aButton.tag=i;
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",obj.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            
             lblQty.text=qty;
            
            [viewSec addSubview:lbl];
            lblQty.tag=i;
            lbl.tag=i;
            
            [viewSec addSubview:lblQty];
            
            [viewSec addSubview:aButton];
            
            
            if(obj.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab3.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                
                imgSecTic.hidden=NO;
                [viewSec addSubview:imgSecTic]; 
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab3.png"] forState:UIControlStateDisabled];
                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
                
            }           
            

            
            
            
            
        }
        
        else if(i==5)
        {
            
            
            
            
            viewThird.hidden=NO;

            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);          //  aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
           // [aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
            
           // [aButton setBackgroundImage:[UIImage imageNamed:@"tab4.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            aButton.tag=i;
            
            
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",obj.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            
            lblQty.text=qty;
            [viewThird addSubview:lbl];
            lblQty.tag=i;
            lbl.tag=i;

            
            [viewThird addSubview:lbl];
            
            [viewThird addSubview:aButton];
            
            if(obj.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab4.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                
                imgThirdTic.hidden=NO;
                [viewThird addSubview:imgThirdTic]; 
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab4.png"] forState:UIControlStateDisabled];


                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
                
            }           
            

            
            
            
            
            
        }
        
                   
            
            
            
            
        
        
        else if(i>=6)
        {
            NSLog(@"called Btn ");
            
            btnNext.hidden=NO;
            
            [btnNext addTarget:self action:@selector(nexmedlist2) forControlEvents:UIControlEventTouchUpInside];          
           /// [btnPrev addTarget:self action:@selector(methodAddSubViews) forControlEvents:UIControlEventTouchUpInside];
        
        }
        
        
        
    }
    
    
    
    
    [self createViews];    
    
    
    
    
    
    
    
}

-(void)nexmedlist2
{
   
    [self clearView];    
    lblpage.text=[NSString stringWithFormat: @"Page No. 3/%d",pagecreated];

    
    [btnPrev addTarget:self action:@selector(nexmedlist) forControlEvents:UIControlEventTouchUpInside];        

    
    viewFirst.backgroundColor = [UIColor whiteColor];
    viewSec.backgroundColor = [UIColor whiteColor];
    viewThird.backgroundColor = [UIColor whiteColor];
    viewFourth.backgroundColor = [UIColor whiteColor];

    
    
    viewFirst.hidden=YES;
    viewSec.hidden=YES;
    viewThird.hidden=YES;
    viewFourth.hidden=YES;
    
    
    
    
    
    
    
    
    
    
    
    for (int i=6; i<[arrayMed count]; i++) 
    {
        
                
        
        
        if(i==6)
        {            
            viewFirst.hidden=NO;

            
            
            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);
            //aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
         //   [aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
          //  [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",obj.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            
            lblQty.text=qty;

            
            [viewFirst addSubview:lblQty];
            [viewFirst addSubview:lbl];
            lblQty.tag=i;
            lbl.tag=i;

            
            aButton.tag=i;
            
            
            
            [viewFirst addSubview:aButton];
            
            
            
            if(obj.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateDisabled];

                [viewFirst addSubview:imgFirstTic];
                imgFirstTic.hidden=NO;

                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
                
            }           
            

            
            
            
            //[arrayButton addObject:aButton];
        }
        
        
        else if(i==7)
        {
            
            viewSec.hidden=NO;

            
            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);            //aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
            //[aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
         //   [aButton setBackgroundImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            aButton.tag=i;
            
            
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",obj.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            
            lblQty.text=qty;
            [viewSec addSubview:lblQty];
            lblQty.tag=i;
            lbl.tag=i;

            
            [viewSec addSubview:lbl];
            
            [viewSec addSubview:aButton];
            
            
            if(obj.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab2.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab2.png"] forState:UIControlStateDisabled];

                imgSecTic.hidden=NO;
                [viewSec addSubview:imgSecTic]; 

                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
//                
                
                
                
            }           
            

            
            
            
            
            
            
        }
        
        else if(i==8)
                
        {
            
            viewThird.hidden=NO;

            
            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);          //  aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
          //  [aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
            
        //    [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            aButton.tag=i;
            
            
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",obj.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            
            lblQty.text=qty;
            [viewThird addSubview:lblQty];
            lblQty.tag=i;
            lbl.tag=i;

            
            [viewThird addSubview:lbl];
            
            [viewThird addSubview:aButton];
            
            
            
            if(obj.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab3.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab3.png"] forState:UIControlStateDisabled];
 
                imgThirdTic.hidden=NO;
                [viewThird addSubview:imgThirdTic]; 
                

                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
              
                
            }           
            

            
            
            
            
        }
        
                
        else if(i>=9)
        {
            NSLog(@"called Btn ");
            
            btnNext.hidden=NO;
            
            [btnNext addTarget:self action:@selector(nexmedlist3) forControlEvents:UIControlEventTouchUpInside]; 
       
        
       /// [btnPrev addTarget:self action:@selector(nexmedlist) forControlEvents:UIControlEventTouchUpInside];        
        
        
        }
        
        
        
    }
    

    
    [self createViews];    
    
}

-(void)nexmedlist3
{
    
    
    lblpage.text=[NSString stringWithFormat: @"Page No. 4/%d",pagecreated];

    
    [self clearView];    
    
    
    [btnPrev addTarget:self action:@selector(nexmedlist2) forControlEvents:UIControlEventTouchUpInside];
    viewFirst.hidden=YES;
  viewSec.hidden=YES;
    viewThird.hidden=YES;
    viewFourth.hidden=YES;
    
    
    
    
    for (int i=9; i<[arrayMed count]; i++) 
    {
        
        
        
        
        if(i==9)
        {            
            viewFirst.hidden=NO;
            
            
            
            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);
            //aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
            //   [aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
            //  [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",obj.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            
            lblQty.text=qty;
            
            
            [viewFirst addSubview:lblQty];
            [viewFirst addSubview:lbl];
            lblQty.tag=i;
            lbl.tag=i;
            
            
            aButton.tag=i;
            
            
            
            [viewFirst addSubview:aButton];
            
            
            
            if(obj.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateDisabled];

                
                [viewFirst addSubview:imgFirstTic];
                imgFirstTic.hidden=NO;

                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
//                
            }           
            
            
            
            
            
            //[arrayButton addObject:aButton];
        }
        
        
        else if(i==10)
        {
            
            viewSec.hidden=NO;
            
            
            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);            //aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
            //[aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
            //   [aButton setBackgroundImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            aButton.tag=i;
            
            
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",obj.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            
            lblQty.text=qty;
            [viewSec addSubview:lblQty];
            lblQty.tag=i;
            lbl.tag=i;
            
            
            [viewSec addSubview:lbl];
            
            [viewSec addSubview:aButton];
            
            
            if(obj.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab2.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab2.png"] forState:UIControlStateDisabled];

                imgSecTic.hidden=NO;
                [viewSec addSubview:imgSecTic]; 

                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
//                
                
                
                
            }           
            
            
            
            
            
            
            
            
        }
        
        else if(i==11)
            
        {
            
            viewThird.hidden=NO;
            
            
            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);          //  aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
            //  [aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
            
            //    [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            aButton.tag=i;
            
            
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",obj.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            
            lblQty.text=qty;
            [viewThird addSubview:lblQty];
            lblQty.tag=i;
            lbl.tag=i;
            
            
            [viewThird addSubview:lbl];
            
            [viewThird addSubview:aButton];
            
            
            
            if(obj.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab3.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab3.png"] forState:UIControlStateDisabled];

                imgThirdTic.hidden=NO;
                [viewThird addSubview:imgThirdTic]; 
                

                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
//                
                
            }           
            
            
            
            
            
            
        }
        
                
        else if(i>=12)
        {
            NSLog(@"called Btn ");
            
            btnNext.hidden=NO;
            
            [btnNext addTarget:self action:@selector(nexmedlist4) forControlEvents:UIControlEventTouchUpInside]; 
            
            
        //[btnPrev addTarget:self action:@selector(nexmedlist2) forControlEvents:UIControlEventTouchUpInside];        
            
            
        }

        
        
        
        
    }
    
    
    
    [self createViews];    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}




-(void)nexmedlist4
{
    
    [self clearView];    

    
    lblpage.text=[NSString stringWithFormat: @"Page No. 5/%d",pagecreated];

    
    [btnPrev addTarget:self action:@selector(nexmedlist3) forControlEvents:UIControlEventTouchUpInside];

    
    viewFirst.hidden=YES;
    viewSec.hidden=YES;
    viewThird.hidden=YES;
    viewFourth.hidden=YES;
    
    
    
    
    for (int i=12; i<[arrayMed count]; i++) 
    {
        
        
        
        
        if(i==12)
        {            
            viewFirst.hidden=NO;
            
            
            
            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);
            //aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
            //   [aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
            //  [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",obj.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            
            lblQty.text=qty;
            
            
            [viewFirst addSubview:lblQty];
            [viewFirst addSubview:lbl];
            lblQty.tag=i;
            lbl.tag=i;
            
            
            aButton.tag=i;
            
            
            
            [viewFirst addSubview:aButton];
            
            
            
            if(obj.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateDisabled];

                
                [viewFirst addSubview:imgFirstTic];
                imgFirstTic.hidden=NO;

                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
                
            }           
            
            
            
            
            
            //[arrayButton addObject:aButton];
        }
        
        
        else if(i==13)
        {
            
            viewSec.hidden=NO;
            
            
            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);            //aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
            //[aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
            //   [aButton setBackgroundImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            aButton.tag=i;
            
            
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",obj.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            
            lblQty.text=qty;
            [viewSec addSubview:lblQty];
            lblQty.tag=i;
            lbl.tag=i;
            
            
            [viewSec addSubview:lbl];
            
            [viewSec addSubview:aButton];
            
            
            if(obj.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab2.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                
                
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab2.png"] forState:UIControlStateDisabled];

                imgSecTic.hidden=NO;
                [viewSec addSubview:imgSecTic]; 

                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
//                
                
                
                
            }           
            
            
            
            
            
            
            
            
        }
        
        else if(i==14)
            
        {
            
            viewThird.hidden=NO;
            
            
            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);          //  aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
            //  [aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
            
            //    [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            aButton.tag=i;
            
            
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",obj.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            
            lblQty.text=qty;
            [viewThird addSubview:lblQty];
            lblQty.tag=i;
            lbl.tag=i;
            
            
            [viewThird addSubview:lbl];
            
            [viewThird addSubview:aButton];
            
            
            
            if(obj.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab3.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab3.png"] forState:UIControlStateDisabled];

                
                imgThirdTic.hidden=NO;
                [viewThird addSubview:imgThirdTic]; 
                

                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
                
                
            }           
            
            
            
            
            
            
        }
        
        
        else if(i>=15)
        {
            NSLog(@"called Btn ");
            
            btnNext.hidden=NO;
            
            [btnNext addTarget:self action:@selector(nexmedlist5) forControlEvents:UIControlEventTouchUpInside]; 
            
            
            //[btnPrev addTarget:self action:@selector(nexmedlist2) forControlEvents:UIControlEventTouchUpInside];        
            
            
        }
        
        
        
        
        
    }
    
    
    
    [self createViews];    
    
    

}



-(void)nexmedlist5
{
    
    [self clearView];    

    [btnPrev addTarget:self action:@selector(nexmedlist4) forControlEvents:UIControlEventTouchUpInside];
    
    lblpage.text=[NSString stringWithFormat: @"Page No. 6/%d",pagecreated];

    viewFirst.hidden=YES;
    viewSec.hidden=YES;
    viewThird.hidden=YES;
    viewFourth.hidden=YES;
    
    
    
    
    for (int i=15; i<[arrayMed count]; i++) 
    {
        
        
        
        
        if(i==15)
        {            
            viewFirst.hidden=NO;
            
            
            
            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);
            //aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
            //   [aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
            //  [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",obj.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            
            lblQty.text=qty;
            
            
            [viewFirst addSubview:lblQty];
            [viewFirst addSubview:lbl];
            lblQty.tag=i;
            lbl.tag=i;
            
            
            aButton.tag=i;
            
            
            
            [viewFirst addSubview:aButton];
            
            
            
            if(obj.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateDisabled];

                [viewFirst addSubview:imgFirstTic];
                imgFirstTic.hidden=NO;

                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
                
            }           
            
            
            
            
            
            //[arrayButton addObject:aButton];
        }
        
        
        else if(i==16)
        {
            
            viewSec.hidden=NO;
            
            
            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);            //aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
            //[aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
            //   [aButton setBackgroundImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            aButton.tag=i;
            
            
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",obj.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            
            lblQty.text=qty;
            [viewSec addSubview:lblQty];
            lblQty.tag=i;
            lbl.tag=i;
            
            
            [viewSec addSubview:lbl];
            
            [viewSec addSubview:aButton];
            
            
            if(obj.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab2.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                imgSecTic.hidden=NO;
                [viewSec addSubview:imgSecTic]; 
                
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab2.png"] forState:UIControlStateDisabled];

                
                aButton.enabled=NO;
//                UIImage *newPressedImage = [UIImage imageNamed:@"Image Icon.png"];
//                [aButton setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
//                
                
                
                
            }           
            
            
            
            
            
            
            
            
        }
        
        else if(i==17)
            
        {
            
            viewThird.hidden=NO;
            
            
            UIButton *aButton=[UIButton buttonWithType:UIButtonTypeCustom];
            aButton.frame=CGRectMake(10, 20, 80, 40);          //  aButton.titleLabel.text= [NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i]];
            //  [aButton setTitle:[NSString stringWithFormat:@"%@", [arrayMed objectAtIndex:i] ]forState:UIControlStateNormal];
            
            //    [aButton setBackgroundImage:[UIImage imageNamed:@"tab1.png"] forState:UIControlStateNormal];
            
            [aButton addTarget:self action:@selector(methodMedicineTaken:::) forControlEvents:UIControlEventTouchUpInside];
            aButton.tag=i;
            
            
            
            classCompartmentData *obj=[arrayMed objectAtIndex:i];
            
            
            
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 100, 30)];
            lbl.text=[NSString stringWithFormat:@"%@",obj.bayMedName];
            
            NSLog(@"%@",lbl.text);    
            
            
            NSString *qty=[NSString stringWithFormat:@"%.1f",obj.bayMedQty];
            
            UILabel *lblQty=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 20)];
            
            lblQty.text=qty;
            [viewThird addSubview:lblQty];
            lblQty.tag=i;
            lbl.tag=i;
            
            
            [viewThird addSubview:lbl];
            
            [viewThird addSubview:aButton];
            
            
            
            if(obj.state==0)
            {
                [aButton setBackgroundImage:[UIImage imageNamed:@"tab3.png"] forState:UIControlStateNormal];
                
                
                
            }
            else
            {
                aButton.enabled=NO;

                [aButton setBackgroundImage:[UIImage imageNamed:@"tab3.png"] forState:UIControlStateDisabled];

                imgThirdTic.hidden=NO;
                [viewThird addSubview:imgThirdTic]; 
                
               

            
            }           
            
            
            
            
            
            
        }

    
    
    
    
    }
    
    
    [self createViews];    
    
    
    
    
    
    
    
}





-(void)methodMedList
{
    classBayMedicationList *objMedList=[[classBayMedicationList alloc]initWithStyle:UITableViewStyleGrouped];
    objMedList.strSpan=lblSpan.text;
    //objMedList.myAudioPlayer=self.myAudioPlayer;
    //objMedList.arrayMed=arrayMed;
    objMedList.myAudioPlayer=self.myAudioPlayer;

    objMedList.objUser=self.objUser;
    objMedList.userid=userid;
    objMedList.bayno=bayno;
    
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:objMedList];
    [self presentModalViewController:nav animated:YES];
   
    
    
}


    
    
        

-(void)clearView
{
    
    imgFirstTic.hidden=YES;
    imgSecTic.hidden=YES;
    imgThirdTic.hidden=YES;
    
    
    
    
    
    for(UIView * subView in [self.viewFirst subviews])
    {
        
        [subView removeFromSuperview];
        
    }    
    
    
    
    for(UIView * subView in [self.viewSec subviews])
    {
        
        [subView removeFromSuperview];
        
    }    
    
    for(UIView * subView in [self.viewThird subviews])
    {
        
        [subView removeFromSuperview];
        
    }    
    
    
//    for(UIView * subView in [self.viewFourth subviews])
//    {
//        
//        [subView removeFromSuperview];
//        
//    }    

   
    

}
    
-(void)displyCompartment:(int)bayno1
{
//    for(int i=1;i<=28;i++)
//    {
//        
//        if(bayno1==i)
//        {
//            
//            
//            NSString * query=[NSString stringWithFormat:@"select day,timespan from takemedicine where bayno= %d",bayno1];
//            
    if (bayno1==1) 
    {

        
        lblDay.text=@"Monday";
        lblSpan.text=@"Morning";
        
    }   
            
    if (bayno1==8) 
    {
        
        
        lblDay.text=@"Monday";
        lblSpan.text=@"Afternoon";
        
    }          
            
            
    if (bayno1==15) 
    {
        
        
        lblDay.text=@"Monday";
        lblSpan.text=@"Evening";
        
    }         
            
    if (bayno1==22) 
    {
        
        
        lblDay.text=@"Monday";
        lblSpan.text=@"Night";
        
    }           
            
    
    if (bayno1==2) 
    {
        
        
        lblDay.text=@"Tuesday";
        lblSpan.text=@"Morning";
        
    }   
    
    if (bayno1==9) 
    {
        
        
        lblDay.text=@"Tuesday";
        lblSpan.text=@"Afternoon";
        
    }          
    
    
    if (bayno1==16) 
    {
        
        
        lblDay.text=@"Tuesday";
        lblSpan.text=@"Evening";
        
    }         
    
    if (bayno1==23) 
    {
        
        
        lblDay.text=@"Tuesday";
        lblSpan.text=@"Night";
        
    }           
        
                
        
    
    if (bayno1==3) 
    {
        
        
        lblDay.text=@"Wednesday";
        lblSpan.text=@"Morning";
        
    }   
    
    if (bayno1==10) 
    {
        
        
        lblDay.text=@"Wednesday";
        lblSpan.text=@"Afternoon";
        
    }          
    
    
    if (bayno1==17) 
    {
        
        
        lblDay.text=@"Wednesday";
        lblSpan.text=@"Evening";
        
    }         
    
    if (bayno1==24) 
    {
        
        
        lblDay.text=@"Wednesday";
        lblSpan.text=@"Night";
        
    }           
    

        
        
    if (bayno1==4) 
    {
        
        
        lblDay.text=@"Thursday";
        lblSpan.text=@"Morning";
        
    }   
    
    if (bayno1==11) 
    {
        
        
        lblDay.text=@"Thursday";
        lblSpan.text=@"Afternoon";
        
    }          
    
    
    if (bayno1==18) 
    {
        
        
        lblDay.text=@"Thursday";
        lblSpan.text=@"Evening";
        
    }         
    
    if (bayno1==25) 
    {
        
        
        lblDay.text=@"Thursday";
        lblSpan.text=@"Night";
        
    }           

        
        
    if (bayno1==5) 
    {
        
        
        lblDay.text=@"Friday";
        lblSpan.text=@"Morning";
        
    }   
    
    if (bayno1==12) 
    {
        
        
        lblDay.text=@"Friday";
        lblSpan.text=@"Afternoon";
        
    }          
    
    
    if (bayno1==19) 
    {
        
        
        lblDay.text=@"Friday";
        lblSpan.text=@"Evening";
        
    }         
    
    if (bayno1==26) 
    {
        
        
        lblDay.text=@"Friday";
        lblSpan.text=@"Night";
        
    }           

        
        
        
    if (bayno1==6) 
    {
        
        
        lblDay.text=@"Saturday";
        lblSpan.text=@"Morning";
        
    }   
    
    if (bayno1==13) 
    {
        
        
        lblDay.text=@"Saturday";
        lblSpan.text=@"Afternoon";
        
    }          
    
    
    if (bayno1==20) 
    {
        
        
        lblDay.text=@"Saturday";
        lblSpan.text=@"Evening";
        
    }         
    
    if (bayno1==27) 
    {
        
        
        lblDay.text=@"Saturday";
        lblSpan.text=@"Night";
        
    }           

        
    if (bayno1==7) 
    {
        
        
        lblDay.text=@"Sunday";
        lblSpan.text=@"Morning";
        
    }   
    
    if (bayno1==14) 
    {
        
        
        lblDay.text=@"Sunday";
        lblSpan.text=@"Afternoon";
        
    }          
    
    
    if (bayno1==21) 
    {
        
        
        lblDay.text=@"Sunday";
        lblSpan.text=@"Evening";
        
    }         
    
    if (bayno1==28) 
    {
        
        
        lblDay.text=@"Sunday";
        lblSpan.text=@"Night";
        
    }                
    
    
    
    
    
    
}



-(void)decrementTotalQuantity:(classMedicine *)objMedicine1:(float)pillQuantityToTaken
{
    
    // decremtn quantity for dtabase
    objMedicine1.totalPillQuantity=objMedicine.totalPillQuantity-pillQuantityToTaken;
    
    
    NSString *queryString=[NSString stringWithFormat:@"update medicine set medicinetotalpillquantity=%.1f where medicineid=%d and userid=%d",objMedicine.totalPillQuantity,objMedicine.medicineSequenceId,objUser.userId];
    // also decremtn from database
    
    [classDatabaseOperations add:queryString];
    
    
}


    
-(void)checkReoderLevel
{
    if((objMedicine.totalPillQuantity<=0 || objMedicine.totalPillQuantity<objMedicine.reorderLevel))
       // && remindMeLater==NO)
    {
        
        
        if(objUser.audioStatus==YES)
        {
            NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:@"reorderLevelWarning", nil];
            //[myAudioPlayer playAudios:array];
            [array release];
        }
        
        UIActionSheet * actionsheet=[[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"Reorder level warning !\nWould you like to send request to reorder your medicine ?",objMedicine.reorderLevel] delegate:self cancelButtonTitle:@"Send Request" destructiveButtonTitle:@"Cancel" otherButtonTitles:@"Remind Me Later", nil];
        actionsheet.tag=150;
        [actionsheet showInView:self.view];
        actionsheet.opaque=NO;
        [actionsheet release];
        
    }
    else
    {
        
        
      //  [self playAudio];
    }
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex==2)// send request
    {
        
        
        classRefillingOption * objMedicineOptions=[[classRefillingOption alloc] initWithStyle:UITableViewStyleGrouped];
        objMedicineOptions.strMedicineName=objMedicine.medicineName;
        objMedicineOptions.objUser=self.objUser;
        //objMedicineOptions.myAudioPlayer=self.myAudioPlayer;
        [self.navigationController pushViewController:objMedicineOptions animated:YES];
        [objMedicineOptions release];
        
    }
    else
        if(buttonIndex==1)// send request
        {
            
           // remindMeLater=YES;
           // [self playAudio];
            
        }
        else
        {
            
            
            // cancel
            // play audio
            
           // [self playAudio];
            
            
        }
    
    
}

    
    
    






@end
