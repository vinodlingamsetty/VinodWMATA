//
//  MainTableViewController.m
//  VinodWmata
//
//  Created by vinod kumar lingamsetty on 5/7/16.
//  Copyright © 2016 vinod kumar lingamsetty. All rights reserved.
//

#import "MainTableViewController.h"
#import "DetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MainTableViewController ()<UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UISearchDisplayDelegate>{
    
    NSArray *thelines;
   // NSMutableArray *stationsArray;
    NSMutableSet *collapsedSections;
    NSMutableArray *statNamesArray;
    NSMutableArray *allResults;
}

@property (nonatomic, strong) UISearchController *searchController;
@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) NSMutableArray *stationsArray;
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;


@end

@implementation MainTableViewController

 

    

//---------------------------------------------------------------------------------------
 



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:
                                     [UIImage imageNamed:@"2.jpg"]];
    
    self.searchDisplayController.searchResultsTableView.backgroundView = [[UIImageView alloc] initWithImage:
                                                                          [UIImage imageNamed:@"2.jpg"]];
    
    
    
    
 //-----------------------Search controller init-------------------------------------------
    //
//    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//    searchController.searchResultsUpdater = self;
//    searchController.dimsBackgroundDuringPresentation = YES;
//    searchController.searchBar.delegate = self;
//    
//    // Add the search bar
//    self.tableView.tableHeaderView = searchController.searchBar;
//    self.definesPresentationContext = YES;
//    [searchController.searchBar sizeToFit];
    
    
  // UITableViewController *resultscontroller = [[UITableViewController alloc]init];
   
    
    
    

    
   
   
    
    
//---------------------------------------------------------------------------------------
    
    NSString *lines = @"https://api.wmata.com/Rail.svc/json/jLines?api_key=6b700f7ea9db408e9745c207da7ca827";
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:lines]];
    NSDictionary *dictionaryOfLines = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    thelines = [dictionaryOfLines objectForKey:@"Lines"];
    
   // NSLog(@"%@",dictionaryOfLines);
    
    _stationsArray = [[NSMutableArray alloc] init];
    
    
    for (NSDictionary *dict in thelines) {
        sleep(1);
        NSString *strURL = [NSString stringWithFormat:@"https://api.wmata.com/Rail.svc/json/jStations?LineCode=%@&api_key=6b700f7ea9db408e9745c207da7ca827",[dict objectForKey:@"LineCode"]];
        NSData *dt = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
         //NSLog(@"%@",dt);
        NSDictionary *stationsDict = [NSJSONSerialization JSONObjectWithData:dt options:NSJSONReadingMutableContainers error:nil];
         //NSLog(@"%@",stationsDict);
        //statNamesArray =[[NSMutableArray alloc]init];
        
        [_stationsArray addObject:[stationsDict objectForKey:@"Stations"]];
       // [statNamesArray addObject:[_stationsArray valueForKey:@"Name"]];
        
       
 NSLog(@"%@",_stationsArray);
        
    }
 
    
     }



-(void)filterContentForSearchText:(NSString *)searchText{
    
     allResults = [[NSMutableArray alloc]init];
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"Name CONTAINS[cd] %@",searchText];
    
    for (int i=0; i<6; i++) {
         _searchResults = [ _stationsArray[i]   filteredArrayUsingPredicate:resultPredicate];
        [allResults addObjectsFromArray:_searchResults];
    }
    
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(nullable NSString *)searchString{
    
   
   
    [self filterContentForSearchText:searchString];
    return YES;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView==self.tableView) {
         return thelines.count;
    }
    else{
        
        return 1;
    }
    
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (tableView==self.tableView) {
        return [[thelines objectAtIndex:section] objectForKey:@"DisplayName"];
    }
    else{
        return @"Results";
    }
    
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (tableView==self.tableView) {
        
    if (section==0) {
        view.tintColor = [UIColor blueColor];
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        [header.textLabel setTextColor:[UIColor whiteColor]];
        
    }
    if (section==1) {
        view.tintColor = [UIColor greenColor];
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        [header.textLabel setTextColor:[UIColor whiteColor]];
        
    }
    if (section==2) {
        view.tintColor = [UIColor orangeColor];
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        [header.textLabel setTextColor:[UIColor whiteColor]];
        
    }
    if (section==3) {
        view.tintColor = [UIColor redColor];
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        [header.textLabel setTextColor:[UIColor whiteColor]];
        
    }
    if (section==4) {
        view.tintColor = [UIColor lightGrayColor];
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        [header.textLabel setTextColor:[UIColor whiteColor]];
        
    }
    if (section==5) {
        view.tintColor = [UIColor yellowColor];
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        [header.textLabel setTextColor:[UIColor blackColor]];
        
    }
    }
    else{
        
    }
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView==self.tableView) {
        NSArray *sta = [_stationsArray objectAtIndex:section];
        return sta.count;
    }
    else{
        return allResults.count;
    }
    
    //return [collapsedSections containsObject:@(section)] ? 0 : 10;
}
 //------------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
  
    if (tableView==self.tableView) {
         cell.textLabel.text = [[[_stationsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"Name"];
        
    }
    else{
      
        
        cell.textLabel.text = [[allResults objectAtIndex:indexPath.row] objectForKey:@"Name"];
    }

    
    [[cell contentView] setBackgroundColor:[UIColor clearColor]];
    [[cell backgroundView] setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}
//------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath =nil;
    
    DetailViewController *dvc = [segue destinationViewController];
    
    if ([self.searchDisplayController isActive]) {
        indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        dvc.stationInfo = [allResults objectAtIndex:indexPath.row];
        return;
    }
    else{
        indexPath = [self.tableView indexPathForSelectedRow];
        
        dvc.stationInfo = [[_stationsArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    }
    
    
}

 


@end
