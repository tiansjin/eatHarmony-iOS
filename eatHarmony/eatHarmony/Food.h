//
//  Food.h
//  eatHarmony
//
//  Created by Ashley Lai on 4/3/14.
//  Copyright (c) 2014 Countable Irrationals. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Food : NSObject
{
@public
    NSString* name;
    NSURL* main_img;
    NSURL* web_url;
    NSString* star_rating;
    NSURL* star_img;
    NSString* key;
}
+ (Food*) new_food:(NSString*)title
                  :(NSURL*)img
                  :(NSURL*)url
                  :(NSString*)rating
                  :(NSURL*)stars
                  :(NSString*)id_key;

@end
