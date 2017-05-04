//
//  ThreadsTableViewController.m
//  Lolz
//
//  Created by Rena Chen on 4/30/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import "ThreadsTableViewController.h"
#import "ThreadsModel.h"
#import "AddThreadViewController.h"
#import "ThreadDetailViewController.h"
#import "Utils.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ThreadsTableViewController ()
@property (strong, nonatomic) ThreadsModel* threadsModel;
@end

@implementation ThreadsTableViewController
- (IBAction)menuButtonDidPress:(UIBarButtonItem *)sender {
    [[FBSDKLoginManager new] logOut];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.threadsModel = [ThreadsModel sharedModel];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 self.user = [[User alloc] initWithName:result[@"name"]];
             }
         }];
    } else {
        NSLog(@"Normal logged in %@", self.user.username);
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.threadsModel numberOfThreads];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThreadTableCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Thread* t = [self.threadsModel threadAtIndex:indexPath.row];
    NSString* title = [NSString stringWithFormat:@"Image by %@", t.creator];
    cell.textLabel.text = title;
    
    NSString *path = [Utils createPathToDocumentDirectoryWithFilename:t.imageName];
    
    cell.imageView.image = [UIImage imageWithContentsOfFile:path];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier  isEqual: @"threadsTableToAddThreadSegue"]) {
        AddThreadViewController* addThreadVC = segue.destinationViewController;
        
        // completion handler
        addThreadVC.completionHandler = ^(NSString* imageName, NSString *instructions){
            // create a thread with the image.
            NSLog(@"In completion handler");
            [self.threadsModel insertWithCreator:self.user.username imageName:imageName instructions:instructions];
            [self.tableView reloadData];
            [self dismissViewControllerAnimated:YES completion:nil];
        };
    } else if([segue.identifier isEqual: @"threadToDetailSegue"]) {
        ThreadDetailViewController * threadDetailVC = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Thread *currentThread = [self.threadsModel threadAtIndex:indexPath.row];
        threadDetailVC.thread = currentThread;
        threadDetailVC.user = self.user;
        threadDetailVC.updateHandler = ^(Thread *thread) {
            [self.threadsModel updateThreadAtIndex:indexPath.row updatedThread:thread];
            
        };
        
    }
    
    
}


@end
