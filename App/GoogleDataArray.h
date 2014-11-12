//
//  GoogleDataArray.h
//  App
//
//  Created by Marek Bejda on 11/11/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GoogleDataDelegate    <NSObject>
@optional
-(void) interfaceUpdate;

@end

@interface GoogleDataArray : NSObject
    @property (atomic,strong) NSArray *dataValues;
    @property (atomic,strong) NSMutableArray *xValues;
    @property (atomic,strong) NSMutableArray *yValues;
    @property (atomic, strong) NSNumber *status;

-(instancetype) init;
@end
