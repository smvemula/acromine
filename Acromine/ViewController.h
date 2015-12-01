//
//  ViewController.h
//  Acromine
//
//  Created by Vemula, Manoj (Contractor) on 11/30/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ViewController : UIViewController<MBProgressHUDDelegate>

@property (nonatomic, copy) NSArray * searchResults;
@property (nonatomic, weak) IBOutlet UITableView *resultsTableView;
@property (nonatomic, weak) IBOutlet UITextField *searchTextField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *changeType;
@property (nonatomic, assign) BOOL isLongForm;

- (void)myTask;

- (IBAction)changeMode:(id)sender;
- (IBAction)doSearch:(id)sender;

@end

