//
//  MySession.h
//  Acromine
//
//  Created by Vemula, Manoj (Contractor) on 12/1/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

#import "AFURLSessionManager.h"
#import "AFHTTPSessionManager.h"

@interface MySession : AFHTTPSessionManager
+ (instancetype)sharedClient; //Singleton Method for MySession
@end
