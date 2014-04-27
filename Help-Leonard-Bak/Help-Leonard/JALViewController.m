//
//  JALViewController.m
//  Help-Leonard
//
//  Created by Josh Lieberman on 4/17/14.
//  Copyright (c) 2014 Josh Lieberman. All rights reserved.
//

#import "JALViewController.h"

@interface JALViewController()

@end

@implementation JALViewController

NSArray *tableContents;
static NSString *ESPNAPIKey = @"zheuk35rcn3t43ukfgejpwph";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self simpleJsonParsing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableContents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableContents objectAtIndex:indexPath.row];
    // prevent label cutoff?
    cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    cell.textLabel.numberOfLines = 0; // this is not entirly correct, still getting some cutoff
    return cell;
    
    //TODO: Allow user to tap headline which loads article URL in Safari.
}

// http://stackoverflow.com/questions/19404327/json-parsing-in-ios-7
- (void)simpleJsonParsing
{
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
    tableContents = [jsonDictionary valueForKeyPath:@"headlines.headline"];
    NSLog(@"printing jsonDict\n");
    NSLog(@"%@\n)", jsonDictionary);
    NSLog(@"printing parsed headlines in tableContents\n");
    NSLog(@"%@\n)", tableContents);
//    NSLog(@"%@\n)", parsedHeadlines);
    
//    NSMutableArray*sortedTeams = [[NSMutableArray alloc] init];
    
    // for title in headlines?
    // for headline in headlines
//    for(NSArray* sport in parsedTeams){
//        for (NSArray*league in sport) {
//            for (NSDictionary*team in league) {
//                Team* addedTeam = [Team TeamFromESPN:team];
//                [sortedTeams addObject:addedTeam];
//            }
//        }
//    }
    
    //-- JSON Parsing
//    NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"Result = %@",result);
//    
//    for (NSMutableDictionary *dic in result)
//    {
//        NSString *string = dic[@"array"];
//        if (string)
//        {
//            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
//            dic[@"array"] = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        }
//        else
//        {
//            NSLog(@"Error in url response");
//        }
//    }
    // create table view controller, then do something like this (using parsedHeadlines):
    // arrItems = [[NSArray alloc] initWithObjects:@"Item 1",@"Item 2",@"Item3", nil];
    
}

@end
