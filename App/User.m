//
// Created by Marek Bejda on 11/2/14.
// Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "User.h"
#import "GTLQueryAnalytics.h"
#import "GTLAnalyticsAccountSummaries.h"
#import "GTLAnalyticsWebPropertySummary.h"
#import "GTLAnalyticsRealtimeData.h"


@implementation User {

}
-(id) init{
    self = [super init];

    if(self){
     //   NSLog(@"User:init");
        self.accounts = [[NSMutableArray  alloc] init];
        self.authorized = NO;

    };
    return self;
}



-(void) loadUserRealTimeForActive{
    NSLog(@"User:loadUserRealTimeForActive:PropertiesCount:%d",[self.active.properties count]);

    NSString *req;
    GoogleProperty *prop;
    GoogleProfile *prof;

    for(int i=0;i<[self.active.properties count]; i++){

        prop = [self.active.properties objectAtIndex:i];

        for(int j=0; j < [prop.profiles count]; j++){
            prof = [[prop profiles] objectAtIndex:j];
            if(prof.update){

                req = [[NSString alloc] initWithFormat:@"ga:%@",[prof identifier]];
                NSLog(@"User:loadUserRealTimeForActive:RequestId: %@", [prof identifier]);

                GTLQueryAnalytics *query = [GTLQueryAnalytics queryForDataRealtimeGetWithIds:req metrics:@"rt:activeUsers"];

                    [self.service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLAnalyticsRealtimeData *data,
                            NSError *error) {

                    if (error == nil) {

                        [prof setActiveVisitors:[[data.rows objectAtIndex:0] objectAtIndex:0]];

                    } else {
                        NSLog(@"An error occurred: %@", error);
                    }
                }];
            }
        }
    }
   //[_delegate interfaceUpdate];
}

- (void)setActive:(GoogleAccount *)act{
    if(act == nil){
       _active = [_accounts objectAtIndex:0];
    }else{
      _active = act;
    }
}


-(void)loadUserSummary{
    GTLQueryAnalytics *query = [GTLQueryAnalytics queryForManagementAccountSummariesList];

    [self.service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLAnalyticsAccountSummaries *accountSummaries,
            NSError *error) {


        if (error == nil) {

            NSLog(@"User:loadUserSummary: %@",accountSummaries);
            [self.accounts removeAllObjects];

            GoogleAccount *account;
            GTLAnalyticsAccountSummary *accountSummary;

            for(int i=0; i < accountSummaries.items.count; i++){

                accountSummary = [accountSummaries.items objectAtIndex:i];

                account = [[GoogleAccount alloc] initWithSummary:accountSummary];

                [self.accounts addObject:account];

            }

        //NSLog(@"Size of accounts..%d", [self.accounts count]);
        [self setActive:[self.accounts objectAtIndex:0]];
        [self loadUserRealTimeForActive];
        [_delegate interfaceUpdate];
        } else {
            NSLog(@"An error occurred: %@", error);
        }
    }];
}
@end