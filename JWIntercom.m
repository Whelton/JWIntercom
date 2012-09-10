//
//  JWIntercom.m
//
//  Created by James Whelton on 10/09/2012.
//  Copyright (c) 2012 . All rights reserved.
//

#import "JWIntercom.h"
#define kIntercomAppID @"" //Your Intercom App ID goes here! 

@implementation JWIntercom

- (id)init{
    return self;
}


- (void)startSessionWithUserEmail:(NSString *)email{
    //check if we have an Intercom App ID which should have been defined above
    if(kIntercomAppID != @""){
        //Setup our webview for intercom
        intercomWebView = [[UIWebView alloc] init];
        int createdAtDate;
        id userDefaultsKey = [NSString stringWithFormat:@"Intercom+%@", email];
        
        //check if the user is new or not
        if(![[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsKey]){
            //New user, generate a creation date
            createdAtDate = [[NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]] intValue];
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f", createdAtDate] forKey:userDefaultsKey];
        } else {
            //Existing user, grab the creation date
            createdAtDate = [[NSString stringWithFormat:@"%f", [[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsKey]] intValue];
        }
        
        //Get together our intercom HTML string, load it, happy days
        NSString *intercomHTMLString = [NSString stringWithFormat:@"<script id='IntercomSettingsScriptTag'> var intercomSettings = { app_id: '%@', email: '%@', created_at: %d }; </script> <script> (function() { function async_load() { var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true; s.src = 'https://api.intercom.io/api/js/library.js'; var x = document.getElementsByTagName('script')[0]; x.parentNode.insertBefore(s, x); } if (window.attachEvent) { window.attachEvent('onload', async_load); } else { window.addEventListener('load', async_load, false); } })(); </script>", kIntercomAppID, email, createdAtDate];
        [intercomWebView loadHTMLString:intercomHTMLString baseURL:nil];
    } else {
        //Damn 'someone' forgot to define the intercom app ID, throw an exception
        [NSException raise:@"No Intercom App ID" format:@"Intercom app ID not defined. Define at top of JWIntercom.m"];
    }
}

- (void)startSessionWithUserEmail:(NSString *)email customData:(NSDictionary *)customData{
    //check if we have an Intercom App ID which should have been defined above
    if(kIntercomAppID != @""){
        //Setup our webview for intercom
        intercomWebView = [[UIWebView alloc] init];
        int createdAtDate;
        id userDefaultsKey = [NSString stringWithFormat:@"Intercom+%@", email];
        
        //check if the user is new or not
        if(![[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsKey]){
            //New user, generate a creation date
            createdAtDate = [[NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]] intValue];
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f", createdAtDate] forKey:userDefaultsKey];
        } else {
            //Existing user, grab the creation date
            createdAtDate = [[NSString stringWithFormat:@"%f", [[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsKey]] intValue];
        }
        
        //Get together our intercom HTML string, load it, happy days
        NSString *customDataString = @" custom_data: {";
        for (NSString* key in customData){
            customDataString = [NSString stringWithFormat:@"%@ '%@' : '%@',", customDataString, key, [customData objectForKey:key]];
        }
        customDataString = [customDataString substringToIndex:[customDataString length] - 1];
        customDataString = [NSString stringWithFormat:@"%@ }", customDataString];
        NSString *intercomHTMLString = [NSString stringWithFormat:@"<script id='IntercomSettingsScriptTag'> var intercomSettings = { app_id: '%@', email: '%@', created_at: %d, %@ }; </script> <script> (function() { function async_load() { var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true; s.src = 'https://api.intercom.io/api/js/library.js'; var x = document.getElementsByTagName('script')[0]; x.parentNode.insertBefore(s, x); } if (window.attachEvent) { window.attachEvent('onload', async_load); } else { window.addEventListener('load', async_load, false); } })(); </script>", kIntercomAppID, email, createdAtDate, customDataString];
        [intercomWebView loadHTMLString:intercomHTMLString baseURL:nil];
    } else {
        //Damn 'someone' forgot to define the intercom app ID, throw an exception
        [NSException raise:@"No Intercom App ID" format:@"Intercom app ID not defined. Define at top of JWIntercom.m"];
    }


}
- (void)stopSession{
    //Just load a blank html string
    [intercomWebView loadHTMLString:@"" baseURL:nil];
}
@end
