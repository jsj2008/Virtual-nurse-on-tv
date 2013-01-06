//
//  classDosageFrequency.h
//  i_strip
//
//  Created by Avi Kulkarni on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "classAudio.h"
//#import "classUser.h"

@class classMedicine;
@class classUser;
@class classAudio;
@interface classDosageFrequency : UITableViewController
{

	classMedicine * objMedicine;
	int selectedDosageFrequency;
	
    classAudio * myAudioPlayer;

    classUser * objUser;

}

-(void)done;
-(void)cancel;

@property(nonatomic,retain)	classMedicine * objMedicine;
@property(nonatomic)int selectedDosageFrequency;
@property(nonatomic,retain)classAudio * myAudioPlayer;
@property(nonatomic,retain)    classUser * objUser;



@end
