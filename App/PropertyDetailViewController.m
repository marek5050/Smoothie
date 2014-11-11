//
//  PropertyDetailViewController.m
//  App
//
//  Created by Megan Smith on 10/21/14.
//  Copyright (c) 2014 Smoothie. All rights reserved.
//

#import "PropertyDetailViewController.h"
#import "ColorSchemeViewController.h"
#import "PNChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"


@interface PropertyDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *propertyName;
@property (strong, nonatomic) IBOutlet UILabel *url;
@property (strong, nonatomic) IBOutlet UILabel *ID;

@end

@implementation PropertyDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad for PropertyDetailVeiwController");
    
    self.sv.delegate = self;
    
    CGRect viewFrame = self.sv.frame;
    viewFrame.size.height += 400;  // 400 is arbitrary
    self.sv.contentSize = viewFrame.size;
    
    self.profileName.title = self.profile.name;
    
    self.propertyName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    self.propertyName.text = self.property.name;
    [self.sv addSubview:self.propertyName];

    self.url = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 15)];
    self.url.text = self.property.websiteUrl;
    [self.sv addSubview:self.url];
    
    UILabel * lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 30)];
    lineChartLabel.text = @"Line Chart";
    lineChartLabel.textColor = PNFreshGreen;
    lineChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    lineChartLabel.textAlignment = NSTextAlignmentCenter;
    
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 200.0)];
    lineChart.backgroundColor = [UIColor clearColor];
    [lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5",@"SEP 6",@"SEP 7"]];
    
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2, @127.2, @176.2];
    
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // Line Chart Nr.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2, @167.2, @276.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01, data02];
    [lineChart strokeChart];
    
    lineChart.delegate = self;
    
    [self.sv addSubview:lineChartLabel];
    [self.sv addSubview:lineChart];
    
    //self.title = @"Line Chart";
    
//     self.ID.text = self.profile.identifier;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex andPointIndex:(NSInteger)pointIndex{
}

-(void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
}

- (void)userClickedOnBarCharIndex:(NSInteger)barIndex
{
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
