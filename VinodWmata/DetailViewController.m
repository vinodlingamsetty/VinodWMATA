//
//  DetailViewController.m
//  VinodWmata
//
//  Created by vinod kumar lingamsetty on 5/7/16.
//  Copyright © 2016 vinod kumar lingamsetty. All rights reserved.
//

#import "DetailViewController.h"
#import "NextTrainTableViewCell.h"
#import "MapAnnotations.h"

@interface DetailViewController ()<UITableViewDelegate, UITableViewDataSource> {
    
    NSArray *nextTrainArray;
}

@property (weak, nonatomic) IBOutlet MKMapView *theMapView;

@property (weak, nonatomic) IBOutlet UILabel *street;
 
@property (weak, nonatomic) IBOutlet UILabel *city;




@property (nonatomic, strong) CLLocationManager *manager;
@property(nonatomic,strong) CLGeocoder *coder;



@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 //----------------------------Detail View Background Image-------------------------------
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.jpg"]];
    backgroundImage.contentMode = UIViewContentModeScaleAspectFit;
    
    
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    
    
//------------------------------------------------------------------------------
    
   

 //------------------------------------------------------------------------------
    NSString *nextTrainURL  = [NSString stringWithFormat:@"https://api.wmata.com/StationPrediction.svc/json/GetPrediction/%@/?api_key=6b700f7ea9db408e9745c207da7ca827",[_stationInfo objectForKey:@"Code"]];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:nextTrainURL]];
    NSDictionary *nextTrainDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    nextTrainArray = [nextTrainDictionary objectForKey:@"Trains"];
    
  //------------------------------------------------------------------------------
    
    
    
    
    self.title = [_stationInfo objectForKey:@"Name"];
    NSDictionary *addressDict = [_stationInfo objectForKey:@"Address"];
    NSString *street = [addressDict objectForKey:@"Street"];
    NSString *city = [addressDict objectForKey:@"City"];
    NSString *state = [addressDict objectForKey:@"State"];
    NSString *zip = [addressDict objectForKey:@"Zip"];
    
    _street.text = [NSString stringWithFormat:@"Address: %@",street];
    _city.text = [NSString stringWithFormat:@"%@, %@-%@",city,state,zip];
    
 
    
    double lat= [[_stationInfo objectForKey:@"Lat"]doubleValue];
    double lon= [[_stationInfo objectForKey:@"Lon"]doubleValue];
    MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(lat, lon), MKCoordinateSpanMake(0.02, 0.02));
    
 //------------------------------------------------------------------------------
    
    [_theMapView setRegion:(region)];

    MapAnnotations *map = [[MapAnnotations alloc]init];
    map.coordinate = CLLocationCoordinate2DMake(lat, lon);
    map.title = [_stationInfo objectForKey:@"Name"];
    map.subtitle = [addressDict objectForKey:@"Street"];
    
    [_theMapView addAnnotation:map];
   
    self.manager = [[CLLocationManager alloc]init];
    self.coder = [[CLGeocoder alloc]init];
    
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization )]) {
        [self.manager requestWhenInUseAuthorization ];
    }
    else{
        
    }
  //------------------------------------------------------------------------------
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return nextTrainArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    tableView.backgroundView = nil;
    tableView.backgroundColor = [UIColor clearColor];

    
    NextTrainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nextTrain"];
    
    cell.destinationLbl.text = [NSString stringWithFormat:@"To: %@",[[nextTrainArray objectAtIndex:indexPath.row ]objectForKey:@"Destination"]];
    cell.colorLbl.text = [NSString stringWithFormat:@"Line: %@",[[nextTrainArray objectAtIndex:indexPath.row]objectForKey:@"Line"]];
    cell.timeLbl.text = [NSString stringWithFormat:@"%@ mins",[[nextTrainArray objectAtIndex:indexPath.row]objectForKey:@"Min"] ];
 
    [[cell contentView] setBackgroundColor:[UIColor clearColor]];
    [[cell backgroundView] setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
 
    
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
