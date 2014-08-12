//
//  NSURL+QueryString.m
//  Bears
//
//  Created by Anthony Picciano on 8/12/14.
//  Copyright (c) 2014 Picciano. All rights reserved.
//

#import "NSURL+QueryString.h"

@implementation NSURL (QueryString)

NSMutableDictionary *qsDict;

- (NSDictionary *)queryStringDictionary
{
    if (!qsDict) {
        qsDict = [[NSMutableDictionary alloc] init];
        NSArray *urlComponents = [self.query componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents)
        {
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents objectAtIndex:0];
            NSString *value = [pairComponents objectAtIndex:1];
            
            [qsDict setObject:value forKey:key];
        }
    }
    return qsDict;
}

- (NSString *)queryStringValueForKey:(NSString *)key
{
    return [[self queryStringDictionary] valueForKey:key];
}

@end
