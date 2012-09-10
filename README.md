# JWIntercom #
### A basic iOS library for [Intercom.io](http://www.intercom.io) ###

Adds Intercom to your app with basic functionality and custom data, hacked off their JS API through a UIWebView.

Make sure to **define your Intercom App ID (*kIntercomAppID*)** at the top of **JWIntercom.m**

---

###Start User Session
    intercom = [[JWIntercom alloc] init];
    [intercom startSessionWithUserEmail:@"user@email.com"];




###Start User Session With Custom Data
    NSMutableDictionary *myCustomData = [[NSMutableDictionary alloc] init];
    [myCustomData setValue:@"jwhelton" forKey:@"github"];
    [myCustomData setValue:@"premium" forKey:@"account_type"];

    intercom = [[JWIntercom alloc] init];
    [intercom startSessionWithUserEmail:@"user@email.com" customData:myCustomData];

###End User Session
    [intercom stopSession];

----
###Todo###
* Add secure mode with SHA1
* Add messaging