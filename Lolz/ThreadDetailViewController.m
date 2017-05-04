//
//  ThreadsDetailViewController.m
//  Lolz
//
//  Created by Rena Chen on 4/30/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import "ThreadDetailViewController.h"
#import "EditPostViewController.h"
#import "PostsTableViewCell.h"
#import "Utils.h"

@interface ThreadDetailViewController () <UITableViewDataSource, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *userSubmissionLabel;
@property (strong, nonatomic) NSMutableArray *postsWithoutUser;
@property (strong, nonatomic) Post *userPost;
@property (weak, nonatomic) IBOutlet UITableView *postsTableView;

@end

@implementation ThreadDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Set image.
    NSLog(@"Creator: %@", self.thread.creator);
    NSString *path = [Utils createPathToDocumentDirectoryWithFilename:self.thread.imageName];
    self.imageView.image = [UIImage imageWithContentsOfFile:path];
    
    // Configure posts.
    self.postsWithoutUser = [[NSMutableArray alloc] init];
    self.userPost = nil;
    self.userSubmissionLabel.text = @"";
    [self extractUserPost];
    if(self.userPost == nil) {
        NSLog(@"User post nil");
    }
    [self updateView];
    
    // Set table view
    //self.postsTableView.dataSource = self;
    //self.postsTableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*) findUserPost {
    for(Post *post in self.thread.posts) {
        if([post.author isEqualToString:self.user.username]) {
            return post.text;
        }
    }
    return @"";
};

- (void) extractUserPost {
    NSLog(@"extract user post: %u", [self.thread.posts count]);
    NSLog(@"username: %@", self.user.username);
    for(Post *post in self.thread.posts) {
        NSLog(@"found author: %@", post.author);
        if([post.author isEqualToString:self.user.username]) {
            self.userPost = post;
            NSLog(@"found user post: %@", post.author);
        } else if(![post.text isEqualToString:@""]){
            [self.postsWithoutUser addObject:post];
        }
    }

}

- (void) updateView {
    if(self.userPost != nil)
        self.userSubmissionLabel.text = self.userPost.text;
}

// ---------- [ TableView Datasource ] --------- //
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.postsWithoutUser count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostTableCell" forIndexPath:indexPath];
    //cell.post = [self.postsWithoutUser objectAtIndex:indexPath.row];
    //[cell create];
    Post *post = [self.postsWithoutUser objectAtIndex:indexPath.row];
    cell.textLabel.text = post.text;
    
    return cell;
    
}

// Checkmark
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"threadDetailToEditPostSegue"]) {
        EditPostViewController *editPostVC = segue.destinationViewController;
        editPostVC.text = self.userPost.text;
        editPostVC.completionHandler = ^(NSString *text) {
            NSLog(@"%@",text);
            // Create new userpost if didn't exist before.
            if(self.userPost == nil) {
                self.userPost = [self.thread addPost:text author:self.user.username votes:0];
            }
            else {
                self.userPost.text = text;
                [self.thread updatePost:self.userPost];
                
            }
            
            NSLog(@"%u", [self.thread.posts count]);
            // Update model.
            self.updateHandler(self.thread);
            
            // Update view.
            [self updateView];
            [self dismissViewControllerAnimated:YES completion:nil];
        };

    }
}


@end
