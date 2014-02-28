//
//  FirstViewController.m
//  eatHarmony
//
//  Created by Tian Jin on 19/02/2014.
//  Copyright (c) 2014 Countable Irrationals. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize searchB;
@synthesize titleLabel;
@synthesize tableV;


- (void)viewDidLoad
{
    [super viewDidLoad];
    searchB.delegate = self;
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.hidden = YES;
    
	// Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}

#pragma mark  - SearchBar Functions

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)hideSearchBar {
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options: UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         [searchB setFrame:CGRectMake(0, -30, self.view.bounds.size.width, 150)];
                         [searchB setNeedsLayout];
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.5 animations:^{
                             tableV.alpha = 1;
                         }];
                     }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    int prev = [food count];
    food = [searchBar.text componentsSeparatedByString:@","];
    int curr = [food count];
    if (curr > prev)
    {
        NSMutableArray *rows = [[NSMutableArray alloc] init];
        for (int i = prev; i < curr; i++)
        {
            [rows addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        [tableV insertRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationNone];
    }
    if (curr < prev)
    {
        NSMutableArray *rows = [[NSMutableArray alloc] init];
        for (int i = curr; i < prev; i++)
        {
            [rows addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        [tableV deleteRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationNone];
    }
    [tableV beginUpdates];
    [self.tableV reloadData];
    [tableV endUpdates];
    tableV.hidden = NO;
    tableV.alpha = 0.0f;
    [self hideSearchBar];
    [UIView setAnimationDuration:1.0f];
    titleLabel.alpha = 0.0f;
    tableV.alpha = 1.0f;
    [UIView commitAnimations];
    titleLabel.hidden = YES;
    [self.searchB resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"%d", [food count]);
    return [food count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [food objectAtIndex:indexPath.row];
    
    return cell;
}



@end
