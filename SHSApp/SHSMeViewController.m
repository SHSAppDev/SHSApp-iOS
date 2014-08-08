//
//  SHSMeViewController.m
//  SHSApp
//
//  Created by Spencer Yen on 8/6/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SHSMeViewController.h"
#import "SVWebViewController.h"
#import "IDMPhoto.h"
#import "IDMPhotoBrowser.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface SHSMeViewController ()

@end

@implementation SHSMeViewController
@synthesize idImageView;

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
    // Do any additional setup after loading the view.
}

- (IBAction) fullscreen: (id)sender {
    NSLog(@"jjjijoijoiji");
    NSMutableArray *photos = [[NSMutableArray alloc]init];
    IDMPhoto *photo = [IDMPhoto photoWithImage:idImageView.image];
    [photos addObject: photo];
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos: photos];
    [self presentViewController: browser animated:YES completion:nil];
}

- (IBAction)useCamera:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        _newMedia = YES;
        NSLog(@"EWFEWFEWF");
    }
    NSLog(@"EW!!!!!FEWFEWF");
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        [idImageView setImage: image];
        
        //        if (_newMedia)
        //            UIImageWriteToSavedPhotosAlbum(image,
        //                                           self,
        //                                           @selector(image:finishedSavingWithError:contextInfo:),
        //                                           nil);
    }
}



-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDismissAtPageIndex:(NSUInteger)pageIndex
{
    id <IDMPhoto> photo = [photoBrowser photoAtIndex:pageIndex];
    NSLog(@"Did dismiss photoBrowser with photo index: %d, photo caption: %@", pageIndex, photo.caption);
}

- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDismissActionSheetWithButtonIndex:(NSUInteger)buttonIndex photoIndex:(NSUInteger)photoIndex
{
    id <IDMPhoto> photo = [photoBrowser photoAtIndex:photoIndex];
    NSLog(@"Did dismiss actionSheet with photo index: %d, photo caption: %@", photoIndex, photo.caption);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
