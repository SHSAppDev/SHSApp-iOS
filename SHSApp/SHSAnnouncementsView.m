//
//  SHSAnnouncementsView.m
//  SHSApp
//
//  Created by Spencer Yen on 8/7/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SHSAnnouncementsView.h"

@implementation SHSAnnouncementsView

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
    self.tableView.separatorInset = UIEdgeInsetsZero;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadObjects];
    
}
-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"Announcements";
        self.textKey = @"createdAt";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        
        
    }
    return self;
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    [query orderByDescending:@"createdAt"];
    
    return query;
}


- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    
    [self.tableView reloadData];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get a reference to your string to base the cell size on.
    NSString *bodyString;
    
    bodyString = [[self.objects objectAtIndex:indexPath.row]objectForKey:@"body"];
    
    //set the desired size of your textbox
    CGSize constraint = CGSizeMake(298, MAXFLOAT);
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13.0] forKey:NSFontAttributeName];
    CGRect textsize = [bodyString boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    //calculate your size
    float textHeight = textsize.size.height + 10;
    
    return textHeight + 57;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    
    static NSString *simpleTableIdentifier = @"AnnouncementCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel *titleLabel = (UILabel*) [cell viewWithTag:101];
    titleLabel.text = [object objectForKey:@"title"];
    
    
    UILabel *senderLabel = (UILabel*) [cell viewWithTag:102];
    senderLabel.text = [[object objectForKey:@"sender"] uppercaseString];
    
    //Set bodytext, adjust size of label
    UILabel *bodyText = (UILabel*) [cell viewWithTag:104];
    
    NSString *bodyString =[object objectForKey:@"body"];
    
    CGSize constraint = CGSizeMake(298, MAXFLOAT);
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13.0] forKey:NSFontAttributeName];
    CGRect newFrame = [bodyString boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    bodyText.frame = CGRectMake(10,59,newFrame.size.width, newFrame.size.height);
    bodyText.text = bodyString;
    [bodyText sizeToFit];
    
    //Set date label
    UILabel *timeLabel = (UILabel*) [cell viewWithTag:103];
    NSDate *time = object.createdAt;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"M/dd hh:mm a"];
    timeLabel.text = [dateFormatter stringFromDate:time];
    
    
    return cell;
}


@end
