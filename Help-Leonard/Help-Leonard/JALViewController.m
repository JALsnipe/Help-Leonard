//
//  JALViewController.m
//  Help-Leonard
//
//  Created by Josh Lieberman on 4/27/14.
//  Copyright (c) 2014 Josh Lieberman. All rights reserved.
//

#import "JALViewController.h"
#import "JALAppDelegate.h"

@interface JALViewController ()

@end

@implementation JALViewController {
    NSString *team;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // get team info from AppDelegate
    JALAppDelegate *appDelegate = (JALAppDelegate *)[[UIApplication sharedApplication] delegate];
    team = [appDelegate getTeamName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tweetButton:(id)sender {
    //twitter button
    NSLog(@"hit button\n");
//    [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://post?message=hello%20from%20Help-Leonard!"]];
    
    NSString *URLbase = @"twitter://post?message=Hello%20from%20Help-Leonard!%20I%20love%20the%20";
    NSString *URLend = @"!";
    
    NSString *constructURL = [NSString stringWithFormat:@"%@%@%@", URLbase, team, URLend];
    
    NSLog(@"constructing URL: %@\n", constructURL);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:constructURL]];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://post?message=I%20love%20the%20Yankees!"]];
}

@end
