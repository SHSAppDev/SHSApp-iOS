//
//  SHSBellScheduleViewController.m
//  SHSApp
//
//  Created by Spencer Yen on 8/6/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SHSBellScheduleViewController.h"

@interface SHSBellScheduleViewController ()

@end

@implementation SHSBellScheduleViewController{
    NSString *dayName;
}
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)changeView: (id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        self.parseClassName = @"Monday";
        [self loadObjects];
        [self.tableView reloadData];
    } else if (selectedSegment == 1) {
        self.parseClassName = @"Thursday";
        [self loadObjects];
        [self.tableView reloadData];
    } else if (selectedSegment == 2) {
        self.parseClassName = @"Wednesday";
        [self loadObjects];
        [self.tableView reloadData];
    } else if(selectedSegment == 3) {
        self.parseClassName = @"Thursday";
        [self loadObjects];
        [self.tableView reloadData];
    } else if (selectedSegment == 4) {
        self.parseClassName = @"Friday";
        [self loadObjects];
        [self.tableView reloadData];
    }

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSArray *itemArray = [NSArray arrayWithObjects: @"M", @"T", @"W", @"TH", @"F", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(85,25,150,30);
    [segmentedControl addTarget:self action:@selector(changeView:)
               forControlEvents:UIControlEventValueChanged];
    
    [[UISegmentedControl appearance] setTintColor:[UIColor whiteColor]];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *numFormatter = [[NSDateFormatter alloc] init];
    [numFormatter setDateFormat:@"c"]; // day number, like 7 for saturday
    NSString *dayOfWeekNum = [numFormatter stringFromDate:today];
    
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat:@"EEEE"];
    dayName = [dayFormatter stringFromDate:today];
    if([dayOfWeekNum isEqualToString:@"7"] || [dayOfWeekNum isEqualToString:@"6"]){
        segmentedControl.selectedSegmentIndex = 0;
        dayName = @"Monday";
    } else {
        segmentedControl.selectedSegmentIndex = [dayOfWeekNum intValue]-2;
    }
    self.parseClassName = dayName;
    
    self.navigationItem.titleView = segmentedControl;
    [self.tableView reloadData];

    [self loadObjects];
    
}

-(NSDate *)getEndTime {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    NSDate *now = [NSDate date];
    [query whereKey:@"endTime" greaterThan:now];
    [query orderByAscending:@"endTime"];
    NSDate *endTime = [[query findObjects] firstObject];
    return endTime;
    //this will return like a day in 2018, just ignore, only parse the actual 24 hour time.
}
- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = dayName;
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        
    }
    return self;
}

- (PFQuery *)queryForTable
{
    if(self.parseClassName){
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    [query orderByAscending:@"endTime"];
    
    return query;
    }
    return nil;
}


- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.objects.count > 0) {
        return self.objects.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 43;
    } else {
        return (self.view.frame.size.height - 64 - 44 - 44)/(self.objects.count-1);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    if(indexPath.row == 0){
        static NSString *simpleTableIdentifier = @"TimeLeftCell";
        
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        
        UILabel *titleLabel = (UILabel*) [cell viewWithTag:101];
        titleLabel.backgroundColor = [UIColor colorWithRed:194/255.0f green:0 blue:0 alpha:0.6];
        titleLabel.text = @"X Minutes Left";
        return cell;
        
    } else {
        
        static NSString *simpleTableIdentifier = @"PeriodCell";
        
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        
        UILabel *periodLabel = (UILabel*) [cell viewWithTag:100];
        periodLabel.text = [object objectForKey:@"period"];
        
        UILabel *timeLabel = (UILabel*) [cell viewWithTag:101];
        timeLabel.text = [object objectForKey:@"time"];
        
        return cell;
    }
}



@end
