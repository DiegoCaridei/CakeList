//
//  MasterViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "MasterViewController.h"
#import "CakeCell.h"
#import "HTTPService.h"
#define TITLE "title"
#define DESCRIPTION "desc"
#define IMAGE "image"
#define CELL_ID "Cell"

@interface MasterViewController ()
@property (strong, nonatomic) NSArray *cakesList;
@property ( nonatomic,retain) UIRefreshControl *refreshControl;
@end

@implementation MasterViewController
@synthesize refreshControl;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self settingRefreshControl];
  self.cakesList = [[NSArray alloc] init];
  [self fetchData];
}

- (void)settingRefreshControl {
  refreshControl = [[UIRefreshControl alloc]init];
  [self.view addSubview:refreshControl];
  [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

- (void)refreshTable {
  [self fetchData];
}

- (void)fetchData {
  [[HTTPService instance]getCakes:^(NSArray * _Nullable data, NSString * _Nullable errMessage) {
    if(data) {
      NSMutableArray *cakes = [[NSMutableArray alloc] init];
      for( NSDictionary *cakeDict in data) {
        Cake *cake = [[Cake alloc]init];
        cake.title = [cakeDict objectForKey:@TITLE];
        cake.desc = [cakeDict objectForKey:@DESCRIPTION];
        cake.image = [cakeDict objectForKey:@IMAGE];
        [cakes addObject:cake];
      }
      self.cakesList =  cakes;
      [self updateTableData];
      
    }
    else if (errMessage) {
      NSLog(@"ERROR: %@",errMessage);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
      }
    });
    
  }];
}

-(void)updateTableData {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.tableView reloadData];
  });
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.cakesList.count;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  Cake *cake = [self.cakesList objectAtIndex:indexPath.row];
  CakeCell *cakeCell = (CakeCell*)cell;
  [cakeCell updateUI:cake];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  CakeCell *cell = (CakeCell*)[tableView dequeueReusableCellWithIdentifier:@CELL_ID forIndexPath:indexPath];
  if (!cell) {
    cell = [[CakeCell alloc]init];
  }
  Cake *cake = [self.cakesList objectAtIndex:indexPath.row];
  [cell updateUI:cake];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end

