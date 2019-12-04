#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
@import Firebase;
@import GoogleMaps;
@import GooglePlaces;
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
//  [GMSPlacesClient provideApiKey:@"AIzaSyDbLEWhebz8Eac6GyvhMEwK0fiXxANJh4g"];
//  [GMSServices provideApiKey:@"AIzaSyDbLEWhebz8Eac6GyvhMEwK0fiXxANJh4g"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  [GMSPlacesClient provideAPIKey:@"AIzaSyCA3T4BDdR7Lhiqw1sZT3HBa3AvZJqtnP8"];
  [GMSServices provideAPIKey:@"AIzaSyCA3T4BDdR7Lhiqw1sZT3HBa3AvZJqtnP8"];
  // Override point for customization after application launch.
  
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
