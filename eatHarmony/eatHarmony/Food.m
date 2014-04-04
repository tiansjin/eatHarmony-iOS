//
//  Food.m
//  eatHarmony
//
//  Created by Ashley Lai on 4/3/14.
//  Copyright (c) 2014 Countable Irrationals. All rights reserved.
//

#import "Food.h"

@implementation Food

+ (Food*) new_food:(NSString*)title
                :(NSURL*)img
                :(NSURL*)url
                :(NSString*)rating
                :(NSURL*)stars
                :(NSString*)id_key
{
    Food *food = [[Food alloc] init];
    food->name = title;
    food->main_img = img;
    food->web_url = url;
    food->star_rating = rating;
    food->star_img = stars;
    food->key = id_key;
    
    return food;
}

@end
