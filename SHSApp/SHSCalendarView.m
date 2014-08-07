//
//  SHSCalendarView.m
//  SHSApp
//
//  Created by Spencer Yen on 8/7/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SHSCalendarView.h"

@implementation SHSCalendarView

-(void)viewDidLoad {
    
    NSString *urlAddress = @"http://www.saratogahigh.org/apps/events/calendar/?id=0&id=1&id=2&id=3";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    _webView.scalesPageToFit = YES;

    [_webView loadRequest:requestObj];
}

@end
