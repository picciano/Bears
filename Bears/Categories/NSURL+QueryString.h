//
//  NSURL+QueryString.h
//  Bears
//
//  Created by Anthony Picciano on 8/12/14.
//  Copyright (c) 2014 Picciano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (QueryString)

- (NSDictionary *)queryStringDictionary;
- (NSString *)queryStringValueForKey:(NSString *)key;

@end
