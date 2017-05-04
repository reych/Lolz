//
//  User.m
//  Lolz
//
//  Created by Rena Chen on 5/2/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import "User.h"

@implementation User
- (instancetype) initWithName:(NSString*) username {
    self = [[User alloc] init];
    _username = username;
    return self;
}
@end
