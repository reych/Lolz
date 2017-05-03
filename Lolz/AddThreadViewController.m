//
//  AddThreadViewController.m
//  Lolz
//
//  Created by Rena Chen on 5/2/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import "AddThreadViewController.h"

@interface AddThreadViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *instructionsTextView;

@end

@implementation AddThreadViewController

// --------------- [ IBActions ] -------------- //
- (IBAction)addImage:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}
- (IBAction)cancelButtonDidPress:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
- (IBAction)doneButtonDidPress:(UIBarButtonItem *)sender {
    UIImage* image = self.imageView.image;
    NSString* instructions = self.instructionsTextView.text;
    
    self.completionHandler(image, instructions);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// --------- [ ImagePicker Delegates ] -------- //
- (void) imagePickerController: (UIImagePickerController *)picker
 didFinishPickingMediaWithInfo: (NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    self.imageView.image = originalImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *)
picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


// --------- [ TextView Delegates ] -------- //
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.instructionsTextView resignFirstResponder];
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
