//
//  MasterViewController.h
//  DatabaseEx
//
//  Created by  on 12. 4. 17..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController{
    UIButton *Btn;
    UILabel *textLabel;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property(nonatomic, retain) UIViewController *rootViiewController;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) UINavigationController *navigationController;
@end
