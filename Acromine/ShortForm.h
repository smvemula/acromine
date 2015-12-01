//
//  ShortForm.h
//  Acromine
//
//  Created by Vemula, Manoj (Contractor) on 12/1/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShortForm : NSObject

@property (nonatomic, strong) NSString *sf; //Short Form

- (instancetype)initWithAttributes:(NSDictionary *)attributes;//Initializer for ShortForm

+ (NSURLSessionDataTask *)getAcronymForLongForm:(NSString*)longForm withBlock:(void (^)(NSArray *posts, NSError *error))block;//GET Task to get shortForms match 'longForm'

@end
