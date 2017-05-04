//
//  Post.m
//  Lolz
//
//  Created by Rena Chen on 5/1/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import "Post.h"

@interface Post()
@end

@implementation Post
- (instancetype) initWithText: (NSString*) text author: (NSString*) author votes:(NSUInteger) votes{
    self = [super init];
    self.author = author;
    self.text = text;
    self.votes = votes;
    return self;
}

@end
