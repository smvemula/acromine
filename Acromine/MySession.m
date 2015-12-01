//
//  MySession.m
//  Acromine
//
//  Created by Vemula, Manoj (Contractor) on 12/1/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

#import "MySession.h"

static NSString * const MySessionBaseURLString = @"http://www.nactem.ac.uk/software/acromine/dictionary.py";

@implementation MySession

+ (instancetype)sharedClient {
    static MySession *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MySession alloc] initWithBaseURL:[NSURL URLWithString:MySessionBaseURLString]];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return _sharedClient;
}

@end
