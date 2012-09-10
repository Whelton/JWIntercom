//
//  JWIntercom.h
//
//  Created by James Whelton on 10/09/2012.
//  Copyright (c) 2012 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWIntercom : NSObject <UIWebViewDelegate>{
    NSString *intercomAppID;
    UIWebView *intercomWebView;
}
- (void)startSessionWithUserEmail:(NSString *)email;
- (void)startSessionWithUserEmail:(NSString *)email customData:(NSDictionary *)customData;
- (void)stopSession;

@end
