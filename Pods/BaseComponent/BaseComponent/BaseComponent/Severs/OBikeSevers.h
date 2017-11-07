//
//  PKWSevers.h
//  PKWSevers
//
//  Created by peikua on 16/4/25.
//  Copyright © 2016年 peikua. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OBikeNetBase.h"

#import "OBikeHttpURLs.h"

typedef  void (^Success) (id objModel);
typedef  void (^Failure) (NSError *error);

@interface NSMutableDictionary (Post)

-(void)setNoNullObject:(id)anObject forKey:(id<NSCopying>)aKey;
-(void)setObject:(id)anObject forKey:(id<NSCopying>)aKey withDefault:(id)defaultValue;

@end

@interface OBikeSevers : NSObject

+ (void)refreshTokenWithRefreshToken:(NSString *)refreshToken
                             success:(Success)successBlock
                             Failure:(Failure)failBlock;

@end
