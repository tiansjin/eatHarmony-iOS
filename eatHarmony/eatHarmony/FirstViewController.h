//
//  FirstViewController.h
//  eatHarmony
//
//  Created by Tian Jin on 19/02/2014.
//  Copyright (c) 2014 Countable Irrationals. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UISearchBarDelegate,UISearchDisplayDelegate>
{
    UISearchBar *searchB;
    UILabel *title;
    NSArray *food;
}

@property (retain, nonatomic) IBOutlet UISearchBar *searchB;
@property (strong, nonatomic) IBOutlet UILabel *title;

@end
