//
//  MD5Util.h
//  
//
//  Created by guosm on 13-8-9.
//  Copyright (c) 2013年 caitaner. All rights reserved.
//

#import "MD5Util.h"


@implementation MD5Util

//md5 加密字符串
+ (NSString *) md5:(NSString *)str {
	
	if (str == nil) {
		return nil;
	}
	const char *cstr = [str UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(cstr, strlen(cstr), result);
	
	return [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], 
			result[2], result[3],
			result[4], result[5],
			result[6], result[7],
			result[8], result[9],
			result[10], result[11],
			result[12], result[13],
			result[14], result[15]];
}

//md5 加密文件内容
+ (NSString *) md5ForFileContent:(NSString *)file {
	
	if( nil == file ){

		return nil;
	}

	NSData * data = [NSData dataWithContentsOfFile:file];
	
	return [MD5Util md5ForData:data];
}

//md5 加密data
+ (NSString *) md5ForData:(NSData *)data{
	
	if( !data || ![data length] ) {
		return nil;
	}
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	
    CC_MD5([data bytes], [data length], result);
	
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]];
}
@end
