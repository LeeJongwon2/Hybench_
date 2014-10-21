//
//  AppDelegate.h
//  DatabaseEx
//
//  Created by  on 12. 4. 17..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

// 헤더추가
#import <sqlite3.h>
#import "PersonData.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    // DB Name
    NSString        *dbName;
    // DB File Path
    NSString        *dbPath;
    // Pesons data array
    NSMutableArray  *persons;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;

// 속성 추가
@property (nonatomic, retain) NSMutableArray *persons;

// 데이터 삽입
- (void)insertDataWithName:(NSString*)n 
               phoneNumber:(NSString*)p 
              emailAddress:(NSString*)e;

// 데이터 변경
- (void)updateWithName:(NSString*)n 
           phoneNumber:(NSString*)p 
          emailAddress:(NSString*)e 
               oldName:(NSString*)on;
// 데이터 삭제
- (void)deleteDataWithName:(NSString*)n
               phoneNumber:(NSString*)p
              emailAddress:(NSString*)e
                   oldName:(NSString*)on;;
//저널모드변경
- (void)journalChange:(NSString*)a;
- (char *)journalGet;

@end
