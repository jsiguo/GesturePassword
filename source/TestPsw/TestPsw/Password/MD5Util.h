//
//  MD5Util.h
//  
//
//  Created by guosm on 13-8-9.
//  Copyright (c) 2013年 caitaner. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h> 

//md5 加密
@interface MD5Util : NSObject {

}

+ (NSString *) md5:(NSString *)str;
+ (NSString *) md5ForFileContent:(NSString *)file;
+ (NSString *) md5ForData:(NSData *)data;

@end
