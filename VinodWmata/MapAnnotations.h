//
//  MapAnnotations.h
//  VinodWmata
//
//  Created by vinod kumar lingamsetty on 5/10/16.
//  Copyright © 2016 vinod kumar lingamsetty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotations : NSObject <MKAnnotation>

@property (nonatomic,assign ) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;

@end
