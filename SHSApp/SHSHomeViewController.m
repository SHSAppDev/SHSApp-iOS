//
//  SHSHomeViewController.m
//  SHSApp
//
//  Created by Spencer Yen on 8/6/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SHSHomeViewController.h"

@implementation SHSHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *itemArray = [NSArray arrayWithObjects: @"Announcements", @"Calendar",  nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(85,25,150,30);
    segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    [segmentedControl addTarget:self action:@selector(changeView:)
               forControlEvents:UIControlEventValueChanged];
    
    segmentedControl.selectedSegmentIndex = 0;
    [[UISegmentedControl appearance] setTintColor:[UIColor whiteColor]];
     
     
     
    self.navigationItem.titleView = segmentedControl;

    
    _calendarContainer.hidden = YES;
    _announcementsContainer.hidden = NO;
    [self.view bringSubviewToFront:_announcementsContainer];
    
    
}

-(void)changeView: (id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        //Show announcements
        _calendarContainer.hidden = YES;
        _announcementsContainer.hidden = NO;
        [self.view bringSubviewToFront:_announcementsContainer];
        
    }
    if (selectedSegment == 1) {
        //Show calendar
        _calendarContainer.hidden = NO;
        _announcementsContainer.hidden = YES;
        [self.view bringSubviewToFront:_calendarContainer];
        
    }
}




@end
