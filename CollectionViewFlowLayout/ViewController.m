//
//  ViewController.m
//  CollectionViewFlowLayout
//
//  Created by wxl on 2022/1/25.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"普通";
}
- (IBAction)clickAction:(id)sender {
    FirstViewController *vc = [[FirstViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickTwoAction:(id)sender {
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickThreeAction:(id)sender {
    
}




@end
