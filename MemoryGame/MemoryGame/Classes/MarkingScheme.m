//
//  MarkingScheme.m
//  MemoryGame
//
//  Created by Sai Pujitha & Arjun R on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MarkingScheme.h"
#import "FBConnect/FBConnect.h"

@implementation MarkingScheme

@synthesize marks;


static MarkingScheme *sharedScore = 0;
//+ (Score*)sharedScore;

+ (MarkingScheme*)sharedScore
{
	if (sharedScore == 0) 
	{
		NSLog(@"sharedScore..!!");
        sharedScore = [[super allocWithZone:NULL] init];		// initialize your variables here
		sharedScore.marks = 0;
    }
	
	NSLog(@"value returned..!!");
    return sharedScore;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self)
    {
        if (sharedScore == 0)
        {
            sharedScore = [super allocWithZone:zone];
            return sharedScore;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release {
    //do nothing
}
- (id)autorelease {
    return self;
}


@end
