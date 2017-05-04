//
//  Utils.h
//  Lolz
//
//  Created by Rena Chen on 5/3/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject
+ (NSString*) createPathToDocumentDirectoryWithFilename:(NSString*)filename;
+ (NSString*) getCurrentTime;
@end
