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
// Instantiate thread with all parameters.
- (instancetype) initWithCreator: (NSString*) creator imageName:(NSString*) imageName date:(NSString*) date instructions: (NSString*) instructions posts:(NSMutableArray*) posts closed: (BOOL) closed{
    self = [super init];
    self.creator = creator;
    self.imageName = imageName;
    self.date = date;
    self.instructions = instructions;
    self.posts = posts;
    self.closed = closed;
    return self;
}
// New thread with initial date and closed status.
- (instancetype) initWithCreator: (NSString*) creator imageName:(NSString*) imageName instructions:(NSString*)instructions{
    self = [super init];
    self.creator = creator;
    self.imageName = imageName;
    
    // set current date.
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [dateFormatter stringFromDate:[NSDate date]];
    self.date = date;
    
    self.instructions = @"";
    self.posts = [[NSMutableArray alloc] init];
    self.closed = false;
    return self;
}
- (void)updatePost: (Post *) post {
    for(Post *p in self.posts) {
        if([post.author isEqualToString:p.author]) {
            p.author = post.author;
            p.text = post.text;
            p.votes = post.votes;
            NSLog(@"update post");
        }
    }
}
// Get post at index.
- (Post*) postAtIndex:(NSUInteger)index {
    return [self.posts objectAtIndex:index];
}
- (Post*) addPost: (NSString*) text author:(NSString*) author votes:(NSUInteger)votes{
    if(!self.closed) {
        Post* post = [[Post alloc] initWithText:text author:author votes:votes];
        [self.posts addObject:post];
        NSLog(@"posted");
        return post;
    } else {
        NSLog(@"Thread closed, failed to post");
        return nil;
    }
}
// delete post at index.
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
