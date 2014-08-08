//
//  SHSMeViewController.h
//  SHSApp
//
//  Created by Spencer Yen on 8/6/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDMPhotoBrowser.h"

@interface SHSMeViewController : UIViewController <IDMPhotoBrowserDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *idImageView;
@property BOOL newMedia;

@end
