//
//  JALAppDelegate.h
//  Help-Leonard
//
//  Created by Josh Lieberman on 4/27/14.
//  Copyright (c) 2014 Josh Lieberman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JALAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(NSString *)getTeamName;
-(NSString *)getTeamURL;

@end
