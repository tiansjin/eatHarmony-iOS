//
//  SecondViewController.h
//  eatHarmony
//
//  Created by Tian Jin on 19/02/2014.
//  Copyright (c) 2014 Countable Irrationals. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
{
    UIImageView *image;
    UITextView *text;
    UITextView *ingred;
}

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UITextView *text;
@property (strong, nonatomic) IBOutlet UITextView *ingred;

@end
