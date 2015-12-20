//
//  UIViewController+DetailViewController.h
//  Forecast
//
//  Created by lu liu on 15/11/17.
//  Copyright © 2015年 lu liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableCell.h"

@interface DetailViewController:UIViewController<UITableViewDelegate,UITableViewDataSource>{
	NSMutableArray *hour;
	IBOutlet UITableView *myTable;
	NSArray *day;
	NSArray *tableData;
	Boolean tag;
	Boolean weatherTag; //true: F, false: C
	NSMutableArray *anotherHour;
}

@property(nonatomic,strong)NSDictionary *result;


@property(nonatomic,retain)IBOutlet UILabel *summaryLB;
@property(nonatomic,retain)IBOutlet UIButton *detailBtn;
@property(nonatomic,retain)IBOutlet UIButton *sevenDayBtn;
@property(nonatomic,retain)IBOutlet UITableView *myTable;
@property(nonatomic,retain)IBOutlet UILabel *headerView;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)clickAdd:(id)sender;

-(IBAction)clickSevenBtn:(id)sender;
-(IBAction)clickDetailBtn:(id)sender;

@end
