//
//  ViewController.m
//  testSocialFramework
//
//  Created by Snaill on 13-3-7.
//  Copyright (c) 2013年 Snail Studio. All rights reserved.
//

#import "ViewController.h"
#import "ListViewController.h"

@interface ViewController ()<UIActivityItemSource>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showList"]) {
        ListViewController * vc = segue.destinationViewController;
        vc.image = [UIImage imageNamed:@"test.jpg"];
        vc.url = [NSURL URLWithString:@"http://jeebook.com"];
        vc.text = @"this is test for Social Framework";
    }
}

- (IBAction)onShare:(id)sender {
    UIImage * image = [UIImage imageNamed:@"test.jpg"];
    NSString * text = @"this is test for Social Framework";
    NSURL * url = [NSURL URLWithString:@"http://jeebook.com"];
    UIActivityViewController * vc = [[UIActivityViewController alloc]initWithActivityItems:@[text, url, image] applicationActivities:nil];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
