//
//  AENetworkActivityIndicatorController.h
//
//  Created by Adam Ernst on 1/24/11.
//  BSD Licensed.
//

#import <Foundation/Foundation.h>

@interface AENetworkActivityIndicatorController : NSObject

+ (AENetworkActivityIndicatorController *)sharedController;

- (void)beginNetworkActivity;
- (void)endNetworkActivity;

@end
