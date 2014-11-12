//
// Created by Marek Bejda on 11/2/14.
// Copyright (c) 2014 Smoothie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTLAnalyticsProfileSummary.h"

@interface GoogleProfile : NSObject

@property (nonatomic,strong) NSString *identifier;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSNumber *activeVisitors;

@property bool update;



-(id) initWithSummary:(GTLAnalyticsProfileSummary *)summary;

@end