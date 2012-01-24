//
//  AENetworkActivityIndicatorController.m
//
//  Created by Adam Ernst on 1/24/11.
//  BSD Licensed.
//

#import "AENetworkActivityIndicatorController.h"

@interface AENetworkActivityIndicatorController () {
    NSUInteger activityCount;
}
@end

#define ASSERT_MAIN_THREAD (NSAssert([NSThread isMainThread], @"Call -beginNetworkActivity or -endNetworkActivity only from the main thread."))

@implementation AENetworkActivityIndicatorController

+ (AENetworkActivityIndicatorController *)sharedController {
    static AENetworkActivityIndicatorController *controller;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[AENetworkActivityIndicatorController alloc] init];
    });
    return controller;
}

- (void)updateNetworkActivityIndicator {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:(activityCount > 0)];
}

- (void)beginNetworkActivity {
    ASSERT_MAIN_THREAD;

    activityCount++;
    [self updateNetworkActivityIndicator];
}

- (void)endNetworkActivity {
    ASSERT_MAIN_THREAD;

    activityCount--;

    // Delay the disappearance of the network activity indicator slightly to 
    // prevent flickering.
    double delayInSeconds = 0.25;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self updateNetworkActivityIndicator];
    });
}

@end
