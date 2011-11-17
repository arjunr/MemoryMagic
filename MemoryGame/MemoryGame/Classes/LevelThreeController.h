//
//  LevelThreeController.h
//  MemoryGame
//
//  Created by Sai Pujitha & Arjun R on 6/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect/FBConnect.h"

@interface LevelThreeController : UIViewController {
	UIButton *button11;
	UIButton *button12;
	UIButton *button13;
	UIButton *buttin14;
	UIButton *button21;
	UIButton *button22;
	UIButton *button23;
	UIButton *button24;
	UIButton *button31;
	UIButton *button32;
	UIButton *button33;
	UIButton *button34;
	UIButton *button41;
	UIButton *button42;
	UIButton *button43;
	UIButton *button44;
	UIButton *button51;
	UIButton *button52;
	UIButton *button53;
	UIButton *button54;
	
	UIButton *try1;

	UILabel *countLabel;
	UILabel *notification;
	UIButton *finishButton;
	UIButton *startButton;
	UIButton *restartButton;
	UIButton *exitButton;

	NSMutableArray *photoNames;
    NSMutableArray *photoURLs;

}
@property (nonatomic, retain) IBOutlet UIButton *button11;
@property (nonatomic, retain) IBOutlet UIButton *button12;
@property (nonatomic, retain) IBOutlet UIButton *button13;
@property (nonatomic, retain) IBOutlet UIButton *button14;
@property (nonatomic, retain) IBOutlet UIButton *button21;
@property (nonatomic, retain) IBOutlet UIButton *button22;
@property (nonatomic, retain) IBOutlet UIButton *button23;
@property (nonatomic, retain) IBOutlet UIButton *button24;
@property (nonatomic, retain) IBOutlet UIButton *button31;
@property (nonatomic, retain) IBOutlet UIButton *button32;
@property (nonatomic, retain) IBOutlet UIButton *button33;
@property (nonatomic, retain) IBOutlet UIButton *button34;
@property (nonatomic, retain) IBOutlet UIButton *button41;
@property (nonatomic, retain) IBOutlet UIButton *button42;
@property (nonatomic, retain) IBOutlet UIButton *button43;
@property (nonatomic, retain) IBOutlet UIButton *button44;
@property (nonatomic, retain) IBOutlet UIButton *button51;
@property (nonatomic, retain) IBOutlet UIButton *button52;
@property (nonatomic, retain) IBOutlet UIButton *button53;
@property (nonatomic, retain) IBOutlet UIButton *button54;
@property (nonatomic, retain) IBOutlet UIButton *finishButton;
@property (nonatomic, retain) IBOutlet UIButton *startButton;
@property (nonatomic, retain) IBOutlet UILabel *countLabel;
@property (nonatomic, retain) IBOutlet UILabel *notification;

@property (nonatomic, retain) IBOutlet UIButton *restartButton;
@property (nonatomic, retain) IBOutlet UIButton *exitButton;

@property (nonatomic, retain) IBOutlet UIButton *try1;



-(IBAction)finish;
-(IBAction)start:(id)sender;
-(IBAction)restart:(id)sender;
-(IBAction)exitApp:(id)sender;

-(IBAction)check;

-(IBAction)doButton11:(id)sender;
-(IBAction)doButton12:(id)sender;
-(IBAction)doButton13:(id)sender;
-(IBAction)doButton14:(id)sender;
-(IBAction)doButton21:(id)sender;
-(IBAction)doButton22:(id)sender;
-(IBAction)doButton23:(id)sender;
-(IBAction)doButton24:(id)sender;
-(IBAction)doButton31:(id)sender;
-(IBAction)doButton32:(id)sender;
-(IBAction)doButton33:(id)sender;
-(IBAction)doButton34:(id)sender;
-(IBAction)doButton41:(id)sender;
-(IBAction)doButton42:(id)sender;
-(IBAction)doButton43:(id)sender;
-(IBAction)doButton44:(id)sender;
-(IBAction)doButton51:(id)sender;
-(IBAction)doButton52:(id)sender;
-(IBAction)doButton53:(id)sender;
-(IBAction)doButton54:(id)sender;

@end
