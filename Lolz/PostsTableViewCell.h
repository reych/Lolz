//
//  PostsTableViewCell.h
//  Lolz
//
//  Created by Rena Chen on 5/3/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface PostsTableViewCell : UITableViewCell
@property Post *post;

- (void) create;

@end
