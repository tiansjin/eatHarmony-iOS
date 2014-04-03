//
//  FirstViewController.h
//  eatHarmony
//
//  Created by Tian Jin on 19/02/2014.
//  Copyright (c) 2014 Countable Irrationals. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@interface FirstViewController : UIViewController <UISearchBarDelegate,UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UISearchBar *searchB;
    UIImageView *titleLabel;
    UITableView *tableV;
    NSArray *food;
}

@property (retain, nonatomic) IBOutlet UISearchBar *searchB;
@property (strong, nonatomic) IBOutlet UIImageView *titleLabel;
@property (retain, nonatomic) IBOutlet UITableView *tableV;
@end
