//
//  AddThreadViewController.h
//  Lolz
//
//  Created by Rena Chen on 5/2/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CompletionHandler)(UIImage *image, NSString *instructions);

@interface AddThreadViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>
@property (copy, nonatomic) CompletionHandler completionHandler;

@end
