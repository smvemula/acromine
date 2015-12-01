//
//  LongForm.m
//  Acromine
//
//  Created by Vemula, Manoj (Contractor) on 12/1/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

#import "LongForm.h"
#import "Vars.h"
#import "MySession.h"
#import "AFNetworking.h"

@implementation LongForm

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.freq = (NSUInteger)[[attributes valueForKeyPath:@"freq"] integerValue];
    self.since = (NSUInteger)[[attributes valueForKeyPath:@"since"] integerValue];
    self.lf = [attributes valueForKeyPath:@"lf"];
    
    return self;
}

#pragma mark -

+ (NSURLSessionDataTask *)getFullFormsForAcronym:(NSString*)acronym withBlock:(void (^)(NSArray *lfs, NSError *error))block {
    
    NSDictionary* bodyParameters = @{@"sf": acronym
                                     };
    
    return [[MySession sharedClient] GET:@"" parameters:bodyParameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSError* error;
        NSArray* json = [NSJSONSerialization JSONObjectWithData:JSON
                                                             options:kNilOptions
                                                               error:&error];
        
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:0];
        NSArray *postsFromResponse = [NSArray array];
        if (json.count > 0) {
            NSDictionary *first = [json objectAtIndex:0];
            postsFromResponse = [first objectForKey:@"lfs"];
            mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        }
        for (NSDictionary *attributes in postsFromResponse) {
            LongForm *lf = [[LongForm alloc] initWithAttributes:attributes];
            [mutablePosts addObject:lf];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

@end
