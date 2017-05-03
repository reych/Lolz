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
- (void) insertWithCreator:(NSString*)creator image:(UIImage*)image instructions:(NSString*)instructions;

@end
