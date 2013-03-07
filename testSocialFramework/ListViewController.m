//
//  ListViewController.m
//  testSocialFramework
//
//  Created by Snaill on 13-3-7.
//  Copyright (c) 2013年 Snail Studio. All rights reserved.
//

#import "ListViewController.h"
#import <Social/Social.h>

@interface ListViewController ()

@property (nonatomic, strong) NSMutableArray * serviceTypes;
@end

@implementation ListViewController
@synthesize serviceTypes;
@synthesize image, url, text;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    serviceTypes = [[NSMutableArray alloc]init];
    
    if ( [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter] )
        [serviceTypes addObject:SLServiceTypeTwitter];
    
    if ( [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook] )
        [serviceTypes addObject:SLServiceTypeFacebook];
    
    if ( [SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo] )
        [serviceTypes addObject:SLServiceTypeSinaWeibo];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [serviceTypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString * serviceType = [serviceTypes objectAtIndex:indexPath.row];
    if ([serviceType isEqualToString:SLServiceTypeTwitter]) {
        cell.imageView.image = [UIImage imageNamed:@"twitter"];
        cell.textLabel.text = @"Twitter";
    } else if ([serviceType isEqualToString:SLServiceTypeFacebook]) {
        cell.imageView.image = [UIImage imageNamed:@"facebook"];
        cell.textLabel.text = @"Facebook";
    } else if ([serviceType isEqualToString:SLServiceTypeSinaWeibo]) {
        cell.imageView.image = [UIImage imageNamed:@"sinaweibo"];
        cell.textLabel.text = @"新浪微博";
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * serviceType = [serviceTypes objectAtIndex:indexPath.row];

    // 创建一个SLComposeViewController
    SLComposeViewController* controller = [SLComposeViewController composeViewControllerForServiceType:serviceType];
    
    // 添加Image
    [controller addImage:image];
    
    // 添加URL
    [controller addURL:url];
    
    // 添加初始的Text
    [controller setInitialText:text];
    
    SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
        if (result == SLComposeViewControllerResultCancelled){
            NSLog(@"cancelled!");
        } else {
            NSLog(@"done!");
        }
        [controller dismissViewControllerAnimated:YES completion:Nil];
    };
    
    controller.completionHandler = myBlock;
    
    [self presentViewController:controller animated:YES completion:Nil];
}

@end
