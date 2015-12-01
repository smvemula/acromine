//
//  LongForm.h
//  Acromine
//
//  Created by Vemula, Manoj (Contractor) on 12/1/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LongForm : NSObject

@property (nonatomic, strong) NSString *lf; //Long Form
@property (nonatomic, assign) NSInteger freq; //Frequency of Long Form
@property (nonatomic, assign) NSInteger since; //Year since this Long Form is in use

- (instancetype)initWithAttributes:(NSDictionary *)attributes;// Initializer for LongForm

+ (NSURLSessionDataTask *)getFullFormsForAcronym:(NSString*)acronym withBlock:(void (^)(NSArray *posts, NSError *error))block;//GET Task to get LongForms match 'acronym'

@end
