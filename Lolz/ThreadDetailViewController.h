//
//  ThreadsDetailViewController.h
//  Lolz
//
//  Created by Rena Chen on 4/30/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Thread.h"
#import "User.h"

typedef void(^UpdateThreadHandler)(Thread *thread);
@interface ThreadDetailViewController : UIViewController <UITableViewDataSource, UITableViewDataSource>
@property (strong, nonatomic) Thread *thread;
@property (strong, nonatomic) User *user;
@property UpdateThreadHandler updateHandler;
@end
