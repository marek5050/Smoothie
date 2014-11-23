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
#import "AppDelegate.h"


@interface PropertyDetailViewController ()

//ARE CREATED PROGRAMATICCALY LATER
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
    /**
     Write Users for last 90 days - line chart
     **/
    if([dataset.xValues count] == 0) {
        UILabel * errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, SCREEN_WIDTH, label_size)];
        errorLabel.text = @"No data yet :(";
        errorLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        errorLabel.textColor = [UIColor blueColor];
        [self.sv addSubview:errorLabel];
    }
    for(int i = 0; i < [dataset.xValues count]; i++) {
        if(((NSString*)dataset.xValues[i]).length != 0) {
            NSString *date = (NSString*)[dataset.xValues objectAtIndex:i];
            NSRange monthRange = NSMakeRange(4, 2);
            NSRange dayRange = NSMakeRange(6, 2);
            NSString *month = [date substringWithRange:monthRange];
            NSString *day = [date substringWithRange:dayRange];
            dataset.xValues[i] = [[NSString alloc] initWithFormat:@"%@/%@", month, day];
        }
    }
    int recentHeight = 120;
    UILabel * lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-10, label_size)];
    lineChartLabel.text = @"Users: Last 90 Days";
    lineChartLabel.textColor = [self.selectedScheme valueForKey:@"textColor"];
    lineChartLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
//    next_y += label_size + label_graph_margin;
    next_y = [self getHeight: label_size + label_graph_margin];

    PNLineChart * recentUsersLineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH-10, recentHeight)];
    recentUsersLineChart.backgroundColor = [UIColor clearColor];
    recentUsersLineChart.tintColor = [self.selectedScheme valueForKey:@"textColor"];
    
  //  next_y += recentHeight + graph_graph_margin;
    next_y = [self getHeight: recentHeight + graph_graph_margin];

    //WILL BE REPLACED WITH IN FORM API - LOGIC TO NOT HAVE TO SHOW ALL THE LABELS
    //[recentUsersLineChart setXLabels:@[@"SEP 1",@"",@"SEP 3",@"",@"SEP 5",@"",@"SEP 7"]];
    [recentUsersLineChart setXLabels:dataset.xValues];
    
    //WILL BE REPLACED WITH REAL DATA FROM THE GOOGLE API
  //  NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2, @127.2, @176.2];
    
    PNLineChartData *data01 = [PNLineChartData new];
    NSArray *colors = [self.selectedScheme valueForKey:@"colorsArray"];
    data01.color = [colors objectAtIndex:0];
    data01.itemCount = recentUsersLineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [dataset.yValues[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    recentUsersLineChart.chartData = @[data01];
    [recentUsersLineChart strokeChart];
    
    recentUsersLineChart.delegate = self;
    
    [self.sv addSubview:lineChartLabel];
    [self.sv addSubview:recentUsersLineChart];
   // [self.sv setContentSize:self.sv.frame.size];
    //CGSize size =  CGSizeMake(self.sv.frame.size.width,next_y+50);
   // self.sv.contentSize=size;
}
-(void)createDataCharts:(GoogleDataArray *)dataset{
    NSLog(@"DataSet: ");
}

-(void) interfaceUpdate{
    
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
    
    //[_user loadDataFor:@90 forProfile:_profile callback:@selector(createDataCharts:)];
    
    [_user loadDailyVisitorCount:@90 forProfile:_profile callback:@selector(create90DayChart:)];
    
    /**
     Write User by Country pie chart
     **/
    [_user loadUsersByCountry:@90 forProfile:_profile callback:@selector(createUserByCountryChart:)];
    
    /**
     Write Users by OS - pie chart
     **/
    [_user loadUsersByOS:@90 forProfile:_profile callback:@selector(createUsersByOSChart:)];
    
    /**
     Write Users by browser - pie chart
     **/
    [_user loadUsersByBrowser:@90 forProfile:_profile callback:@selector(createUsersByBrowserChart:)];
    
    //common keywords - "tableview"
    [_user loadUsersByKeyword:@90 forProfile:_profile callback:@selector(createCommonKeywordsChart:)];

    
    //next_y = [self getHeight:55];

//    next_y += label_size + 25;
    //next_y = [self getHeight:label_size + 25];
  
    viewFrame.size.height = 1500;  // 400 is arbitrary
    self.sv.contentSize = viewFrame.size;
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.selectedScheme = appDelegate.selectedScheme;
    [self setColors];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changedColors:) name:changeScheme object:nil];

    NSLog(@"Next_y: %d", next_y);
}

-(void) setColors {
    UIColor *textColor = [self.selectedScheme valueForKey:@"textColor"];
    
    self.propertyName.textColor = textColor;
    self.url.textColor = textColor;
    self.ID.textColor = textColor;
    
    self.view.backgroundColor = [self.selectedScheme valueForKey:@"backgroundColor"];
}

-(void) createUserByCountryChart:(GoogleDataArray *)dataset{
    NSLog(@"dataset count %d\n", [dataset.xValues count]);
    UILabel * countryPieChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 260, SCREEN_WIDTH, label_size)];
    countryPieChartLabel.text = @"Users: By Country";
    countryPieChartLabel.textColor = [self.selectedScheme valueForKey:@"textColor"];
    countryPieChartLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    //    next_y += label_size + label_graph_margin;
    //next_y = [self getHeight:label_size + label_graph_margin];
    if([dataset.xValues count] == 0) {
        UILabel * errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, SCREEN_WIDTH, label_size)];
        errorLabel.text = @"No data yet :(";
        errorLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        errorLabel.textColor = [UIColor blueColor];
        [self.sv addSubview:errorLabel];
    }
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    NSArray *colors = [self.selectedScheme valueForKey:@"colorsArray"];
    
    int stop = MIN(5, [dataset.xValues count]);
    for(int index = 0; index < stop; ++index){
        NSString *xValue = dataset.xValues[index];
        int yValue = [dataset.yValues[index] intValue];
        
        [items addObject:[PNPieChartDataItem dataItemWithValue:yValue color:colors[index] description:xValue]];
    }
    
    int countryHeight = 240;
    PNPieChart *countryPieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 300, 240.0, countryHeight) items:items];
    countryPieChart.descriptionTextColor = [UIColor whiteColor];
    countryPieChart.descriptionTextFont  = [UIFont fontWithName:@"Helvetica" size:14.0];
    countryPieChart.descriptionTextShadowColor = [UIColor clearColor];
    [countryPieChart strokeChart];
    //next_y = [self getHeight:countryHeight + graph_graph_margin];
    //  next_y += countryHeight + graph_graph_margin;
    
    
    [self.sv addSubview:countryPieChartLabel];
    [self.sv addSubview:countryPieChart];
}

-(void) createUsersByOSChart:(GoogleDataArray *)dataset {
    if([dataset.xValues count] == 0) {
        UILabel * errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 560, SCREEN_WIDTH, label_size)];
        errorLabel.text = @"No data yet :(";
        errorLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        errorLabel.textColor = [UIColor blueColor];
        [self.sv addSubview:errorLabel];
    }
    UILabel * OSPieChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 540, SCREEN_WIDTH, label_size)];
    OSPieChartLabel.text = @"Users: By OS";
    OSPieChartLabel.textColor = [self.selectedScheme valueForKey:@"textColor"];
    OSPieChartLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    //    next_y += label_size + label_graph_margin;
    //next_y = [self getHeight:label_size + label_graph_margin];
    
    
    NSMutableArray *itemsOS = [[NSMutableArray alloc] init];
    
    NSArray *colors = [self.selectedScheme valueForKey:@"colorsArray"];
    
    int stop = MIN(5, [dataset.xValues count]);
    for(int index = 0; index < stop; ++index){
        NSString *xValue = dataset.xValues[index];
        int yValue = [dataset.yValues[index] intValue];
        
        [itemsOS addObject:[PNPieChartDataItem dataItemWithValue:yValue color:colors[index] description:xValue]];
    }
    
    int osHeight = 240;
    PNPieChart *OSPieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 560, 240.0, osHeight) items:itemsOS];
    OSPieChart.descriptionTextColor = [UIColor whiteColor];
    OSPieChart.descriptionTextFont  = [UIFont fontWithName:@"Helvetica" size:14.0];
    OSPieChart.descriptionTextShadowColor = [UIColor clearColor];
    [OSPieChart strokeChart];
    // next_y += osHeight + graph_graph_margin;
    next_y = [self getHeight:osHeight + graph_graph_margin];
    
    [self.sv addSubview:OSPieChartLabel];
    [self.sv addSubview:OSPieChart];
}

-(void) createUsersByBrowserChart:(GoogleDataArray *)dataset {
    if([dataset.xValues count] == 0) {
        UILabel * errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 860, SCREEN_WIDTH, label_size)];
        errorLabel.text = @"No data yet :(";
        errorLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        errorLabel.textColor = [UIColor blueColor];
        [self.sv addSubview:errorLabel];
    }
    UILabel * browserPieChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 820, SCREEN_WIDTH, label_size)];
    browserPieChartLabel.text = @"Users: By Browser";
    browserPieChartLabel.textColor = [self.selectedScheme valueForKey:@"textColor"];
    browserPieChartLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    //next_y += label_size + label_graph_margin;
    next_y = [self getHeight:label_size + label_graph_margin];
    
    
    NSMutableArray *itemsBrowser = [[NSMutableArray alloc] init];
    
    NSArray *colors = [self.selectedScheme valueForKey:@"colorsArray"];
    
    int stop = MIN(5, [dataset.xValues count]);
    for(int index = 0; index < stop; ++index){
        NSString *xValue = dataset.xValues[index];
        int yValue = [dataset.yValues[index] intValue];
        
        [itemsBrowser addObject:[PNPieChartDataItem dataItemWithValue:yValue color:colors[index] description:xValue]];
    }
    
    
    int browserHeight = 240;
    PNPieChart *browserPieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 860, 240.0, browserHeight) items:itemsBrowser];
    browserPieChart.descriptionTextColor = [UIColor whiteColor];
    browserPieChart.descriptionTextFont  = [UIFont fontWithName:@"Helvetica" size:14.0];
    browserPieChart.descriptionTextShadowColor = [UIColor clearColor];
    [browserPieChart strokeChart];
    // next_y += osHeight + graph_graph_margin;
    next_y = [self getHeight:browserHeight + graph_graph_margin];
    
    [self.sv addSubview:browserPieChartLabel];
    [self.sv addSubview:browserPieChart];
}

- (void) createCommonKeywordsChart:(GoogleDataArray *)dataset {
    if([dataset.xValues count] == 0) {
        UILabel * errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 1160, SCREEN_WIDTH, label_size)];
        errorLabel.text = @"No data yet :(";
        errorLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        errorLabel.textColor = [UIColor blueColor];
        [self.sv addSubview:errorLabel];
    }
    UILabel * commonKeywordsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 1140, SCREEN_WIDTH, label_size)];
    commonKeywordsLabel.text = @"Search Keywords";
    commonKeywordsLabel.textColor = [self.selectedScheme valueForKey:@"textColor"];
    commonKeywordsLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    //    next_y += label_size + label_graph_margin;
    next_y = 1160;
    
    [self.sv addSubview:commonKeywordsLabel];
    NSMutableArray *keywords = [[NSMutableArray alloc] init];//@[@[@"Mercedes-Benz", @20], @[@"marek", @10], @[@"yash", @10], @[@"megan", @10]];

    int stop = MIN(5, [dataset.xValues count]);
    for(int index = 0; index < stop; ++index){
        NSString *xValue = dataset.xValues[index];
        NSNumber *yValue = [[NSNumber alloc] initWithInt:[dataset.yValues[index] intValue]];
        NSArray *arr = @[xValue, yValue];
        
        [keywords addObject:arr];
    }
    
    // shitty table view
    for (NSArray *obj in keywords) {
        UILabel *left = [[UILabel alloc] initWithFrame:CGRectMake(10, next_y, SCREEN_WIDTH - 20, 18)];
        left.text = obj[0];
        left.font = [UIFont fontWithName:@"Helvetica" size:16];
        UILabel *right = [[UILabel alloc] initWithFrame:CGRectMake(10, next_y, SCREEN_WIDTH - 20, 18)];
        right.text = [obj[1] stringValue];
        right.font = [UIFont fontWithName:@"Helvetica" size:16];
        right.textAlignment = NSTextAlignmentRight;
        //next_y = [self getHeight:22];
        next_y += 22;
        UILabel *separator = [[UILabel alloc] initWithFrame:CGRectMake(10, next_y, SCREEN_WIDTH - 20, 0.5)];
        separator.backgroundColor = [UIColor blackColor];
              next_y += 2;
        //next_y = [self getHeight:2];
        
        [self.sv addSubview:left];
        [self.sv addSubview:right];
        [self.sv addSubview:separator];
        
    }
    next_y += 50;
    self.ID = [[UILabel alloc] initWithFrame:CGRectMake(50, next_y, SCREEN_WIDTH, label_size)];
    self.ID.text = [NSString stringWithFormat: @"ID: %@", self.profile.identifier];
    self.ID.textColor = [self.selectedScheme valueForKey:@"textColor"];
    [self.sv addSubview:self.ID];
    
    self.emailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.emailButton.frame = CGRectMake(50, next_y, SCREEN_WIDTH, label_size);
    [self.emailButton setTitle:@"Email JS" forState:UIControlStateNormal];
    [self.emailButton addTarget:self
                         action:@selector(emailJS:)
               forControlEvents:UIControlEventTouchUpInside];
    //    self.emailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.sv addSubview:self.emailButton];
}
- (void) emailJS: (UIButton*)button{
    NSLog(@"EMAILING JS");
    [self pressentMailController:nil];
}


- (IBAction)pressentMailController:(id)sender {
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    NSString *subject = [NSString stringWithFormat:@"Analytics code for property: %@",[_property identifier]];
    [picker setSubject:subject];
    
    // Fill out the email body text.
    NSString *stri = [NSString stringWithFormat:@"<script>\
                      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){\
                      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\
                      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\
                      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');\
                      ga('create', ' %@ ','auto'); ga('send', 'pageview'); </script>",[_property identifier]];
    
    NSString *emailBody = stri;
    [picker setMessageBody:emailBody isHTML:NO];
    
    // Present the mail composition interface.
    [self presentModalViewController:picker animated:YES];
}

// The mail compose view controller delegate method
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
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
    //height=100;
}

- (void) changedColors:(NSNotification *)notification {
    NSLog(@"changed the color schemes IN APP DELEGATE");
    
    self.selectedScheme = [notification userInfo];
    [self setColors];
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
