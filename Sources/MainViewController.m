//
//  MainViewController.m
//  BeaconSample
//
//  Created by openovone on 20/07/14.
//  Copyright (c) 2014 codekrafters. All rights reserved.
//

#import "MainViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface MainViewController () <CLLocationManagerDelegate>

@property(nonatomic, retain) NSUUID* regionUUID;
@property(nonatomic, retain) CLBeaconRegion* beaconRegion;
@property(nonatomic, retain) CLLocationManager* locationManager;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.regionUUID = [[[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"] autorelease];
    self.beaconRegion = [[[CLBeaconRegion alloc] initWithProximityUUID:self.regionUUID identifier:@"ck-beacon"] autorelease];
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.delegate = self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([CLLocationManager isMonitoringAvailableForClass:[self.beaconRegion class]])
    {
        NSLog(@"Device is ready");
        self.textView.text = [self.textView.text stringByAppendingString:@"Device is ready\n"];
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)
        {
            NSLog(@"Application is authorized");
            self.textView.text = [self.textView.text stringByAppendingString:@"Application is authorized\n"];
            //[self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
            [self.locationManager startMonitoringForRegion:self.beaconRegion];
        }
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    [self.locationManager stopMonitoringForRegion:self.beaconRegion];
}

- (void) dealloc
{
    self.textView = nil;
    self.locationManager = nil;
    self.beaconRegion = nil;
    self.regionUUID = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate / Ranging

/*
 *  locationManager:didRangeBeacons:inRegion:
 *
 *  Discussion:
 *    Invoked when a new set of beacons are available in the specified region.
 *    beacons is an array of CLBeacon objects.
 *    If beacons is empty, it may be assumed no beacons that match the specified region are nearby.
 *    Similarly if a specific beacon no longer appears in beacons, it may be assumed the beacon is no longer received
 *    by the device.
 */
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    NSLog(@"Ranging beacons: %@", beacons);
}

/*
 *  locationManager:rangingBeaconsDidFailForRegion:withError:
 *
 *  Discussion:
 *    Invoked when an error has occurred ranging beacons in a region. Error types are defined in "CLError.h".
 */
- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    NSLog(@"Ranging beacons error: %@", error);
}

#pragma mark -
#pragma mark CLLocationManagerDelegate / RegionMonitoring

/*
 *  locationManager:didEnterRegion:
 *
 *  Discussion:
 *    Invoked when the user enters a monitored region.  This callback will be invoked for every allocated
 *    CLLocationManager instance with a non-nil delegate that implements this method.
 */
- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region
{
    NSLog(@"Enter region");
    self.textView.text = [self.textView.text stringByAppendingString:@"Entering region\n"];
}

/*
 *  locationManager:didExitRegion:
 *
 *  Discussion:
 *    Invoked when the user exits a monitored region.  This callback will be invoked for every allocated
 *    CLLocationManager instance with a non-nil delegate that implements this method.
 */
- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region
{
    NSLog(@"Exit region");
    self.textView.text = [self.textView.text stringByAppendingString:@"Exit region\n"];
}

/*
 *  locationManager:monitoringDidFailForRegion:withError:
 *
 *  Discussion:
 *    Invoked when a region monitoring error has occurred. Error types are defined in "CLError.h".
 */
- (void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region
              withError:(NSError *)error
{
    NSLog(@"Region monitoring failed with error: %@", error);
    self.textView.text = [self.textView.text stringByAppendingString:@"Region monitoring failed.\n"];
}

@end
