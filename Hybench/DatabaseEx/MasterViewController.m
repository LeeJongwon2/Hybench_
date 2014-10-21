//
//  MasterViewController.m
//  DatabaseEx
//
//  Created by  on 12. 4. 17..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#include <stdlib.h>
#import "DetailViewController.h"

#import <UIKit/UIKit.h>


// 헤더추가
#import "AppDelegate.h"
#import "PersonData.h"

// 뷰컨트롤러 헤더 선언
#import "DetailViewController.h"
#import "AddDataViewController.h"
#import "UIDevice-Hardware.h"

@implementation MasterViewController
@synthesize detailViewController = _detailViewController;

// 테이블뷰 리로드
- (void)reloadData
{
    [self.tableView reloadData];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *testVC = [[AddDataViewController alloc] init];
    UIViewController *otherVC = [[DetailViewController alloc] init];

    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[testVC, otherVC];
   
    testVC.tabBarItem =
    [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"First", nil)
                                  image:nil
                                    tag:1];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  

    
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];

    
    [[[self.tabBarController.viewControllers objectAtIndex:0] tabBarItem]setTitle:NSLocalizedString(@"Content", @"comment")];
    [[[self.tabBarController.viewControllers objectAtIndex:1] tabBarItem]setTitle:NSLocalizedString(@"Setting", @"comment")];
    
    
    //
    
   
       [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadData)
                                                 name:@"UpdatedDatabase"
                                               object:nil];
}



@end
