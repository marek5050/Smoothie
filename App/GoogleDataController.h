//
//  GoogleDataController.h
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


@interface GoogleDataController : NSObject

    @property (atomic,strong) NSDictionary *requests;
    @property id <GoogleDataDelegate> delegate;


-(instancetype) init;
@end
