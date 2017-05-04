//
//  LoginViewController.m
//  Lolz
//
//  Created by Rena Chen on 5/2/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import "ThreadsTableViewController.h"

@interface LoginViewController () <FBSDKLoginButtonDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UIView *FBView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSMutableArray *users;
@property BOOL successfulNormalLogin;

@end

@implementation LoginViewController
- (IBAction)loginDidPress:(UIButton *)sender {
    NSLog(@"Anonymous login");
    if([self verifyLogin]) {
        self.successfulNormalLogin = YES;
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.readPermissions = @[@"public_profile"];//, @"email", @"user_friends"];
    loginButton.delegate = self;
    
    loginButton.center = self.FBView.center;
    [self.view addSubview:loginButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    // Reset
    self.passwordTextField.text = @"";
    
    NSLog(@"View did appear");
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
        NSLog(@"already logged in");
    }

}

- (BOOL) verifyLogin {
    NSString *filename = @"Users";
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    self.users = [NSMutableArray arrayWithContentsOfFile:path];
    NSLog(@"number of users: %i", [self.users count]);
    for(NSDictionary *d in self.users) {
        if([self.usernameTextField.text isEqualToString: d[@"name"]] && [self.passwordTextField.text isEqualToString:d[@"password"]]) {
            self.user = [[User alloc] initWithName: self.usernameTextField.text];
            NSLog(@"found user: %@", self.user.username);
            return YES;
        }
    }
    return NO;
}

// ------ [ Facebook Login Delegate ] ------ //
- (void) loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
        NSLog(@"already logged in");
    }
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    NSLog(@"Logged out");
}

// ----- [ Textfield Delegate ] ------- //
- (BOOL)textFieldShouldReturn: (UITextField *)textField {
    [textField resignFirstResponder];
    
    NSLog(@"%@", textField.text);
    return YES;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
}

#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"loginSegue"]) {
        UINavigationController *navController = (UINavigationController*)[segue destinationViewController];
        ThreadsTableViewController *threadsTableVC = (ThreadsTableViewController *)[navController topViewController];
        
        if(self.successfulNormalLogin) {
            NSLog(@"successful normal login %@", self.user.username);
            threadsTableVC.user = self.user;
        }
        
        self.successfulNormalLogin = false;
        //threadsTableVC.user = self.user;
    }
}



@end
