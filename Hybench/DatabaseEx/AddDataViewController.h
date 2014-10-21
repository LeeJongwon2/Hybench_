//
//  AddDataViewController.h
//  DatabaseEx
//
//  Created by  on 12. 4. 18..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "fcntl.h"
#include "unistd.h"

int iosize_seq;
int filesize;
int mode;
int dbsize;
int datasize;

@interface AddDataViewController : UIViewController
{
    // DB에 저정할 변수
    UIButton *Btn;
    UILabel *textLabel;
    //iosize변경 변수
    //int iosize_seq;
    
}
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, retain) UIViewController *rootViiewController;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UINavigationController *navigationController;
- (int) getiosize_seq;
- (void) setiosize_seq:(int)value;
- (int) getfilesize;
- (void) setfilesize:(int)value2;
- (char *) getmode;
- (void) setmode:(int)value3;
- (int) getdbsize;
- (void) setdbsize:(int)value4;
- (int) getdatasize;
- (void) setdatasize:(int)value5;
@end
