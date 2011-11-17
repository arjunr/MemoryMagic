//
//  StartupPageController.h
//  MemoryGame
//
//  Created by Sai Pujitha & Arjun R on 6/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect/FBConnect.h"


@interface StartupPageController : UIViewController {

	UIImage *startupImage;
	UIButton *play;
}

@property (nonatomic, retain) IBOutlet UIButton *play;
@property (nonatomic, retain) IBOutlet UIImage *startupImage;

-(IBAction)doPlay:(id)sender;


@end
