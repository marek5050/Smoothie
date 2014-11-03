//
// Created by Marek Bejda on 11/2/14.
// Copyright (c) 2014 Smoothie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleProfile.h"
#import "GTLAnalyticsWebPropertySummary.h"

@interface GoogleProperty : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *identifier;
@property (nonatomic,strong) NSString *websiteUrl;
@property (nonatomic,strong) NSString *level;
@property (nonatomic,strong) NSString *internalWebPropertyId;

@property (nonatomic, strong) NSMutableArray *profiles;
-(instancetype) initWithSummary:(GTLAnalyticsWebPropertySummary *) summary;
@end