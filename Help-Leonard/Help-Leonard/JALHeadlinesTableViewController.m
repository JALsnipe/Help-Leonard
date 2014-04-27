//
//  JALHeadlinesTableViewController.m
//  Help-Leonard
//
//  Created by Josh Lieberman on 4/27/14.
//  Copyright (c) 2014 Josh Lieberman. All rights reserved.
//

#import "JALHeadlinesTableViewController.h"
#import "JALHeadline.h"

@interface JALHeadlinesTableViewController ()

@end

@implementation JALHeadlinesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.headlines count];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadlineCell"];
    
    JALHeadline *headline = (self.headlines)[indexPath.row];
    cell.textLabel.text = headline.title;
    cell.detailTextLabel.text = headline.sport;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark = Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([super respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        NSLog(@"reachable code?");
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        JALHeadline *tappedItem = [self.headlines objectAtIndex:indexPath.row];
        NSLog(@"url: %@\n", tappedItem.URL);
        
        // open URL in Safari
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tappedItem.URL]];
    }
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    JALHeadline *tappedItem = [self.headlines objectAtIndex:indexPath.row];
//    tappedItem.completed = !tappedItem.completed;
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    // open URL of tapped item in
    // this is jenky as shit, try to look into fixing.
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tappedItem.URL]];
    
    // remove href from string
//    static NSRegularExpression *regex;
//    
//    regex = [NSRegularExpression regularExpressionWithPattern:@"<a[^>]+href=\"(.*?)\"[^>]*>.*?</a>" options:NSRegularExpressionCaseInsensitive error:nil];;
//    
//    NSString* modifiedString = [regex stringByReplacingMatchesInString:tappedItem.URL options:0 range:NSMakeRange(0, [tappedItem.URL length]) withTemplate:@"$1"];
////    NSLog(@"URL: %@\n", modifiedString);
//    NSLog(@"test\n");

    
}

@end
