//
// Created by Marek Bejda on 10/31/14.
// Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "GoogleAccount.h"


@implementation GoogleAccount {

}
-(instancetype)init {
    self = [super init];
    if(self){
        self.properties = [[NSMutableArray  alloc] initWithCapacity:10];

    }
    return self;
}
-(instancetype) initWithSummary:(GTLAnalyticsAccountSummary *)summary{
    self = [self init];

    if(self){
  //  NSLog(@"GoogleAccount:initWithSummary:%@",summary);

    [self setName:summary.name];
    [self setIdentifier:summary.identifier];
        GTLAnalyticsWebPropertySummary *webProp;
        GoogleProperty *prop;

        for(int a=0; a < summary.webProperties.count; a++){

             webProp= [summary.webProperties objectAtIndex:a];
             prop = [[GoogleProperty alloc] initWithSummary:webProp];

            [self.properties addObject:prop];
      }
    //NSLog(@"GoogleAccount:initWithSummary:PropertiesCount %@",[self.properties count]);
    }
    return self;
};

@end

