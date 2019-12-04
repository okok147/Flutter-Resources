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

#import "Hole.h"
#import "MapAnnotation.h"
#import "MapPolygon.h"
#import "MapPolyline.h"
#import "MapViewController.h"
#import "MapViewPlugin.h"
#import "MarkerIcon.h"
#import "UIColor+Extensions.h"

FOUNDATION_EXPORT double cirrus_map_viewVersionNumber;
FOUNDATION_EXPORT const unsigned char cirrus_map_viewVersionString[];

