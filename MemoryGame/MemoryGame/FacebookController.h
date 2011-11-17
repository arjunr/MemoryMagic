//
//  FacebookController.h
//  MemoryGame
//
//  Created by Sai Pujitha & Arjun R on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect/FBConnect.h"


@interface FacebookController : UIViewController <FBSessionDelegate, FBRequestDelegate> {
	FBSession* _session;
	FBLoginDialog *_loginDialog;
	UIButton *_postGradesButton;
	UIButton *_logoutButton;
	NSString *_facebookName;
	BOOL _posting;
	UIButton *exitButton;
}

@property (nonatomic, retain) FBSession *session;
@property (nonatomic, retain) IBOutlet UIButton *postGradesButton;
@property (nonatomic, retain) IBOutlet UIButton *exitButton;
@property (nonatomic, retain) IBOutlet UIButton *logoutButton;
@property (nonatomic, retain) FBLoginDialog *loginDialog;
@property (nonatomic, copy) NSString *facebookName;
@property (nonatomic, assign) BOOL posting;

- (IBAction)postGradesTapped:(id)sender;
- (IBAction)logoutButtonTapped:(id)sender;
- (void)postToWall;
- (void)getFacebookName;
-(IBAction)exitButtonTapped:(id)sender;

@end
