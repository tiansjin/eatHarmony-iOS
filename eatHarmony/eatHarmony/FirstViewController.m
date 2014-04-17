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

- (NSString*) searchResults:(NSString*) search_term
{ //Returns API calls for search query in JSON format
    NSString* key = @"dvxP3Ib8x153K71alv2yhXp8U349s103";
    NSString* url = @"http://api.bigoven.com/recipes?pg=1&rpp=25&title_kw=";
    NSLog(search_term);
    url = [url stringByAppendingString:(search_term)];
    url = [url stringByAppendingString:(@"&api_key=")];
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
    NSLog(ret);
    return ret;
}

- (NSData*) stringToData:(NSString*) recipe_info
{   // Converts json string format to data
    NSData* data = [recipe_info dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

- (NSDictionary*) dataToDictionary:(NSData*)recipe_info
{
    // Create NSDictionary from the JSON data
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:recipe_info options:0 error:nil];
    return jsonDictionary;
}

- (NSMutableArray*) getSummary:(NSDictionary*)recipe_info
{
    // Returns array of recipe results
    NSMutableArray* all_results = [[NSMutableArray alloc] init];
    // Create array of dictionaries with key "items"
    NSArray* all_events = [recipe_info objectForKey:@"Results"];
    // Create array of strings with key "summary";
    for (NSDictionary *event in all_events)
    {
        NSString *title = [event objectForKey:@"Title"];
        NSURL *img = [event objectForKey:@"ImageURL"];
        NSURL *url = [event objectForKey:@"WebURL"];
        NSString *star = [event objectForKey:@"StarRating"];
        NSURL *star_img = [event objectForKey:@"StarRatingImg"];
        NSString *key = [event objectForKey:@"RecipeID"];
        
        Food *add_food = [Food new_food:title :img :url :star :star_img :key];
        NSLog(add_food->name);
        
        [all_results addObject: add_food];
    }
    
    return all_results; // Returns a list of foods from the request
}

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
    int prev = [items count];
    food = [searchBar.text componentsSeparatedByString:@","];
    [self results];
    int curr = [items count];
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
    return [items count];
}

- (void) results
{
    NSString *searchTerms = [food componentsJoinedByString:@"+"];
    searchTerms = [searchTerms stringByReplacingOccurrencesOfString:@" " withString:@""];
    items = [self getSummary:[self dataToDictionary:[self stringToData:[self searchResults:searchTerms]]]];
    
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
    Food *display =[items objectAtIndex:indexPath.row];
    cell.textLabel.text = display->name;
    /*
    NSString *ImageURL = display->web_url;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    UIImageView *image;
    image.image = [UIImage imageWithData:imageData];
    cell.imageView.image = image;*/
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Food *selected = [items objectAtIndex:indexPath.row];
    NSString *ID = [NSString stringWithFormat:@"%@",selected->key];
    SecondViewController *SVC = (SecondViewController *)[self.tabBarController.viewControllers objectAtIndex:1];
    SVC.ID = ID;
    
    [self.tabBarController setSelectedIndex:1];
}


@end
