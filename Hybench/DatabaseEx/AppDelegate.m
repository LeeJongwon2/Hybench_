//
//  AppDelegate.m
//  DatabaseEx
//
//  Created by  on 12. 4. 17..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

// 외부 접근이 가능하도록 처리
@synthesize persons;

#pragma mark - Data Base

// 데이터베이스 파일 검사
-(void) checkAndCreateDatabase{
    // 파일매니져 생성
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	// 데이터베이스 파일 유무 확인 후
    // 파일이 존재하지 않는 경우에만 처리
    if (![fileManager fileExistsAtPath:dbPath])
    {
        // 어플리케이션에 포함된 DB파일 경로
        NSString *dbPathFromApp = [[[NSBundle mainBundle] resourcePath] 
                                   stringByAppendingPathComponent:dbName];
        // db 경로로 복사
        [fileManager copyItemAtPath:dbPathFromApp toPath:dbPath error:nil];
    }
}

// 데이터베이스 파일에서 데이터 획득 및 저장
-(void) readFilesFromDatabase {

	sqlite3 *database;
    
    // 처음 호출된 경우 
    if (persons == nil) 
    {
        // NSMutalbleArray 생성
        persons = [[NSMutableArray alloc] init];
    }
    // 생성되어 있는 경우
    else 
    {
        // 데이터를 초기화
        [persons removeAllObjects];
    }
    
    // DB File Open
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) 
    {
        // Query
		const char *sqlStatement = "select * from persons";
		sqlite3_stmt *compiledStatement;
	
        // Qeury 실행
        if(sqlite3_prepare_v2(database, sqlStatement, -1, 
                              &compiledStatement, NULL) == SQLITE_OK)
        {
            // 결과 행이 존재하는 동안 처리
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
            {
                // 이름 획득
				NSString *name = 
                [NSString stringWithUTF8String:
                 (char*)sqlite3_column_text(compiledStatement, 1)];
                
                // 전화번호 획득
                NSString *telno = 
                [NSString stringWithUTF8String:
                 (char*)sqlite3_column_text(compiledStatement, 2)];
                
                // 이메일 주소 획득
                NSString *email = 
                [NSString stringWithUTF8String:
                 (char*)sqlite3_column_text(compiledStatement, 3)];
                
                // PersonData 생성
                PersonData *person = 
                [[PersonData alloc] initWithName:name 
                                     phoneNumber:telno 
                                        mailAddr:email];
                // PersonData 저장
				[persons addObject:person];
			}
		}
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
}

// 데이터 삽입
- (void)insertDataWithName:(NSString*)n 
               phoneNumber:(NSString*)p
              emailAddress:(NSString*)e
{
    sqlite3 *database;
    
    // DB File Open
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) 
    {
        // Qeury 생성 및 실행
        NSString *query =[NSString 
                          stringWithFormat:@"insert into persons"
                          "(name, telno, email)"
                          "values ('%@', '%@', '%@')",
                          n, p, e];
    
        char* error = NULL;
        sqlite3_exec(database, [query UTF8String],NULL, 0, &error);
        
        
        // 에러발생시 로그 출력
        if (error) NSLog(@"Error Msg: %s", error);
    }
    sqlite3_close(database);
    [self readFilesFromDatabase];
}

// 데이터 변경
- (void)updateWithName:(NSString*)n 
           phoneNumber:(NSString*)p
          emailAddress:(NSString*)e 
               oldName:(NSString*)on
{
    sqlite3 *database;
    
    
    
    
    // DB File Open
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) 
    {
        // Qeury 생성 및 실행
        NSString *query =[NSString 
                          stringWithFormat:@"update persons set "
                          "name = '%@', telno = '%@', email = '%@'"
                          "where name = '%@'",
                          n, p, e, on];
        char* error = NULL;
        sqlite3_exec(database, [query UTF8String],NULL, 0, &error);
        // 에러발생시 로그 출력
        if (error) NSLog(@"Error Msg: %s", error);
    }
    sqlite3_close(database);
    [self readFilesFromDatabase];
}

// 데이터 삭제
- (void)deleteDataWithName:(NSString*)n
               phoneNumber:(NSString*)p
              emailAddress:(NSString*)e
                   oldName:(NSString*)on

{
    sqlite3 *database;
    
    // DB File Open
    if(sqlite3_open([dbPath UTF8String], &database)==SQLITE_OK)
    {   
        // Qeury 생성 및 실행
        NSString *query = [NSString 
                           stringWithFormat:
                           @"delete from persons where"];
        char* error = NULL;
        sqlite3_exec(database, [query UTF8String],NULL, 0, &error);
        // 에러발생시 로그 출력
        if (error) NSLog(@"Error Msg: %s", error);
    }
    
    [self readFilesFromDatabase];
    sqlite3_close(database);
}
// 저널모드변경
char** query3;
- (void)journalChange:(NSString*)a
{
    sqlite3 *database;
    // DB File Open
    if(sqlite3_open([dbPath UTF8String], &database)==SQLITE_OK)
    {
        // Qeury 생성 및 실행
        NSString *query = [NSString stringWithFormat: @"PRAGMA journal_mode = '%@'; ",a];
        char* error = NULL;
        sqlite3_exec(database, [query UTF8String],NULL, 0, &error);

        // 에러발생시 로그 출력
        if (error) NSLog(@"Error Msg: %s", error);
    }
    //[self readFilesFromDatabase];
    
    sqlite3_close(database);
}
/*
- (char *)journalGet{
    if(query3==NULL)
        return "delete";
    else
        return query3[1];
}*/

- (char *)journalGet{
    sqlite3 *database;
    char** query2=NULL;
    if(sqlite3_open([dbPath UTF8String], &database)==SQLITE_OK)
    {
        NSString *query =[NSString stringWithFormat: @"pragma journal_mode;"];
        char* error = NULL;
        int* row=NULL;
        int* col=NULL;
        sqlite3_get_table(database,[query UTF8String],&query2,row,col,&error);
    
    
    // 에러발생시 로그 출력
    if (error) NSLog(@"Error Msg: %s", error);
    }
    
    sqlite3_close(database);
    return query2[1];


}




#pragma mark - App Delegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   // UITabBarController *tabBarController;
   //UIViewController *configVC = [[ConfigViewController alloc] init];
    // 데이터베이스 파일 이름
   
    dbName = @"namecard.sql";
    
    // 데이터베이스 파일 경로 설정
    NSArray *documentPaths = 
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                        NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    dbPath = [documentsDir stringByAppendingPathComponent:dbName];
    
    // 데이터베이스 파일 유무 검사
    [self checkAndCreateDatabase];
    
    // 데이터 획득 및 저장
    [self readFilesFromDatabase];
       
    self.window = [[UIWindow alloc] 
                   initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    MasterViewController *masterViewController = 
    [[MasterViewController alloc] 
     initWithNibName:@"MasterViewController" bundle:nil];
    
    self.navigationController = 
    [[UINavigationController alloc] 
     initWithRootViewController:masterViewController];
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
