//
//  ThreadsModel.h
//  Lolz
//
//  Created by Rena Chen on 5/1/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Thread.h"

@interface ThreadsModel : NSObject

+ (instancetype) sharedModel;

- (NSUInteger) numberOfThreads;
- (Thread *) threadAtIndex: (NSUInteger) index;
- (void) updateThreadAtIndex: (NSUInteger) index updatedThread:(Thread *) updatedThread;
- (void) insertWithCreator:(NSString*)creator imageName:(NSString*)imageName instructions:(NSString*)instructions;
- (void) insertWithCreator:(NSString*) creator imageName:(NSString*) imageName date:(NSString*) date instructions: (NSString*) instructions posts:(NSMutableArray*) posts closed: (BOOL) closed;

@end
