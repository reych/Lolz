//
//  ThreadsModel.m
//  Lolz
//
//  Created by Rena Chen on 5/1/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import "ThreadsModel.h"

@interface ThreadsModel()
@property (strong, nonatomic) NSMutableArray *threads;
@end

@implementation ThreadsModel

+ (instancetype) sharedModel {
    static ThreadsModel *tm = nil;
    if(tm == nil) {
        tm = [[ThreadsModel alloc] init];
    }
    return tm;
}

- (id) init {
    self = [super init];
    
    // do extra initialization.
    self.threads = [[NSMutableArray alloc] init];
    [self generateDummyData];
    
    return self;
}

- (NSUInteger) numberOfThreads {
    return [self.threads count];
}
- (Thread*) threadAtIndex: (NSUInteger) index {
    return self.threads[index];
}

- (void) generateDummyData {
    Thread* t1 = [[Thread alloc] initWithCreator:@"Anon" imagePath:@"something" date: @"05/01/17"];
    Thread* t2 = [[Thread alloc] initWithCreator:@"Anon2" imagePath:@"something" date: @"05/02/17"];
    Thread* t3 = [[Thread alloc] initWithCreator:@"Anon3" imagePath:@"something" date: @"05/01/17"];
    [self.threads addObject:t1];
    [self.threads addObject:t2];
    [self.threads addObject:t3];
}


@end
