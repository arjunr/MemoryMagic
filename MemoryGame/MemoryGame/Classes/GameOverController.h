//
//  GameOverController.h
//  MemoryGame
//
//  Created by Sai Pujitha & Arjun R on 6/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect/FBConnect.h"
#import "FacebookController.h"

@interface GameOverController : UIViewController {

	UIButton *postOnFbYes;
	UIButton *cancel;
	
}

@property (nonatomic, retain) IBOutlet UIButton *postOnFbYes;
@property (nonatomic, retain) IBOutlet UIButton *cancel;

-(IBAction)doPostOnFb:(id)sender;
-(IBAction)doCancel:(id)sender;

@end