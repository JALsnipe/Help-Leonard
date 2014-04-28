//
//  JALViewController.h
//  Help-Leonard
//
//  Created by Josh Lieberman on 4/27/14.
//  Copyright (c) 2014 Josh Lieberman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JALViewController : UIViewController
- (IBAction)tweetButton:(id)sender;
- (IBAction)teamURLButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *teamTextField;

@end
