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

@property (nonatomic, copy) NSArray * searchResults;//Data source for TableView
@property (nonatomic, weak) IBOutlet UITableView *resultsTableView;//Results showing TableView
@property (nonatomic, weak) IBOutlet UITextField *searchTextField;//Searcch box
@property (nonatomic, weak) IBOutlet UIBarButtonItem *changeType;//Switch between Long/Short
@property (nonatomic, assign) BOOL isLongForm;

- (void)myTask;//Task for fetching results

- (IBAction)changeMode:(id)sender;
- (IBAction)doSearch:(id)sender;

@end

