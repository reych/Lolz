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
@property (strong, nonatomic) NSString *threadsFilepath;
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
    
    if(self) {
        // Database
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *filename = @"threads.plist";
        self.threadsFilepath = [path stringByAppendingPathComponent:filename];
        NSMutableArray *pThreads = [NSMutableArray arrayWithContentsOfFile:self.threadsFilepath];
        self.threads = [[NSMutableArray alloc] init];
        
        // If threads isn't in database, then create
        if(!pThreads) {
            // Initialize array.
            self.threads = [[NSMutableArray alloc] init];
            //[self generateDummyData];
            NSLog(@"Generating dummy data");
        } else {
            for(NSDictionary *pThread in pThreads) {
                // Create posts array.
                NSMutableArray *posts = [[NSMutableArray alloc] init];
                for(NSDictionary *pPost in pThread[@"posts"]) {
                    Post *post = [[Post alloc] initWithText:pPost[@"text"] author:pPost[@"author"] votes:[pPost[@"votes"] unsignedIntegerValue]];
                    [posts addObject:post];
                }
                // Create Thread
                [self insertWithCreator:pThread[@"creator"] imageName:pThread[@"imageName"] date:pThread[@"date"] instructions:pThread[@"instructions"] posts:posts closed:[pThread[@"closed"] boolValue]];
            }
        }
        
        
    }
    
    
    return self;
}

- (NSUInteger) numberOfThreads {
    return [self.threads count];
}
- (Thread*) threadAtIndex: (NSUInteger) index {
    return self.threads[index];
}
- (void) updateThreadAtIndex: (NSUInteger) index updatedThread:(Thread *) updatedThread {
    Thread *t = [self.threads objectAtIndex:index];
    t.posts = updatedThread.posts;
    t.closed = updatedThread.closed;
    NSLog(@"update thread at index");
    [self saveToDatabase];
}

- (void) insertWithCreator:(NSString*)creator imageName:(NSString*)imageName instructions:(NSString*)instructions {
    Thread *t = [[Thread alloc] initWithCreator:creator imageName:imageName instructions:instructions];
    [self.threads addObject:t];
    
    [self saveToDatabase];
}

- (void) insertWithCreator:(NSString*) creator imageName:(NSString*) imageName date:(NSString*) date instructions: (NSString*) instructions posts:(NSMutableArray*) posts closed: (BOOL) closed {
    Thread *t = [[Thread alloc] initWithCreator:creator imageName:imageName date:date instructions:instructions posts: posts closed: closed];
    [self.threads addObject:t];
    
    [self saveToDatabase];
}

- (void) generateDummyData {
    Thread* t1 = [[Thread alloc] initWithCreator:@"Anon1" imageName:@"something" instructions:@"Do as you will"];
    Thread* t2 = [[Thread alloc] initWithCreator:@"Anon2" imageName:@"something" instructions:@""];
    Thread* t3 = [[Thread alloc] initWithCreator:@"Anon3" imageName:@"something" instructions:@"No curse words, please"];
    [self.threads addObject:t1];
    [self.threads addObject:t2];
    [self.threads addObject:t3];
}

- (void) saveToDatabase {
    NSMutableArray *pThreadArray = [[NSMutableArray alloc] init];
    for(Thread *t in self.threads) {
        // Create Post dictionaries and put into array of the Thread.
        NSMutableArray *pPostArray = [[NSMutableArray alloc] init];
        for(Post *p in t.posts) {
            NSDictionary *pPostDictionary = @{@"text":p.text,
                                              @"author":p.author,
                                              @"votes":[[NSNumber alloc] initWithUnsignedInt:p.votes]
                                              };
            [pPostArray addObject:pPostDictionary];
        }
        // Create Thread dictionary and put into array.
        NSDictionary *pThreadDictionary = @{@"imageName": t.imageName,
                                            @"instructions":t.instructions,
                                            @"creator": t.creator,
                                            @"posts": pPostArray,
                                            @"date": t.date,
                                            @"closed": [[NSNumber alloc] initWithBool:t.closed]
                                      };
        [pThreadArray addObject:pThreadDictionary];
    }
    [pThreadArray writeToFile: self.threadsFilepath atomically:YES];
}


@end
