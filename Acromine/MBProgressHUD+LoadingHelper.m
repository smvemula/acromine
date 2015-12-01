//
//  MBProgressHUD+LoadingHelper.m
//  Acromine
//
//  Created by Vemula, Manoj (Contractor) on 12/1/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

#import "MBProgressHUD+LoadingHelper.h"
#import "MBProgressHUD.h"
#import "ViewController.h"
#import "AFNetworking.h"

@implementation MBProgressHUD (LoadingHelper)

//Show animation till end of block
- (void)showWithLabelOnViewController:(ViewController*)vc andMessage:(NSString*)message {
    
    self.delegate = vc;
    self.labelText = message;
    self.dimBackground = YES;
    
    [self showAnimated:YES whileExecutingBlock:^{
        [vc myTask];
    } completionBlock:^{
        [self removeFromSuperview];
    }];
}

//Show animation and dismiss With delay
+ (void)showTextOnlyOnViewController:(ViewController*)vc andMessage:(NSString*)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:vc.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1];
}

- (void)showWithLabelOnViewController:(ViewController*)vc {
   /* NSURL *URL = [NSURL URLWithString:@"https://www.nactem.ac.uk/software/acromine/dictionary.py?lf=National%20Football%20league"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [[NSURLSession alloc] init];

    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:vc];
    [connection start];
    
    self.delegate = vc;
    */
    // My API (2) (GET https://www.nactem.ac.uk/software/acromine/dictionary.py)
    
    // Create manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // Form URL-Encoded Body
    NSDictionary* bodyParameters = @{
                                     };
    
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?lf=National%20Football%20league" parameters:bodyParameters error:NULL];
    
    // Add Headers
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                             NSLog(@"HTTP Response Status Code: %ld", [operation.response statusCode]);
                                                                             NSLog(@"HTTP Response Body: %@", responseObject);
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];
}
@end
