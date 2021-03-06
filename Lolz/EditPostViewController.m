//
//  EditPostViewController.m
//  Lolz
//
//  Created by Rena Chen on 4/30/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import "EditPostViewController.h"

@interface EditPostViewController ()
@property (weak, nonatomic) IBOutlet UITextView *postTextView;

@end

@implementation EditPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.postTextView.text = self.text;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelButtonDidPress:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
- (IBAction)doneButtonDidPress:(UIBarButtonItem *)sender {
    self.completionHandler(self.postTextView.text);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
