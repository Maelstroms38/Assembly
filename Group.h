//
//  Group.h
//  Assembly
//
//  Created by Michael Stromer on 6/26/14.
//  Copyright (c) 2014 Michael Stromer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *who;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *city;
@end
