#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FLTBackgroundGeolocationPlugin.h"
#import "ActivityChangeStreamHandler.h"
#import "ConnectivityChangeStreamHandler.h"
#import "EnabledChangeStreamHandler.h"
#import "GeofencesChangeStreamHandler.h"
#import "GeofenceStreamHandler.h"
#import "HeartbeatStreamHandler.h"
#import "HttpStreamHandler.h"
#import "LocationStreamHandler.h"
#import "MotionChangeStreamHandler.h"
#import "NotificationActionStreamHandler.h"
#import "PowerSaveChangeStreamHandler.h"
#import "ProviderChangeStreamHandler.h"
#import "ScheduleStreamHandler.h"
#import "StreamHandler.h"

FOUNDATION_EXPORT double flutter_background_geolocationVersionNumber;
FOUNDATION_EXPORT const unsigned char flutter_background_geolocationVersionString[];

