//
//  Post.m
//  Lolz
//
//  Created by Rena Chen on 5/1/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import "Post.h"

@interface Post()
@property NSUInteger votes; // Update when thread is closed.
@property (strong, nonatomic) NSString* author;
@property (strong, nonatomic) NSString* text;
@end

@implementation Post
- (instancetype) initWithText: (NSString*) text author: (NSString*) author {
    self = [super init];
    self.author = author;
    self.text = text;
    self.votes = 0;
    return self;
}

@end
