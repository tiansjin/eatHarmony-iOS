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
@synthesize title;

- (void)viewDidLoad
{
    [super viewDidLoad];
    searchB.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)hideSearchBar {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0f];
    title.alpha = 0.0f;
    [searchB setFrame:CGRectMake(0, -30, self.view.bounds.size.width, 150)];
    [searchB setNeedsLayout];
    [UIView commitAnimations];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self hideSearchBar];
    food = [searchBar.text componentsSeparatedByString:@","];
    [title removeFromSuperview];
    [self.searchB resignFirstResponder];
}


@end
