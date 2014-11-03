//
// Created by Marek Bejda on 11/2/14.
// Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "GoogleProperty.h"
#import "GTLAnalyticsWebPropertySummary.h"


@implementation GoogleProperty {

}

-(instancetype) init{
    self = [super init];

    if(self){
        self.profiles = [[NSMutableArray  alloc] init];

    }
    return self;
}

-(instancetype) initWithSummary:(GTLAnalyticsWebPropertySummary *)summary{
    self = [self init];
    if(self){
     //   NSLog(@"GoogleProperty:initWithSummary:%@",summary);

        [self setName:summary.name];
        [self setIdentifier:summary.identifier];
        [self setInternalWebPropertyId:summary.internalWebPropertyId];
        [self setWebsiteUrl:summary.websiteUrl];
        [self setLevel:summary.level];
        GTLAnalyticsProfileSummary *prof;
        GoogleProfile *profile;

        for(int i=0; i < summary.profiles.count;i++){
            prof = [summary.profiles objectAtIndex:i];
            profile=[[GoogleProfile alloc] initWithSummary:prof];

            [self.profiles addObject:profile];
        }
    }
    return self;
}

@end