//
// Created by Marek Bejda on 11/2/14.
// Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "GTLAnalytics.h"
#import <Foundation/Foundation.h>
#import "GoogleAccount.h"
#import "GTMOAuth2Authentication.h"
#import "GoogleDataArray.h"

@protocol GoogleUserDelegate    <NSObject>
@required
    -(void) interfaceUpdate;

@end


@interface User : NSObject
    @property (strong,nonatomic) NSString *name;

    @property GTLServiceAnalytics *service;
    @property (strong,nonatomic) GTMOAuth2Authentication *auth;
    @property (strong, nonatomic) GoogleAccount *active;
    @property (strong, nonatomic) NSMutableArray *accounts;

    @property id <GoogleUserDelegate> delegate;

    @property  bool authorized;


  -(instancetype) init;
  -(void) loadUserSummary;
  -(void) loadUserRealTimeForActive;

  -(GoogleDataArray *) loadUsersByKeyword:(NSNumber *)days forProfile:(GoogleProfile *)profile callback:(SEL)selector;
  -(GoogleDataArray *) loadUsersByOS:(NSNumber *)days forProfile:(GoogleProfile *)profile callback:(SEL)selector;
  -(GoogleDataArray *) loadDailyVisitorCount:(NSNumber *)days forProfile:(GoogleProfile *)profile callback:(SEL)selector;
  -(GoogleDataArray *) loadUsersByCountry:(NSNumber *)days forProfile:(GoogleProfile *)profile callback:(SEL)selector;
  -(GoogleDataArray *) loadUsersByBrowser:(NSNumber *)days forProfile:(GoogleProfile *)profile callback:(SEL)selector;


@end
