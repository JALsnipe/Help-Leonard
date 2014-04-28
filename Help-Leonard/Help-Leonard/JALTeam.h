//
//  JALTeam.h
//  Help-Leonard
//
//  Created by Josh Lieberman on 4/27/14.
//  Copyright (c) 2014 Josh Lieberman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JALTeam : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *league;
@property (nonatomic, copy) NSString *teamID; // does this need to be int?  cast to int later?
@property (nonatomic, copy) NSString *sport;

@end
