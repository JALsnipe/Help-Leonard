//
//  JALAppDelegate.m
//  Help-Leonard
//
//  Created by Josh Lieberman on 4/27/14.
//  Copyright (c) 2014 Josh Lieberman. All rights reserved.
//

#import "JALAppDelegate.h"
#import "JALHeadline.h"
#import "JALHeadlinesTableViewController.h"

static NSString *ESPNAPIKey = @"zheuk35rcn3t43ukfgejpwph";

NSArray* parsedHeadlines;
NSArray* parsedSports;
NSArray* parsedURLs;

@implementation JALAppDelegate
{
    NSMutableArray *_headlines;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    _headlines = [NSMutableArray arrayWithCapacity:20];
    
    // for headline in parsedHeadlines
    // alloc headline object
    // add headline to object
    // add sport dummy type to object
    // add url to object
    
    // get headlines
    [self getHeadlines];
    
    // url debugging
    NSLog(@"start printing urls");
    for (NSString *url in parsedURLs) {
        NSLog(@"%@\n", url);
    }
    NSLog(@"end printing urls");
    
    // add url and headline to table
    for(int i = 0; i < [parsedHeadlines count]; i++) {
        JALHeadline *headline = [[JALHeadline alloc] init];
        headline.title = [parsedHeadlines objectAtIndex: i];
        headline.sport = @"Sports";
        headline.URL = [parsedURLs objectAtIndex: i];
        
        [_headlines addObject:headline];

    }
    
//    for (NSString *title in parsedHeadlines) {
//        JALHeadline *headline = [[JALHeadline alloc] init];
//        headline.title = title;
//        headline.sport = @"Sports";
//        //    headline.URL = @"http://myawesomesite.com/";
//        
//        for (NSString *url in parsedURLs) {
//            //            NSURL *baseURL = [NSURL URLWithString:@"file:///path/to/web_root/"];
//            //            NSURL *url = [NSURL URLWithString:@"folder/file.html" relativeToURL:baseURL];
////            NSURL *absURL = url;
////            headline.URL = absURL;
//            NSLog(@"in parsed urls\n");
//            NSLog(@"url: %@\n", url);
//            headline.URL = url;
//        }
//    
//        
//    }
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UINavigationController *navigationController = [tabBarController viewControllers][0];
    JALHeadlinesTableViewController *headlinesViewController = [navigationController viewControllers][0];
    headlinesViewController.headlines = _headlines;
    
    return YES;
}

- (void)getHeadlines
{
    // Get headlines from ESPN Headline API
    //-- Make URL request with server
    NSHTTPURLResponse *response = nil;
    NSString *jsonUrlString = [NSString stringWithFormat:@"http://api.espn.com/v1/sports/news/headlines?apikey=%@", ESPNAPIKey];
    
    NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //-- Get request and response though URL
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSError *error = [[NSError alloc] init];
    
    // error handling
    if([response statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [response statusCode]);
    }
    
    //Hopefully we succeeded
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    //    NSArray* parsedHeadlines = [jsonDictionary valueForKeyPath:@"sports.leagues.teams"];
    //    NSArray* parsedHeadlines = [jsonDictionary valueForKeyPath:@"headlines.headline"];
    
    // have 3 arrays, articles titles, sport, and URL
    parsedHeadlines = [jsonDictionary valueForKeyPath:@"headlines.headline"];
    parsedSports = [jsonDictionary valueForKeyPath:@"headlines.categories.description"]; // this is broken
    parsedURLs = [jsonDictionary valueForKeyPath:@"headlines.links.mobile.href"];
    
    NSLog(@"printing parsedHeadlines\n");
    NSLog(@"%@\n)", parsedHeadlines);
    NSLog(@"printing parsedSports\n");
    NSLog(@"%@\n)", parsedSports);
    NSLog(@"printing parsedURLs\n");
    NSLog(@"%@\n)", parsedURLs);

    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
