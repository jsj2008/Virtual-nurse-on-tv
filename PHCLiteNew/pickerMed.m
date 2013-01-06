//
//  pickerMed.m
//  PickerViewMed
//
//  Created by Avi kulkarni on 18/02/12.
//  Copyright (c) 2012 techindia@panhealth.com. All rights reserved.
//

#import "pickerMed.h"

@implementation pickerMed

@synthesize pillSizeArray;
@synthesize pillColorNameArray;
@synthesize myPicker;
@synthesize imgTab;
@synthesize pillShapeImageNameArray;
@synthesize objMedicine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    //(1)
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];   
    // (2)       
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];

    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem=doneButton;
    
    
    
    
    // Do any additional setup after loading the view from its nib.
    
    self.pillSizeArray=[NSMutableArray arrayWithObjects:@"Small",@"Medium",@"Large", nil];
    
  //  self.pillShapeImageNameArray=[[NSMutableArray alloc] initWithObjects:@"circle.png",@"capsule.png",@"dimond.png",@"triangle.png",@"square.png",@"oblong.png",@"oval.png",@"tear.png",@"Rectangle.png",@"doublecircle.png",@"clover.png",@"gear.png",@"semicir.png",@"trapezoid.png",@"5sided.png",@"6sided.png",@"7sided.png",@"inhaler_gray.png",@"gray_dropper.png",@"injection.png",nil];
    self.pillShapeImageNameArray=[NSMutableArray arrayWithObjects:@"circle.png",@"capsule.png",@"dimond.png",@"triangle.png",@"square.png",@"oblong.png",@"oval.png",@"tear.png",@"Rectangle.png",@"doublecircle.png",@"clover.png",@"gear.png",@"semicir.png",@"trapezoid.png",@"5sided.png",@"6sided.png",@"7sided.png",@"inhaler_gray.png",@"gray_dropper.png",@"injection.png", nil];
    
    // (3)im
    self.pillColorNameArray=[NSMutableArray arrayWithObjects:[UIColor redColor],[UIColor purpleColor],[UIColor yellowColor],[UIColor grayColor],[UIColor blueColor],[UIColor brownColor],[UIColor greenColor],[UIColor blackColor],[UIColor orangeColor],[UIColor whiteColor],[UIColor colorWithRed:0 green:0.773 blue:0.804 alpha:1.0],[UIColor colorWithRed:0.933 green:0.416 blue:0.655 alpha:1.0],[UIColor colorWithRed:0.922 green:0.78 blue:0.62 alpha:1.0],nil];

    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    int numberOfRows=0;
    if(component==0)
    {
        numberOfRows=3;
    }
    else if (component==1)
    {
        numberOfRows=20;
    }
    else if (component==2)
    {
        numberOfRows=13;
    }
    
    return numberOfRows;
}



- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view 
{
    // If parameter component is zero return sizes i.e. small, medium, larg
    if(component==0)
    {
        if(view==nil)
        {
            // Create a label object
            UILabel * label=[[UILabel alloc] init];
            label.frame=CGRectMake(0, 0, 70, 50);

            // Set our text in it
            label.text=[self.pillSizeArray objectAtIndex:row];
            
            // set text alignment
            label.textAlignment=UITextAlignmentCenter;
            
            // Set label background color
            label.backgroundColor=[UIColor clearColor];
            // set view as our lable;
            view=label;
        }
        else
        {
            ((UILabel *)view).text= [self.pillSizeArray objectAtIndex:row];
        }
    }
    else if (component==1)
    {
        
//        if(view==nil)
//        {
//            // Create a label object
//            UILabel * label=[[UILabel alloc] init];
//            label.frame=CGRectMake(0, 0, 70, 50);
//            // Set our text in it
//            label.text=[self.pillShapeImageNameArray objectAtIndex:row];
//            
//            // set text alignment
//            label.textAlignment=UITextAlignmentCenter;
//            
//            // Set label background color
//            label.backgroundColor=[UIColor clearColor];
//            // set view as our lable;
//            view=label;
//        }
//        else
//        {
//            ((UILabel *)view).text= [self.pillShapeImageNameArray objectAtIndex:row];
//        }
//        
        // Create a label object
        UIImageView * imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.pillShapeImageNameArray objectAtIndex:row]]];
        
        //Set frame i.e.  x, y axis and widht and height
         [imageView setFrame:CGRectMake(0, 0, 40, 40)];
        [imageView setTag:row];

        // set view as our lable;@
         view=imageView;
    }
    else if (component==2)
    {
        if(view==nil)
        {
            UIView *tmpView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)] autorelease];
            UIColor * color=[self.pillColorNameArray objectAtIndex:row];

            [tmpView setBackgroundColor:color];
            
            [tmpView setUserInteractionEnabled:NO];
            [tmpView setTag:row];
            view=tmpView;
        }
        else
        {
            
            UIColor * color=[self.pillColorNameArray objectAtIndex:row];
            [view setBackgroundColor:color];
            
        }
        
        
    }
    
    // Retrun view
    return view;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component 
{
    
    
    if (component==0) // Size
    {
        Component1SelectedRow=row;
        
        
    }
    else if (component==1) // Shape
    {
        Component2SelectedRow=row;
        
    }
    else if (component==2) // Color
    {
        Component3SelectedRow=row;
    }
    
    
    
    
    self.imgTab.image= [self getImageNameForSize:Component1SelectedRow forShape:Component2SelectedRow forColor:Component3SelectedRow];    
    [UIView commitAnimations];    
    
}



-(UIImage * )getImageNameForSize:(int)size forShape:(int)shape forColor:(int)color {
    
    NSMutableString * imageName=[[[NSMutableString alloc] init]autorelease];
    
    if(size==0) // Small
    {
        imageName= [[imageName stringByAppendingFormat:@"Small"] mutableCopy];
    //    self.objMedicine.size=@"Small";
    }
    else if(size==1) // Medimum
    {
        imageName= [[imageName stringByAppendingFormat:@"Medium"] mutableCopy];
       // self.objMedicine.size=@"Medium";

    }
    else if(size==2) // Large
    {
        imageName= [[imageName stringByAppendingFormat:@"Large"] mutableCopy];

    }
    
    
    if(shape==0) // square
    {
        imageName= [[imageName stringByAppendingFormat:@"Circle"] mutableCopy];
      //  self.objMedicine.formFactor=@"Circle";

    }
    else if(shape==1) // Circle
    {
        imageName= [[imageName stringByAppendingFormat:@"Capsule"] mutableCopy];
   // self.objMedicine.formFactor=@"Capsule";
    }
   else if(shape==2) // Dimond
    {
        imageName= [[imageName stringByAppendingFormat:@"Dimond"] mutableCopy];
    //self.objMedicine.formFactor=@"Dimond";
    }
    else if(shape==3)//Capsule
    {
        imageName=[[imageName stringByAppendingFormat:@"Triangle"]mutableCopy];
  //  self.objMedicine.formFactor=@"Triangle";
    }
    else if(shape==4)//inhaler
    {
        imageName=[[imageName stringByAppendingFormat:@"Square"]mutableCopy];
  //  self.objMedicine.formFactor=@"Square";
    }
    else if(shape==5)//injection
    {
        imageName=[[imageName stringByAppendingFormat:@"Oblong"]mutableCopy];
  //  self.objMedicine.formFactor=@"Oblong";
    }
    else if(shape==6)//dropper
    {
        imageName=[[imageName stringByAppendingFormat:@"Oval"]mutableCopy];
  //  self.objMedicine.formFactor=@"Oval";
    }
    else if(shape==7)//dropper
    {
        imageName=[[imageName stringByAppendingFormat:@"Tear"]mutableCopy];
      //  self.objMedicine.formFactor=@"Tear";
    }
    else if(shape==8)//dropper
    {
        imageName=[[imageName stringByAppendingFormat:@"Rectangle"]mutableCopy];
     //   self.objMedicine.formFactor=@"Rectangle";
    }
    
    else if(shape==9)//dropper
    {
        imageName=[[imageName stringByAppendingFormat:@"Doublecir"]mutableCopy];
      //  self.objMedicine.formFactor=@"Doublecir";
    }
    
    else if(shape==10)//dropper
    {
        imageName=[[imageName stringByAppendingFormat:@"Clover"]mutableCopy];
      //  self.objMedicine.formFactor=@"Clover";
    }
    
    else if(shape==11)//dropper
    {
        imageName=[[imageName stringByAppendingFormat:@"Gear"]mutableCopy];
       // self.objMedicine.formFactor=@"Gear";
    }
    
    else if(shape==12)//dropper
    {
        imageName=[[imageName stringByAppendingFormat:@"Semicir"]mutableCopy];
       // self.objMedicine.formFactor=@"Semicir";
    }
    
    else if(shape==13)//dropper
    {
        imageName=[[imageName stringByAppendingFormat:@"Trapezoid"]mutableCopy];
      //  self.objMedicine.formFactor=@"Trapezoid";
    }
    
    else if(shape==14)//dropper
    {
        imageName=[[imageName stringByAppendingFormat:@"5Side"]mutableCopy];
      //  self.objMedicine.formFactor=@"5sided";
    }
    
    else if(shape==15)//dropper
    {
        imageName=[[imageName stringByAppendingFormat:@"6Side"]mutableCopy];
      //  self.objMedicine.formFactor=@"6sided";
    }
    else if(shape==16)//dropper
    {
        imageName=[[imageName stringByAppendingFormat:@"7Side"]mutableCopy];
      //  self.objMedicine.formFactor=@"7sided";
    }
    else if(shape==17)//dropper
    {
        imageName=[[imageName stringByAppendingFormat:@"Inhaler"]mutableCopy];
      //  self.objMedicine.formFactor=@"Inhaler";
    }
    else if(shape==18)//dropper
    {
        imageName=[[imageName stringByAppendingFormat:@"Dropper"]mutableCopy];
      //  self.objMedicine.formFactor=@"Dropper";
    }
    else if(shape==19)//dropper
    {
        imageName=[[imageName stringByAppendingFormat:@"Injection"]mutableCopy];
      //  self.objMedicine.formFactor=@"Injection";
    }
    
    
    
    
    if(color==0) // Red
    {
        imageName= [[imageName stringByAppendingFormat:@"Red"] mutableCopy];
      //  self.objMedicine.color=@"Red";
        
    }
    else if(color==1) // Purple
    {
        imageName= [[imageName stringByAppendingFormat:@"Purple"] mutableCopy];
     //   self.objMedicine.color=@"Purple";

    }
    else if(color==2) // Yellow
    {
        imageName= [[imageName stringByAppendingFormat:@"Yellow"] mutableCopy];
     //   self.objMedicine.color=@"Yellow";

    }
    else if(color==3)//gray
    {
        imageName=[[imageName stringByAppendingFormat:@"Gray"]mutableCopy];
        
      //  self.objMedicine.color=@"Gray";

    }
    else if(color==4)//blue
    {
        imageName=[[imageName stringByAppendingFormat:@"Blue"]mutableCopy];
      //  self.objMedicine.color=@"Blue";

    }
    else if(color==5)//brown
    {
        imageName=[[imageName stringByAppendingFormat:@"Brown"]mutableCopy];
      //  self.objMedicine.color=@"Brown";

    }
    else if(color==6)//green
    {
        imageName=[[imageName stringByAppendingFormat:@"Green"]mutableCopy];
      //  self.objMedicine.color=@"Green";

    }  
    else if(color==7)//green
    {
        imageName=[[imageName stringByAppendingFormat:@"Black"]mutableCopy];
     //   self.objMedicine.color=@"Black";
        
    }
    else if(color==8)//Orange
    {
        imageName=[[imageName stringByAppendingFormat:@"Orange"]mutableCopy];
      //  self.objMedicine.color=@"Orange";
        
    }
    else if(color==9)//White
    {
        imageName=[[imageName stringByAppendingFormat:@"White"]mutableCopy];
      //  self.objMedicine.color=@"White";
        
    }
    else if(color==10)//Turquiose
    {
        imageName=[[imageName stringByAppendingFormat:@"Turquoise"]mutableCopy];
      //  self.objMedicine.color=@"Turquoise";
        
    }
    else if(color==11)//Pink
    {
        imageName=[[imageName stringByAppendingFormat:@"Pink"]mutableCopy];
      //  self.objMedicine.color=@"Pink";
        
    }
    else if(color==12)//Cream
    {
        imageName=[[imageName stringByAppendingFormat:@"Cream"]mutableCopy];
     //   self.objMedicine.color=@"Cream";
        
    }
    
    
    
    
    
    //[myPicker reloadAllComponents];
    
    UIImage * pillImage=[UIImage imageNamed:imageName];
   // [imgTab sizeToFit];
    [imageName release];
    return pillImage;
}    

-(void)goBack
{
[self dismissModalViewControllerAnimated:YES];
}

-(void)done
{
    
    self.objMedicine.medicineImage=self.imgTab.image;
    [self dismissModalViewControllerAnimated:YES];

}


- (void)dealloc {
    [myPicker release];
    [imgTab release];
    [super dealloc];
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
