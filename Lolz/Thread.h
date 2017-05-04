//
//  Thread.h
//  Lolz
//
//  Created by Rena Chen on 4/30/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Post.h"

@interface Thread : NSObject
@property (strong, nonatomic) NSString* creator;
@property (strong, nonatomic) NSString* imageName;
@property (strong, nonatomic) NSString* date;
@property (strong, nonatomic) NSMutableArray* posts;
@property (strong, nonatomic) NSString *instructions;
@property BOOL closed;

- (instancetype) initWithCreator: (NSString*) creator imageName:(NSString*) imageName date:(NSString*) date instructions: (NSString*) instructions posts:(NSMutableArray*) posts closed: (BOOL) closed;
- (instancetype) initWithCreator: (NSString*) creator imageName:(NSString*) imageName instructions:(NSString*) instructions;
- (void)updatePost: (Post *) post;
- (Post*) postAtIndex: (NSUInteger) index;
- (Post*) addPost: (NSString*) text author:(NSString*) author votes:(NSUInteger)votes;
- (void) deletePostAtIndex: (NSUInteger) index;
- (NSUInteger) numberOfPosts;

@end
