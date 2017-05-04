//
//  Post.h
//  Lolz
//
//  Created by Rena Chen on 5/1/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject
@property NSUInteger votes; // Update when thread is closed.
@property (strong, nonatomic) NSString* author;
@property (strong, nonatomic) NSString* text;

- (instancetype) initWithText: (NSString*) text author: (NSString*) author votes:(NSUInteger)votes;
@end
