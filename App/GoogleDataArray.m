//
//  GoogleDataArray.m
//  App
//
//  Created by Marek Bejda on 11/11/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "GoogleDataArray.h"

@implementation GoogleDataArray


-(instancetype) init{
    self = [super init];
   if(self){
       
       _status=@0;
       _dataValues = nil;
       _xValues = nil;
       _yValues = nil;
   }
  return self;
}

-(void) setDataValues:(NSArray *)dataValues{
    if(dataValues.count==0) {
        _status = @0;
        return;
    }

    _dataValues = dataValues;
    _xValues = [[NSMutableArray alloc] initWithCapacity:dataValues.count];
    _yValues = [[NSMutableArray alloc] initWithCapacity:dataValues.count];
    for(int i=0;i < dataValues.count; i++){
       // if(i%20==0){
            [_xValues addObject: [[dataValues objectAtIndex:i] objectAtIndex:0]];
       // }else{
        //    [_xValues addObject:@""];
      //  }
        [_yValues addObject: [[dataValues objectAtIndex:i] objectAtIndex:1]];
    
    }
    _status = @1;
}


@end