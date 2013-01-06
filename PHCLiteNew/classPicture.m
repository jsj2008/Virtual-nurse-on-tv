//
//  classPicture.m
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 8/22/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classPicture.h"
#import "classMedicine.h"
#import "classUser.h"
#import "classCareGiver.h"
#import "classAudio.h"
#import "classDatabaseOperations.h"

@implementation classPicture
@synthesize imageViewMedicine;
@synthesize objMedicine;
@synthesize imageCamptured;
@synthesize myAudioPlayer;
@synthesize objUser;
@synthesize isUserPhotoMode;
@synthesize isCareGiverMode;
@synthesize btnPhotoLibrary;
@synthesize classCareGiverobj;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [imageViewMedicine release];
    [btnPhotoLibrary release];
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
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"TakePicture";
    
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)] autorelease];
    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(setNewImage)]autorelease];
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.3 green:0.5 blue:0.4 alpha:0.5];
    if(isUserPhotoMode==YES)
    {
        if(self.objUser.userImage !=nil)
        {
            self.imageViewMedicine.image=self.objUser.userImage;
            
            
        }
        if(self.classCareGiverobj.caregiverImage !=nil)        {
            self.imageViewMedicine.image=self.classCareGiverobj.caregiverImage;
            
        }

        
    }
    else
    {
        if(self.objMedicine.medicineImage !=nil)
        {
            self.imageViewMedicine.image=self.objMedicine.medicineImage;
            
            
        }
    }
  
    if(self.classCareGiverobj.caregiverImage !=nil)        {
              
    }

    if (isCareGiverMode==YES) {
        NSString *strImg1=@"backImage1.png";
        NSString *strImg;
        
        strImg=[classDatabaseOperations getNurseImg:objUser.userId];
        NSLog(@"%@",strImg);
        if ([strImg isEqualToString:@"null"])
        {
            self.imageViewMedicine.image=[UIImage imageNamed:strImg1];
            strImg=strImg1;
        }
        else{
            NSLog(@"Nurse is %@",strImg);
            self.imageViewMedicine.image=[UIImage imageNamed:strImg];
        }

    }
       
    if(objUser.audioStatus==YES)
    {
    NSMutableArray * array=[[NSMutableArray alloc] init];
    [array addObject:@"pleaseTakeMedicinePicture"];
    [myAudioPlayer playAudios:array];
    [array release];
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated]; 
    
}
- (void)viewDidUnload
{
    [self setImageViewMedicine:nil];
    [self setBtnPhotoLibrary:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





-(IBAction)takePicture
{
    
    BOOL isCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];

    if(isCamera)
    {
    
    // Create image picker controller
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // Set source to the camera
    imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    
    // Delegate is self
    imagePicker.delegate = self;
    
    // Allow editing of image ?
    imagePicker.allowsEditing = NO;
    
    // Show image picker
    [self presentModalViewController:imagePicker animated:YES];
        
    }
    else
    {
        
        
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Sorry !" message:@"Camera not found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    
}



- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self scaleAndRotateImage:image];

    [picker release];
    
    
    [self dismissModalViewControllerAnimated:YES];
    
    
}


-(void)cancel
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag==168)
    {
        
        
        if(buttonIndex==0)// done
        {
           
            NSString *strImg=[classDatabaseOperations getNurseImg:objUser.userId];
            NSString * imgName = [NSString stringWithFormat:@"%@",strImg];
          
            NSData* imageData = UIImagePNGRepresentation( imageCamptured);
            
            // get path of document directory to save medicne
            NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
            NSString *documentsDir = [documentPaths objectAtIndex:0];
            NSString * databasePath = [documentsDir stringByAppendingPathComponent:imgName];
                    
            // and then we write it out
            [imageData writeToFile:databasePath atomically:NO];
            
            [self.navigationController popViewControllerAnimated:YES];

            
        }
        else if(buttonIndex==1)// skip
            
        {
            
            
                        
            
        }
        
    }
}
-(void)setNewImage
{
    
    
    

    if(isUserPhotoMode==YES)
    {    
        
         self.objUser.userImage=imageCamptured;
        self.classCareGiverobj.caregiverImage=imageCamptured;

      
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        self.objMedicine.medicineImage=imageCamptured;
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (isCareGiverMode==YES) {
        self.objMedicine.medicineImage=imageCamptured;

        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Change Image" message:@"Care Giver Image Changed Sucessfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        alert.tag=168;
        [alert show];
        [alert release];
         
    }
   // classCareGiverobj.caregiverImage=imageCamptured;
    
    
}

- (IBAction)methodphotolibrary:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // Set source to the camera
    imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    // Delegate is self
    imagePicker.delegate = self;
    
    // Allow editing of image ?
    imagePicker.allowsEditing = NO;
    
    // Show image picker
    [self presentModalViewController:imagePicker animated:YES];
    

    
}
- (void)scaleAndRotateImage:(UIImage *)image
{
    int kMaxResolution = 320; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.imageViewMedicine.image=image;
    self.imageCamptured=imageCopy;
    
    
    //[self setRotatedImage:imageCopy];
    //return imageCopy;
}


@end
