//
//  Thread.m
//  Lolz
//
//  Created by Rena Chen on 4/30/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import "Thread.h"
@interface Thread()

@end

@implementation Thread
- (instancetype) initWithCreator: (NSString*) creator imagePath:(NSString*) imagePath date:(NSString*) date {
    self = [super init];
    self.creator = creator;
    self.imagePath = imagePath;
    self.date = date;
    self.closed = false;
    return self;
}
- (instancetype) initWithCreator: (NSString*) creator image:(UIImage*) image date:(NSString*) date {
    self = [super init];
    self.creator = creator;
    self.image = image;
    self.date = date;
    self.closed = false;
    return self;
}
- (Post*) postAtIndex:(NSUInteger)index {
    return [self.posts objectAtIndex:index];
}
- (void) addPost: (NSString*) text author:(NSString*) author {
    if(!self.closed) {
        Post* post = [[Post alloc] initWithText:text author:text];
        [self.posts addObject:post];
        NSLog(@"posted");
    } else {
        NSLog(@"Thread closed, failed to post");
    }
}
- (void) deletePostAtIndex: (NSUInteger) index {
    [self.posts removeObjectAtIndex:index];
}
- (NSUInteger) numberOfPosts {
    return [self.posts count];
}
- (void) closeThread {
    self.closed = true;
}
@end
