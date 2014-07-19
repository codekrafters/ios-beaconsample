////////////////////////////////////////////////////////////////////////////////
//
// Code Krafters - BeaconSample
// Copyright (c) 2014 Code Krafters
// All Rights Reserved Worldwide
// Proprietary and Confidential - Not for Distribution
// Written by Code Krafters
//
// AppDelegate.m
//
// AUTHOR IDENTITY:
//		Roberto Gamboni		19/07/2014
//
////////////////////////////////////////////////////////////////////////////////

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate () <CLLocationManagerDelegate>

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CLLocationManager* locationMananger = [[CLLocationManager alloc] init];
    locationMananger.delegate = self;
    
    NSUUID* uuid = [[NSUUID alloc] initWithUUIDString:@"B0702880-A295-A8AB-F734-031A98A512DE"];
    CLBeaconRegion* region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"ck-beacon"];
    [locationMananger startRangingBeaconsInRegion:region];
    [region release];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

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

@end
