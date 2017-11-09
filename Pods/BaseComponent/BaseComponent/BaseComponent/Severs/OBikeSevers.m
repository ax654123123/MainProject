//
//  PKWSevers.m
//  PKWSevers
//
//  Created by OBikeSevers on 16/4/25.
//  Copyright © 2016年 peikua. All rights reserved.
//

#import "OBikeSevers.h"
#import "OBikeHttpURLs.h"

@implementation NSMutableDictionary (Post)

-(void)setNoNullObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }
}
-(void)setObject:(id)anObject forKey:(id<NSCopying>)aKey withDefault:(id)defaultValue
{
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }else if(defaultValue)
    {
        [self setObject:defaultValue forKey:aKey];
    }else
    {
        [self setObject:@"" forKey:aKey];
    }
}

@end

@implementation OBikeSevers
/**
 *  这个可以写一些基础服务类的请求例如：崩溃的统计，用户行为，
 *  其他有业务逻辑的请求不可以写在这里
 */
+ (void)refreshTokenWithRefreshToken:(NSString *)refreshToken
                             success:(Success)successBlock
                             Failure:(Failure)failBlock
{
    
}
@end
