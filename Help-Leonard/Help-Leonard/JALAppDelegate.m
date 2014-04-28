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

#import "JALTeam.h"
#import "JALTeamHeadlinesTableViewController.h"

static NSString *ESPNAPIKey = @"zheuk35rcn3t43ukfgejpwph";

NSArray *parsedHeadlines;
NSArray *parsedSports;
NSArray *parsedURLs;

NSString *teamID;
NSString *teamSport;
NSString *teamLeague;
NSString *teamName;

@implementation JALAppDelegate
{
    NSMutableArray *_headlines;
    NSMutableArray *_teamHeadlines;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    _headlines = [NSMutableArray arrayWithCapacity:20];
    _teamHeadlines = [NSMutableArray arrayWithCapacity:20];
    
    // for headline in parsedHeadlines
    // alloc headline object
    // add headline to object
    // add sport dummy type to object
    // add url to object
    
    // get headlines
    NSLog(@"trying to get headlines...\n");
    [self getHeadlines];
    NSLog(@"end of trying to get headlines...\n");

    // parallel arrays aren't the best programming paradigm
    // I'm also assuming that my API call won't screw up, and I'll get the same number
    // of headline titles and URLs.
    // TODO: implement checks.
    
    // add url and headline to table
    NSLog(@"adding url and headline to table...\n");
    for(int i = 0; i < [parsedHeadlines count]; i++) {
        JALHeadline *headline = [[JALHeadline alloc] init];
        headline.title = [parsedHeadlines objectAtIndex: i];
        headline.sport = @"Sports";
        headline.URL = [parsedURLs objectAtIndex: i];
        
        [_headlines addObject:headline];

    }
    // Headline controller
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UINavigationController *navigationController = [tabBarController viewControllers][0];
    JALHeadlinesTableViewController *headlinesViewController = [navigationController viewControllers][0];
    headlinesViewController.headlines = _headlines;
    
    // team headlines
    // lookup team id from sport, league team name
    // filter headlines by team id
    
    NSLog(@"getting teamID...\n");
    [self getTeamID];
    NSLog(@"getting team headlines...\n");
    [self getTeamHeadlines];
    
    // Headline controller
//    UITabBarController *tabBarControllerTeam = (UITabBarController *)self.window.rootViewController;
//    UINavigationController *navigationControllerTeam = [tabBarControllerTeam viewControllers][0];
//    JALHeadlinesTableViewController *headlinesViewControllerTeam = [navigationControllerTeam viewControllers][0];
//    headlinesViewControllerTeam.headlines = _teamHeadlines;
    
//    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UINavigationController *navigationControllerTeam = [tabBarController viewControllers][1];
    JALTeamHeadlinesTableViewController *headlinesViewControllerTeam = [navigationControllerTeam viewControllers][0];
    headlinesViewControllerTeam.teamHeadlines = _teamHeadlines;
    
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
    // TODO: Have an alert pop up to the user saying there was an issue retrieving headlines
    if([response statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [response statusCode]);
    }
    
    //Hopefully we succeeded
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    // have 3 arrays, articles titles, sport, and URL
    parsedHeadlines = [jsonDictionary valueForKeyPath:@"headlines.headline"];
    parsedSports = [jsonDictionary valueForKeyPath:@"headlines.categories.description"]; // this is broken
    parsedURLs = [jsonDictionary valueForKeyPath:@"headlines.links.mobile.href"];
    
    // Debug
//    NSLog(@"printing parsedHeadlines\n");
//    NSLog(@"%@\n)", parsedHeadlines);
//    NSLog(@"printing parsedSports\n");
//    NSLog(@"%@\n)", parsedSports);
//    NSLog(@"printing parsedURLs\n");
//    NSLog(@"%@\n)", parsedURLs);

    
}

// there is some reused code in these calls.
// TODO: make general API call method
- (void)getTeamID
{
    
    JALTeam *favTeam = [[JALTeam alloc] init];
    // need to get this info from user
    favTeam.sport = @"baseball";
    favTeam.league = @"mlb";
    favTeam.name = @"Yankees";
    teamSport = favTeam.sport;
    teamLeague = favTeam.league;
    teamName = favTeam.name;
    
    //http://api.espn.com/v1/sports/baseball/mlb/teams/?apikey=zheuk35rcn3t43ukfgejpwph
    // set up API call
    NSHTTPURLResponse *response = nil;
    NSString *jsonUrlString = [NSString stringWithFormat:@"http://api.espn.com/v1/sports/%@/%@/teams/?apikey=%@", favTeam.sport, favTeam.league, ESPNAPIKey];
    
    // ecnode URL
    NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //-- Get request and response though URL
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSError *error = [[NSError alloc] init];
    
    // error handling
    // TODO: Have an alert pop up to the user saying there was an issue retrieving headlines
    if([response statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [response statusCode]);
    }
    
    //Hopefully we succeeded
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    //debug
//    NSLog(@"printing team jsonDict\n");
//    NSLog(@"%@\n", jsonDictionary);
    
//    teamID = [objectsOrNil[0] objectForKey:(favTeam.name)];
//    teamID = [jsonDictionary objectForKey:favTeam.name];
    
//    NSLog(@"first dict\n");
//    NSDictionary* teamInfo = [jsonDictionary valueForKeyPath:@"sports.leagues.teams"]; // gets all team objects
    NSArray *teamInfo = [jsonDictionary valueForKeyPath:@"sports.leagues.teams.name"]; // gets all team objects

//    NSLog(@"team info: %@\n", teamInfo);
    
    // I'm struggling with the JSON here.  This is a jenky workaround to get each team as a single
    // string element in an NSArray.
    NSArray *teamParsed = teamInfo[0][0];
//    NSLog(@"teamParsed: %@\n", teamParsed);
    
    // there should be a way to just get the Yankee object, not sure how to do that.
    
    // janky workaround
    // make array of teams
    // get index of team name we're looking for, add 1 and we have their id.
    
    NSInteger teamIndex = [teamParsed indexOfObject:favTeam.name];
    if(NSNotFound == teamIndex) {
        NSLog(@"team not found");
        // I'll use -1 for teamID to indicate an error
        teamID = [NSString stringWithFormat: @"%d", (int)-1];
        favTeam.teamID = teamID;
    } else {
        teamIndex++;
        teamID = [NSString stringWithFormat: @"%d", (int)teamIndex];
        favTeam.teamID = teamID;
    }
    
}

- (void)getTeamHeadlines
{
    // Get headlines from ESPN Headline API
    //-- Make URL request with server
    
    // http://api.espn.com/v1/sports/baseball/mlb/news/?teams=10&apikey=zheuk35rcn3t43ukfgejpwph
    NSHTTPURLResponse *response = nil;
    NSString *jsonUrlString = [NSString stringWithFormat:@"http://api.espn.com/v1/sports/%@/%@/news/?teams=%@&apikey=%@", teamSport, teamLeague, teamID, ESPNAPIKey];
    
    NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@\n", url);
    
    //-- Get request and response though URL
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSError *error = [[NSError alloc] init];
    
    // error handling
    // TODO: Have an alert pop up to the user saying there was an issue retrieving headlines
    if([response statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [response statusCode]);
    }
    
    //Hopefully we succeeded
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    // have 3 arrays, articles titles, sport, and URL
    parsedHeadlines = [jsonDictionary valueForKeyPath:@"headlines.headline"];
    parsedSports = [jsonDictionary valueForKeyPath:@"headlines.categories.description"]; // this is broken
    parsedURLs = [jsonDictionary valueForKeyPath:@"headlines.links.mobile.href"];
    
    // Debug
    //    NSLog(@"printing parsedHeadlines\n");
    //    NSLog(@"%@\n)", parsedHeadlines);
    //    NSLog(@"printing parsedSports\n");
    //    NSLog(@"%@\n)", parsedSports);
    //    NSLog(@"printing parsedURLs\n");
    //    NSLog(@"%@\n)", parsedURLs);
    
    for(int i = 0; i < [parsedHeadlines count]; i++) {
        JALHeadline *headline = [[JALHeadline alloc] init];
        headline.title = [parsedHeadlines objectAtIndex: i];
        headline.sport = @"MLB";
        headline.URL = [parsedURLs objectAtIndex: i];
        
        [_teamHeadlines addObject:headline];
        
    }
}

-(NSString *)getTeamName
{
    return teamName;
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
