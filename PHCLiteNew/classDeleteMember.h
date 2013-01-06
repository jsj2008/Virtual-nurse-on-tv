//
//  classDeleteMember.h
//  i_Strips_Pro
//
//  Created by Avi Kulkarni on 9/12/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol protocolDeleteMember

-(void)doneDeletingMember;
-(void)cancelDeletingMember;

@end


@class classAudio;
@interface classDeleteMember : UITableViewController<UIActionSheetDelegate,UIAlertViewDelegate>
{
 
   // id<protocolDeleteMember>delegate;
    NSMutableArray * arrayOfUsers;
    classAudio * myAudioPlayer;
    
    
}

@property(nonatomic,retain)    NSMutableArray * arrayOfUsers;
@property(nonatomic,assign)    id<protocolDeleteMember>delegate;
@property(nonatomic,retain)    classAudio * myAudioPlayer;

-(void)cancel;
-(void)deleteSelectedMember;
-(void)deleteMedicines;

@end


