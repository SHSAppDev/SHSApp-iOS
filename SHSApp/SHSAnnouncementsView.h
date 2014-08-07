//
//  SHSAnnouncementsView.h
//  SHSApp
//
//  Created by Spencer Yen on 8/7/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SHSAnnouncementsView : PFQueryTableViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end