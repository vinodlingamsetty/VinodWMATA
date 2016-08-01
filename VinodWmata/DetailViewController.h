//
//  DetailViewController.h
//  VinodWmata
//
//  Created by vinod kumar lingamsetty on 5/7/16.
//  Copyright © 2016 vinod kumar lingamsetty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DetailViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) NSDictionary *stationInfo;

//@property (nonatomic, strong, null_resettable) UITableView *tableView;

@end
