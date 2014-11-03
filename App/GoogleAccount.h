//
// Created by Marek Bejda on 10/31/14.
// Copyright (c) 2014 Smoothie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleProperty.h"
#import "GTLAnalyticsAccountSummary.h"

@interface GoogleAccount : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *identifier;
@property (nonatomic,strong) NSMutableArray *properties;
-(instancetype) init;
-(instancetype) initWithSummary:(GTLAnalyticsAccountSummary *)summary;
@end