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
@synthesize tableView, timerLabel;

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
    tableView.tableHeaderView = timerLabel;
    segment = 0;
    [self getEndTime];
    
}

-(void) updateCounter:(NSTimer *)theTimer {
    
}
-(void) displayTimer {
    
    
}

-(NSDate *) getEndTime {
    if (segment == 0) {
        self.parseClassName = @"Monday";
    } else if (segment == 1) {
        self.parseClassName = @"Thursday";
    } else if (segment == 2) {
        self.parseClassName = @"Wednesday";
    } else if(segment == 3) {
        self.parseClassName = @"Thursday";
    } else if (segment == 4) {
        self.parseClassName = @"Friday";
    }
        
        PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
        
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"hhmm"];
        [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"PST"]];
        NSString *newTime = [timeFormatter stringFromDate:[NSDate date]];
        NSNumber *nowInteger= [NSNumber numberWithInt:[newTime intValue]];
        [query whereKey:@"endTime" greaterThan:nowInteger];
        [query orderByAscending:@"endTime"];
        NSNumber *endTime = [[[query findObjects] firstObject] objectForKey:@"endTime"];
        NSString *dateString;
        if([endTime intValue] < 999) {
            dateString = [NSString stringWithFormat:@"0%@", endTime];
        } else {
            dateString = [NSString stringWithFormat:@"%@", endTime];
        }
    
    NSDateFormatter *timFormatter = [[NSDateFormatter alloc] init];
    [timFormatter setDateFormat:@"hhmm"];
        NSDate *dateFromString = [timFormatter dateFromString:dateString];
    NSLog(@"%@", endTime);
    NSLog(@"%@", newTime);
        NSLog(@"%@", dateFromString);
     NSLog(@"%@", dateString);
    
        return dateFromString;
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
    
    segment = selectedSegment;

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



@end
