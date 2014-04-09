//
//  SecondViewController.m
//  eatHarmony
//
//  Created by Tian Jin on 19/02/2014.
//  Copyright (c) 2014 Countable Irrationals. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize image;
@synthesize text;
@synthesize ingred;

- (NSString*) recipe:(NSString*) recipeId
{ //Returns API calls for search query in JSON format
    NSString* key = @"dvxP3Ib8x153K71alv2yhXp8U349s103";
    NSString* url = @"http://api.bigoven.com/recipe/";
    url = [url stringByAppendingString:(recipeId)];
    url = [url stringByAppendingString:(@"?api_key=")];
    url = [url stringByAppendingString:(key)];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLResponse *response = nil;
    NSString* output = nil;
    NSString* ret = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:nil];
    if (data) { // Search succeeded!
        output = [[NSString alloc] initWithData:data
                                       encoding:NSUTF8StringEncoding] ;
        ret = output;
    }
    else { // Search failed :(
        ret = [output copy];
    }
    return ret;
}

- (NSDictionary*) dataToDictionary:(NSString*)recipe_info
{
    // Create NSDictionary from the JSON data
    NSLog(recipe_info);
    NSStringEncoding  encoding;
    NSData *jsonData = [recipe_info dataUsingEncoding:encoding];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    return json;
}

- (NSString*) ingredients:(NSDictionary*)recipe
{
    NSArray *ingreds = [recipe objectForKey:@"Ingredients"];
    NSString *ing = @"";
    for (id ingredient in ingreds) {
        ing = [NSString stringWithFormat:@"%@,%@", ing, [ingredient objectForKey:@"Name"]];
        ing = [NSString stringWithFormat:@"%@,%@", ing, @": "];
        ing = [NSString stringWithFormat:@"%@,%@", ing, [ingredient objectForKey:@"DisplayQuantity"]];
        NSString *check = [ingredient objectForKey:@"Unit"];
        if (check != (id)[NSNull null])
        {
        ing = [NSString stringWithFormat:@"%@,%@", ing, @" "];
        ing = [NSString stringWithFormat:@"%@,%@", ing, [ingredient objectForKey:@"Unit"]];
        }
        ing = [NSString stringWithFormat:@"%@,%@", ing, @"\n"];
    }
    ing = [ing stringByReplacingOccurrencesOfString:@"," withString:@""];
    return ing;
    
}

- (void) setInfo
{
    NSDictionary *recipeInfo = [self dataToDictionary:[self recipe:@"185641"]];
    NSString *ImageURL = [recipeInfo objectForKey:@"ImageURL"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    image.image = [UIImage imageWithData:imageData];
    
    ingred.editable = NO;
    ingred.text = [self ingredients:recipeInfo];

    text.editable = NO;
    text.text = [recipeInfo objectForKey:@"Instructions"];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setInfo];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
