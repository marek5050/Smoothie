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
#import "PNColor.h"


@interface PropertyDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *propertyName;
@property (strong, nonatomic) IBOutlet UILabel *url;
@property (strong, nonatomic) IBOutlet UILabel *ID;
@property (strong, nonatomic) IBOutlet UIButton *emailButton;

@end

@implementation PropertyDetailViewController
int next_y = 90;
int label_graph_margin = 20;
int label_size = 23;
int graph_graph_margin = 30;
int height = 100;

-(int) getHeight:(int) amount{
    height+= amount;
//    viewFrame.size.height = next_y;  // 400 is arbitrary
//    self.sv.contentSize = viewFrame.size;

    return height;
}

-(void) create90DayChart:(GoogleDataArray *)dataset{
    NSLog(@"create90DayChart: ");
    /**
     Write Users for last 90 days - line chart
     **/
    int recentHeight = 120;
    UILabel * lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, next_y, SCREEN_WIDTH, label_size)];
    lineChartLabel.text = @"Users: Last 90 Days";
    lineChartLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
//    next_y += label_size + label_graph_margin;
    next_y = [self getHeight: label_size + label_graph_margin];

    PNLineChart * recentUsersLineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(10, next_y, SCREEN_WIDTH, recentHeight)];
    recentUsersLineChart.backgroundColor = [UIColor clearColor];
  //  next_y += recentHeight + graph_graph_margin;
    next_y = [self getHeight: recentHeight + graph_graph_margin];

    //WILL BE REPLACED WITH IN FORM API - LOGIC TO NOT HAVE TO SHOW ALL THE LABELS
    [recentUsersLineChart setXLabels:@[@"SEP 1",@"",@"SEP 3",@"",@"SEP 5",@"",@"SEP 7"]];
    
    //WILL BE REPLACED WITH REAL DATA FROM THE GOOGLE API
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2, @127.2, @176.2];
    
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = recentUsersLineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    recentUsersLineChart.chartData = @[data01];
    [recentUsersLineChart strokeChart];
    
    recentUsersLineChart.delegate = self;
    
    [self.sv addSubview:lineChartLabel];
    [self.sv addSubview:recentUsersLineChart];
    [self.sv setContentSize:self.sv.frame.size];
    CGSize size =  CGSizeMake(self.sv.frame.size.width,next_y+50);
    self.sv.contentSize=size;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataController = [[GoogleDataController alloc] init];
    _dataController.delegate = self;
    
    
    NSLog(@"viewDidLoad for PropertyDetailVeiwController");
    self.sv.delegate = self;
    self.user.delegate = self;
    
    CGRect viewFrame = self.sv.frame;
    
    self.profileName.title = self.profile.name;
    
    /**
     Write Property Name at Top
    **/
    self.propertyName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH, 15)];
    self.propertyName.text = [NSString stringWithFormat:@"Property: %@", self.property.name];
    self.propertyName.font = [UIFont fontWithName:@"Helvetica" size:16];
    [self.sv addSubview:self.propertyName];

    /**
     Write Property URL
     **/
    self.url = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH, 15)];
    self.url.text = [NSString stringWithFormat:@"URL: %@", self.property.websiteUrl];
    self.url.font = [UIFont fontWithName:@"Helvetica" size:16];
    [self.sv addSubview:self.url];
    
    [_user loadDailyVisitorCount:@90 forProfile:_profile callback:@selector(create90DayChart:)];
    
    /**
     Write User by Country pie chart
     **/
    UILabel * countryPieChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, next_y, SCREEN_WIDTH, label_size)];
    countryPieChartLabel.text = @"Users: By Country";
    countryPieChartLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
//    next_y += label_size + label_graph_margin;
    next_y = [self getHeight:label_size + label_graph_margin];
    
    //WILL BE REPLACED BY DATA FORM API
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:[UIColor greenColor]],
                       [PNPieChartDataItem dataItemWithValue:20 color:[UIColor redColor] description:@"WWDC"],
                       [PNPieChartDataItem dataItemWithValue:40 color:[UIColor blueColor] description:@"GOOL I/O"],
                       ];
    
    
    int countryHeight = 240;
    PNPieChart *countryPieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, next_y, 240.0, countryHeight) items:items];
    countryPieChart.descriptionTextColor = [UIColor whiteColor];
    countryPieChart.descriptionTextFont  = [UIFont fontWithName:@"Helvetica" size:14.0];
    countryPieChart.descriptionTextShadowColor = [UIColor clearColor];
    [countryPieChart strokeChart];
    next_y = [self getHeight:countryHeight + graph_graph_margin];
    //  next_y += countryHeight + graph_graph_margin;
    
    
    [self.sv addSubview:countryPieChartLabel];
    [self.sv addSubview:countryPieChart];
    
    /**
     Write Users by OS - pie chart
     **/
    UILabel * OSPieChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, next_y, SCREEN_WIDTH, label_size)];
    OSPieChartLabel.text = @"Users: By OS";
    OSPieChartLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
//    next_y += label_size + label_graph_margin;
    next_y = [self getHeight:label_size + label_graph_margin];
  
    //WILL BE REPLACED BY DATA FORM API
    NSArray *itemsOS = @[[PNPieChartDataItem dataItemWithValue:25 color:[UIColor greenColor]],
                       [PNPieChartDataItem dataItemWithValue:50 color:[UIColor redColor] description:@"WWDC"],
                       [PNPieChartDataItem dataItemWithValue:25 color:[UIColor blueColor] description:@"GOOL I/O"],
                       ];
    
    
    int osHeight = 240;
    PNPieChart *OSPieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, next_y, 240.0, osHeight) items:itemsOS];
    OSPieChart.descriptionTextColor = [UIColor whiteColor];
    OSPieChart.descriptionTextFont  = [UIFont fontWithName:@"Helvetica" size:14.0];
    OSPieChart.descriptionTextShadowColor = [UIColor clearColor];
    [OSPieChart strokeChart];
   // next_y += osHeight + graph_graph_margin;
    next_y = [self getHeight:osHeight + graph_graph_margin];

    
    [self.sv addSubview:OSPieChartLabel];
    [self.sv addSubview:OSPieChart];
    
    /**
     Write Users by browser - pie chart
     **/
    UILabel * browserPieChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, next_y, SCREEN_WIDTH, label_size)];
    browserPieChartLabel.text = @"Users: By Browser";
    browserPieChartLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    //next_y += label_size + label_graph_margin;
    next_y = [self getHeight:label_size + label_graph_margin];

    
    //WILL BE REPLACED BY DATA FORM API
    NSArray *itemsBrowser = @[[PNPieChartDataItem dataItemWithValue:10 color:[UIColor greenColor]],
                         [PNPieChartDataItem dataItemWithValue:10 color:[UIColor redColor] description:@"WWDC"],
                         [PNPieChartDataItem dataItemWithValue:10 color:[UIColor blueColor] description:@"GOOL I/O"],
                         ];
    
    
    int browserHeight = 240;
    PNPieChart *browserPieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, next_y, 240.0, browserHeight) items:itemsBrowser];
    browserPieChart.descriptionTextColor = [UIColor whiteColor];
    browserPieChart.descriptionTextFont  = [UIFont fontWithName:@"Helvetica" size:14.0];
    browserPieChart.descriptionTextShadowColor = [UIColor clearColor];
    [browserPieChart strokeChart];
   // next_y += osHeight + graph_graph_margin;
    next_y = [self getHeight:osHeight + graph_graph_margin];
    
    [self.sv addSubview:browserPieChartLabel];
    [self.sv addSubview:browserPieChart];
    
    //common keywords - "tableview"
    UILabel * commonKeywordsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, next_y, SCREEN_WIDTH, label_size)];
    commonKeywordsLabel.text = @"Search Keywords";
    commonKeywordsLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
//    next_y += label_size + label_graph_margin;
    next_y = [self getHeight:label_size + label_graph_margin];

    [self.sv addSubview:commonKeywordsLabel];
    NSArray *keywords = @[@[@"Mercedes-Benz", @20], @[@"marek", @10], @[@"yash", @10], @[@"megan", @10]];
    
    // shitty table view
    for (NSArray *obj in keywords) {
        UILabel *left = [[UILabel alloc] initWithFrame:CGRectMake(10, next_y, SCREEN_WIDTH - 20, 18)];
        left.text = obj[0];
        left.font = [UIFont fontWithName:@"Helvetica" size:16];
        UILabel *right = [[UILabel alloc] initWithFrame:CGRectMake(10, next_y, SCREEN_WIDTH - 20, 18)];
        right.text = [obj[1] stringValue];
        right.font = [UIFont fontWithName:@"Helvetica" size:16];
        right.textAlignment = UITextAlignmentRight;
        next_y = [self getHeight:22];
//next_y += 22;
        UILabel *separator = [[UILabel alloc] initWithFrame:CGRectMake(10, next_y, SCREEN_WIDTH - 20, 0.5)];
        separator.backgroundColor = [UIColor blackColor];
  //      next_y += 2;
        next_y = [self getHeight:2];

        [self.sv addSubview:left];
        [self.sv addSubview:right];
        [self.sv addSubview:separator];

    }
    
    next_y = [self getHeight:55];
//    next_y += 50;
    self.ID = [[UILabel alloc] initWithFrame:CGRectMake(50, next_y, SCREEN_WIDTH, label_size)];
    self.ID.text = [NSString stringWithFormat: @"ID: %@", self.profile.identifier];
    [self.sv addSubview:self.ID];

    self.emailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.emailButton.frame = CGRectMake(50, next_y, SCREEN_WIDTH, label_size);
    [self.emailButton setTitle:@"Email JS" forState:UIControlStateNormal];
    [self.emailButton addTarget:self
               action:@selector(emailJS:)
     forControlEvents:UIControlEventTouchUpInside];
//    self.emailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.sv addSubview:self.emailButton];
//    next_y += label_size + 25;
    next_y = [self getHeight:label_size + 25];
  
    viewFrame.size.height = next_y;  // 400 is arbitrary
    self.sv.contentSize = viewFrame.size;

    NSLog(@"Next_y: %d", next_y);
}

- (void) emailJS: (UIButton*)button{
    NSLog(@"EMAILING JS");
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
-(void)viewDidDisappear:(BOOL)animated{
    height=100;
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
