//
//  SHSStaffDetailViewController.h
//  SHSApp
//
//  Created by Spencer Yen on 8/8/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHSStaffDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *staffInfo;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
- (IBAction)emailAction:(id)sender;
- (IBAction)callAction:(id)sender;
- (IBAction)websiteAction:(id)sender;

@end
