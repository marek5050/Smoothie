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
//                NSLog(@"User:loadUserRealTimeForActive:RequestId: %@", [prof identifier]);

                GTLQueryAnalytics *query = [GTLQueryAnalytics queryForDataRealtimeGetWithIds:req metrics:@"rt:activeUsers"];

                    [self.service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLAnalyticsRealtimeData *data,
                            NSError *error) {

                    if (error == nil) {

                        if([data.rows count]>0){
                            [prof setActiveVisitors:[[data.rows objectAtIndex:0] objectAtIndex:0]];
                        }else{
                            [prof setActiveVisitors:@0];
                        }
                        
                        if([_delegate respondsToSelector:@selector(interfaceUpdate:)] )
                        [_delegate interfaceUpdate];

                    } else {
                        NSLog(@"An error occurred: %@", error);
                    }
                }];
            }
        }
    }
}

-(void) loadDataQuery:(GTLQueryAnalytics *)query withSkip:(BOOL)skip callback:(SEL)selector{
    NSLog(@"User:loadDataQuery: %@",query);
    
    [self.service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLAnalyticsGaData *data, NSError *error){
        if (error == nil) {
            
            GoogleDataArray *gArr = [[GoogleDataArray alloc] init];
            [gArr setDataValues:data.rows withSkip:skip];
            if([_delegate respondsToSelector:selector] )
            [_delegate performSelector: selector withObject:gArr];
            
        } else {
            NSLog(@"An error occurred: %@", error);
        }
    }];
}

-(void) receiveResponse:(GTLQueryAnalytics *)query callback:(SEL) selector property:(GoogleProperty *)property{
    NSLog(@"User:ReceiveResponse:");
    
    [self.service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLAnalyticsProfile *profile, NSError *error){
        if (error == nil) {
            
            GoogleProfile *prof = [[GoogleProfile alloc] initWithProfile: profile];
            [property.profiles addObject:prof];
            
            NSLog(@"Received: %@", [profile identifier]);
            
          [_delegate performSelector: selector withObject:@"Succesfully created profile. You might have to restart the application to view the new profile in the list."];
        } else {
            NSLog(@"An error occurred: %@", error);
            [_delegate performSelector: selector withObject:@"Error"];
        }
    }];
}
-(void) addProfileFor:(GoogleProperty *)property withName:(NSString *)name type:(NSString *)type timeZone:(NSString *)time currency:(NSString *)currency callback:(SEL)selector{

    NSLog(@"User:addProfileFor:PropertiesCount:%@",[property identifier]);
    GTLAnalyticsProfile *profile = [GTLAnalyticsProfile new];
    [profile setName:name];
    [profile setType:type];
    [profile setTimezone:time];
    [profile setCurrency:currency];
//    [profile setWebsiteUrl:@"http://www.1xcloud.com/"];
    GTLQueryAnalytics *query = [GTLQueryAnalytics queryForManagementProfilesInsertWithObject:profile accountId:[_active identifier] webPropertyId:[property identifier]];
    [self receiveResponse:query callback:selector property:property];
    
}

-(void) loadUsersByCountry:(NSNumber *)days forProfile:(GoogleProfile *)profile callback:(SEL)selector{
    NSLog(@"User:loadUsersByCountry:PropertiesCount:%@",[profile identifier]);
    
    NSString *start = [NSString stringWithFormat:@"%@daysAgo",days];
    NSString *profid = [NSString stringWithFormat:@"ga:%@",[profile identifier]];
    
    GTLQueryAnalytics *query = [GTLQueryAnalytics queryForDataGaGetWithIds:profid startDate:start endDate:@"today" metrics:@"ga:users"];
    [query setDimensions:@"ga:country"];
    [self loadDataQuery:query withSkip:false callback:selector];
}


-(void) loadUsersByKeyword:(NSNumber *)days forProfile:(GoogleProfile *)profile callback:(SEL)selector{
    NSLog(@"User:loadUsersByCountry:PropertiesCount:%@",[profile identifier]);
    
    NSString *start = [NSString stringWithFormat:@"%@daysAgo",days];
    NSString *profid = [NSString stringWithFormat:@"ga:%@",[profile identifier]];
    
    GTLQueryAnalytics *query = [GTLQueryAnalytics queryForDataGaGetWithIds:profid startDate:start endDate:@"today" metrics:@"ga:users"];
    [query setDimensions:@"ga:keyword"];
    [self loadDataQuery:query withSkip:false callback:selector];
}


-(void) loadUsersByOS:(NSNumber *)days forProfile:(GoogleProfile *)profile callback:(SEL)selector{
    NSLog(@"User:loadUsersByKeyword:PropertiesCount:%@",[profile identifier]);
   
    NSString *start = [NSString stringWithFormat:@"%@daysAgo",days];
    NSString *profid = [NSString stringWithFormat:@"ga:%@",[profile identifier]];
    
    GTLQueryAnalytics *query = [GTLQueryAnalytics queryForDataGaGetWithIds:profid startDate:start endDate:@"today" metrics:@"ga:users"];
    [query setDimensions:@"ga:operatingSystem"];
    [self loadDataQuery:query withSkip:false callback:selector];
    
}


-(void) loadUsersByBrowser:(NSNumber *)days forProfile:(GoogleProfile *)profile callback:(SEL)selector{
    NSLog(@"User:loadUsersByBrowser:PropertiesCount:%@",[profile identifier]);
    
    NSString *start = [NSString stringWithFormat:@"%@daysAgo",days];
    NSString *profid = [NSString stringWithFormat:@"ga:%@",[profile identifier]];
    
    GTLQueryAnalytics *query = [GTLQueryAnalytics queryForDataGaGetWithIds:profid startDate:start endDate:@"today" metrics:@"ga:users"];
    [query setDimensions:@"ga:browser"];
    [self loadDataQuery:query withSkip:false callback:selector];
}


-(void) loadDataFor:(NSNumber *)days forProfile:(GoogleProfile *)profile callback:(SEL)selector{
    NSLog(@"User:loadUsersByBrowser:PropertiesCount:%@",[profile identifier]);
    
   NSString *start = [NSString stringWithFormat:@"%@daysAgo",days];
   NSString *profid = [NSString stringWithFormat:@"ga:%@",[profile identifier]];
    
   GTLQueryAnalytics *query = [GTLQueryAnalytics queryForDataGaGetWithIds:profid startDate:start endDate:@"today" metrics:@"ga:users"];
   [query setDimensions:@"ga:browser,ga:country, ga:operatingSystem, ga:date"];
    [self loadDataQuery:query withSkip:false callback:selector];
}



-(void) loadDailyVisitorCount:(NSNumber *)days forProfile:(GoogleProfile *)profile callback:(SEL)selector{
    NSLog(@"User:loadDailyVisitorCount:PropertiesCount:%@",[profile identifier]);
    
    NSString *start = [NSString stringWithFormat:@"%@daysAgo",days];
    NSString *profid = [NSString stringWithFormat:@"ga:%@",[profile identifier]];
    
    GTLQueryAnalytics *query = [GTLQueryAnalytics queryForDataGaGetWithIds:profid startDate:start endDate:@"today" metrics:@"ga:users"];
    [query setDimensions:@"ga:date"];
    [self loadDataQuery:query withSkip:true callback:selector];
}


- (void)setActive:(GoogleAccount *)act{
    if(act == nil){
       _active = [_accounts objectAtIndex:0];
    }else{
      _active = act;
    }
}

-(void)loadUserSummary{
    NSLog(@"loadUserSummary");
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
        if(_active==nil)
            [self setActive:[self.accounts objectAtIndex:0]];
//        [self loadUserRealTimeForActive];

            if([_delegate respondsToSelector:@selector(interfaceUpdate:)] )
                [_delegate interfaceUpdate];
        } else {
            NSLog(@"An error occurred: %@", error);
        }
    }];
}
@end