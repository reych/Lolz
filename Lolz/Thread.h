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
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* creator;
@property (strong, nonatomic) NSString* imagePath;
@property (strong, nonatomic) NSString* date;
@property (strong, nonatomic) NSMutableArray* posts;
@property (strong, nonatomic) UIImage* image;
@property BOOL closed;

- (instancetype) initWithCreator: (NSString*) creator imagePath:(NSString*) imagePath date:(NSString*) date;
- (instancetype) initWithCreator: (NSString*) creator image:(UIImage*) image date:(NSString*) date;
- (Post*) postAtIndex: (NSUInteger) index;
- (void) addPost: (NSString*) text author:(NSString*) author;
- (void) deletePostAtIndex: (NSUInteger) index;
- (NSUInteger) numberOfPosts;

@end
