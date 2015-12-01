//
//  MBProgressHUD+LoadingHelper.h
//  Acromine
//
//  Created by Vemula, Manoj (Contractor) on 12/1/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

#import "MBProgressHUD.h"
@class ViewController;
@interface MBProgressHUD (LoadingHelper)
- (void)showWithLabelOnViewController:(ViewController*)vc andMessage:(NSString*)message;
- (void)showWithLabelOnViewController:(ViewController*)vc;
+ (void)showTextOnlyOnViewController:(ViewController*)vc andMessage:(NSString*)message;

@end
