//
//  ShortForm.m
//  Acromine
//
//  Created by Vemula, Manoj (Contractor) on 12/1/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

#import "ShortForm.h"
#import "MySession.h"

@implementation ShortForm

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.sf = [attributes valueForKeyPath:@"sf"];
    
    return self;
}

#pragma mark -

+ (NSURLSessionDataTask *)getAcronymForLongForm:(NSString*)longForm withBlock:(void (^)(NSArray *sfs, NSError *error))block {
    
    NSDictionary* bodyParameters = @{@"lf": longForm
                                     };
    
    return [[MySession sharedClient] GET:@"" parameters:bodyParameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSError* error;
        NSArray* json = [NSJSONSerialization JSONObjectWithData:JSON
                                                        options:kNilOptions
                                                          error:&error];
        
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:0];
        NSArray *postsFromResponse = [NSArray array];
        if (json.count > 0) {
            mutablePosts = [NSMutableArray arrayWithCapacity:[json count]];
            for (NSDictionary *each in json) {
                if ([each objectForKey:@"sf"]) {
                    ShortForm *sf = [[ShortForm alloc] initWithAttributes:each];
                    [mutablePosts addObject:sf];
                }
            }
        }
        for (NSDictionary *attributes in postsFromResponse) {
            ShortForm *sf = [[ShortForm alloc] initWithAttributes:attributes];
            [mutablePosts addObject:sf];
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
