//
//  SHSNewsViewController.m
//  SHSApp
//
//  Created by Spencer Yen on 8/7/14.
//  Copyright (c) 2014 Spencer Yen. All rights reserved.
//

#import "SHSNewsViewController.h"

@interface SHSNewsViewController ()

@end

@implementation SHSNewsViewController

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



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section
{
    // This is the number of chat messages.
    return 19;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    //Get a reference to your string to base the cell size on.
    //    NSString *bodyString;
    //
    //    bodyString = [self.chat objectAtIndex:indexPath.row][@"message"];
    //
    //    //set the desired size of your textbox
    //    CGSize constraint = CGSizeMake(252, MAXFLOAT);
    //
    //    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14.0] forKey:NSFontAttributeName];
    //    CGRect textsize = [bodyString boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    //    //calculate your size
    //    float textHeight = textsize.size.height + 5;
    //
    //   return textHeight + 25;
    return 50;
}

- (UITableViewCell*)tableView:(UITableView*)table cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"ChatCell";
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:CellIdentifier];
    //
    //    if(indexPath.row % 2 == 0)
    //        cell.backgroundColor = [UIColor colorWithRed:189.0/255.0 green:195.0/255.0 blue:199.0/255.0 alpha:0.02];
    //    else
    //        cell.backgroundColor = [UIColor colorWithRed:189.0/255.0 green:195.0/255.0 blue:199.0/255.0 alpha:0.08];
    //
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
    //
    //    NSDictionary* chatMessage = [self.chat objectAtIndex:indexPath.row];
    //
    //    UIImageView *imageView = (UIImageView*) [cell viewWithTag:100];
    //    imageView.clipsToBounds = YES;
    //    imageView.contentMode = UIViewContentModeScaleAspectFill;
    //    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    //
    //
    //
    //    [imageView setImageWithURL:[NSURL URLWithString:chatMessage[@"image"]] placeholderImage:[UIImage imageNamed:@"placeholderIcon.png"]];
    //
    //
    //    UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
    //    nameLabel.text = chatMessage[@"user"];
    //
    //
    //    UILabel *messageLabel = (UILabel*) [cell viewWithTag:102];
    //
    //    NSString *message = chatMessage[@"message"];
    //
    //    CGSize constraint = CGSizeMake(252, MAXFLOAT);
    //    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14.0] forKey:NSFontAttributeName];
    //    CGRect newFrame = [message boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    //    messageLabel.frame = CGRectMake(57,22,newFrame.size.width, newFrame.size.height);
    //    messageLabel.text = message;
    //    [messageLabel sizeToFit];
    
    return cell;
}





@end
