//
//  DetailViewController.h
//  DatabaseEx
//
//  Created by  on 12. 4. 17..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DetailViewController : UIViewController
{
    // 데이터 포인터
    NSString *name;
    NSString *telno;
    NSString *email;
    
    // 데이터 출력 컨트롤
    UILabel *labelName;
    UIButton *labelTelNo;
    UIButton *labelEmail;
    
   
    
}
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
// 데이터 설정 함수
- (void)setName:(NSString*)n phoneNumber:(NSString*)t mailAddress:(NSString*)m;

@end
