//
//  EditPostViewController.h
//  Lolz
//
//  Created by Rena Chen on 4/30/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditPostCompletionHandler)(NSString *text);

@interface EditPostViewController : UIViewController
@property EditPostCompletionHandler completionHandler;
@property NSString *text;

@end
