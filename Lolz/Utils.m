//
//  Utils.m
//  Lolz
//
//  Created by Rena Chen on 5/3/17.
//  Copyright © 2017 Rena Chen. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+ (NSString*) createPathToDocumentDirectoryWithFilename:(NSString*)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *slashFilename = [[NSString alloc] initWithFormat:@"/%@", filename];
    NSString *path = [[paths objectAtIndex:0] stringByAppendingString:slashFilename];
    return path;
}
+ (NSString*) getCurrentTime {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSString *date = [dateFormatter stringFromDate:[NSDate date]];
    return date;
}
@end
