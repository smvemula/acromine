//
//  ViewController.m
//  Acromine
//
//  Created by Vemula, Manoj (Contractor) on 11/30/15.
//  Copyright © 2015 Vemula, Manoj. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+LoadingHelper.h"
#import "LongForm.h"
#import "ShortForm.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>  {
    MBProgressHUD *HUD;
    long long expectedLength;
    long long currentLength;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    //Start by searching by Acronym
    self.isLongForm = NO;
    [self.searchTextField becomeFirstResponder];
}

//Change between Long Form and Short From Search
- (IBAction)changeMode:(id)sender {
    self.isLongForm = !self.isLongForm;
    self.searchTextField.text = @"";
    self.changeType.title = self.isLongForm ? @"Short Form" : @"Long Form";
    self.searchTextField.placeholder = self.isLongForm ? @"Type Long form" : @"Type Short form";
    self.searchResults = [NSArray array];
    [self.resultsTableView reloadData];
    [self.searchTextField becomeFirstResponder];
}

//Add MBProgressHUD Animation and Do respective search
- (IBAction)doSearch:(id)sender {
    [self.searchTextField resignFirstResponder];
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    
    if (self.searchTextField.text.length > 1) {
        [self.view addSubview:HUD];
        
        if (self.isLongForm) {
            [HUD showWithLabelOnViewController:self andMessage:@"Fetching Short Forms"];
        } else {
            [HUD showWithLabelOnViewController:self andMessage:@"Fetching Long Forms"];
        }
    } else {
        //Less than 2 characters
        [MBProgressHUD showTextOnlyOnViewController:self andMessage:@"Type atleast 2 characters"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Task for performing respective search and reload table View
- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    if (self.isLongForm) {
        [ShortForm getAcronymForLongForm:self.searchTextField.text withBlock:^(NSArray *shortForms, NSError *error) {
            if (!error) {
                self.searchResults = shortForms;
                [self.resultsTableView reloadData];
                if (self.searchResults.count == 0) {
                    [MBProgressHUD showTextOnlyOnViewController:self andMessage:@"No Results Found"];
                }
            }
        }];
    } else {
        [LongForm getFullFormsForAcronym:self.searchTextField.text withBlock:^(NSArray *longForms, NSError *error) {
            if (!error) {
                self.searchResults = longForms;
                [self.resultsTableView reloadData];
                if (self.searchResults.count == 0) {
                    [MBProgressHUD showTextOnlyOnViewController:self andMessage:@"No Results Found"];
                }
            }
        }];
    }
}

#pragma mark - UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self doSearch:textField];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    self.searchResults = [NSArray array];
    [self.resultsTableView reloadData];
    return  YES;
}

#pragma mark - UITableView Delegate & Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResults count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        //create new cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (!self.isLongForm) {
        LongForm *lf = self.searchResults[indexPath.row];
        cell.textLabel.text = lf.lf;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Frequency %ld Since %ld", (long)lf.freq,(long)lf.since];
    } else {
        ShortForm *sf = self.searchResults[indexPath.row];
        cell.textLabel.text = sf.sf;
    }
    
    return cell;
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


@end
