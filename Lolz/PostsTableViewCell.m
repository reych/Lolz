//
//  PostsTableViewCell.m
//  Lolz
//
//  Created by Rena Chen on 5/3/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import "PostsTableViewCell.h"
@interface PostsTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end
@implementation PostsTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) create {
    self.textLabel.text = self.post.text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
