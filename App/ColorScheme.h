//
//  ColorScheme.h
//  App
//
//  Created by Megan Avery on 11/2/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h> 

@interface ColorScheme : NSObject

@property (nonatomic, strong) NSArray *options;
@property (nonatomic, strong) NSMutableDictionary *forest;
@property (nonatomic, strong) NSMutableDictionary *sunrise;
@property (nonatomic, strong) NSMutableDictionary *midnight;

@end



