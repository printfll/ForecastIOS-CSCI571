//
//  UIViewController+DetailViewController.m
//  Forecast
//
//  Created by lu liu on 15/11/17.
//  Copyright © 2015年 lu liu. All rights reserved.
//

#import "DetailViewController.h"
#import "DayTableCell.h"

@implementation DetailViewController
@synthesize result;
@synthesize myTable;
@synthesize detailBtn;
@synthesize summaryLB;
@synthesize sevenDayBtn;
@synthesize headerView;
@synthesize addBtn;
- (void)viewDidLoad {
	[super viewDidLoad];
	/*
	 "tag"=>"".$i,
	 "time"=>$time,
	 "summary"=>$summary,
	 "icon"=>$icon,
	 "cloudCover"=>$cloudCover,
	 "temperature"=>$temperature,
	 "windspeed"=>$windSpeed_display,
	 "humidity"=>$humidity,
	 "visibility"=>$visibility_display,
	 "pressure"=>$pressure
	 */
	
	/*
	 [[NSDictionary alloc]initWithObjectsAndKeys:result,@"result",city.text,@"city",pickState.currentTitle,@"state", nil];
	 */
	NSDictionary *tmp=[result objectForKey:@("result")];
	anotherHour=[tmp objectForKey:@("hour_result")];
	hour=[NSMutableArray array];
	
	
	for (int i=0; i<24; i++) {
		
		[hour addObject:[anotherHour objectAtIndex:i]];
	}
	
	
	NSLog(@("now hour:%d,anotherHour:%d"),[hour count],[anotherHour count]);
	day=[tmp objectForKey:@"day_result"];
	
	
	[myTable setAllowsSelection:YES];
	[self.view bringSubviewToFront:myTable];
	NSString *sum=[[[@"More Details for " stringByAppendingString:[result objectForKey:@"city"]] stringByAppendingString:@", "]  stringByAppendingString:[result objectForKey:@"state"]];
	summaryLB.text=sum;
	tableData=hour;
	tag=true;//true: load hour, false: load day
	[detailBtn setBackgroundColor:[UIColor colorWithRed:76/255.0 green:123/255.0 blue:194/255.0 alpha:1]];
	[detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	if ([[tmp objectForKey:@"degree"] isEqualToString:@"si"]) {
		weatherTag=false;
	}else{
		weatherTag=true;
	}
	
	//[addBtn setAccessibilityFrame:CGRectMake(0, 500, 360, 30)];
	[addBtn setBackgroundColor:[UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1]];
	[addBtn setFrame:CGRectMake(0, 0, 360, 80)];
	[myTable reloadData];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)returnToFirstPage:(id)sender {
	[self dismissViewControllerAnimated:YES completion:^{}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (tag==true) {
		static NSString *CustomCellIdentifier = @"CustomerCellIdentifier";
		
		static BOOL nibsRegistered = NO;
		if (!nibsRegistered) {
			UINib *nib = [UINib nibWithNibName:@"Cell" bundle:nil];
			[tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
			nibsRegistered = YES;
		}
		
		TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
		NSUInteger row = [indexPath row];

		NSDictionary *rowData = [tableData objectAtIndex:row];
		
			cell.tempName = [rowData objectForKey:@"temperature"];
			cell.imageName = [rowData objectForKey:@"summary"];
			cell.timeName = [rowData objectForKey:@"time"];
		
		
		cell.imageView.tag=row;
		cell.indexPath=indexPath;
		
		
		UIView *myView = [[UIView alloc] init];
		if (row % 2) {
			myView.backgroundColor = [UIColor whiteColor];
		} else {
			myView.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
		}
		cell.backgroundView = myView;
		return cell;


	}else{
		static NSString *CustomCellIdentifier = @"DayCellIdentify";
		
		static BOOL nibsRegistered = NO;
		if (!nibsRegistered) {
			UINib *nib = [UINib nibWithNibName:@"DayCell" bundle:nil];
			[tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
			nibsRegistered = YES;
		}
		
		DayTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
		NSUInteger row = [indexPath row];
		NSDictionary *rowData = [tableData objectAtIndex:row];
		cell.dayLB.text = [[rowData objectForKey:@"day"]stringByAppendingString:@", "];
		cell.monthLB.text = [rowData objectForKey:@"month"];
		cell.minTempLB.text = [@"Min: " stringByAppendingString:[rowData objectForKey:@"minTemp"]] ;
		cell.maxTempLB.text=[@"Max: " stringByAppendingString:[ rowData objectForKey:@"maxTemp"]];
		cell.iconImageView.image=[UIImage imageNamed:[rowData objectForKey:@"icon_img"]];
		
		UIView *myView = [[UIView alloc] init];
			switch (row) {
				case 0:
					myView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:219.0/255.0 blue:106.0/255.0 alpha:1];
					break;
				case 1:
					myView.backgroundColor=[UIColor colorWithRed:160.0/255.0 green:231.0/255.0 blue:255.0/255.0 alpha:1];
					break;
				case 2:
					myView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:196.0/255.0 blue:234.0/255.0 alpha:1];
					break;
				case 3:
					myView.backgroundColor=[UIColor colorWithRed:196.0/255.0 green:255.0/255.0 blue:165.0/255.0 alpha:1];
					break;
				case 4:
					myView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:189.0/255.0 blue:183.0/255.0 alpha:1];
					break;
				case 5:
					myView.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:255.0/255.0 blue:181.0/255.0 alpha:1];
					break;
				case 6:
					myView.backgroundColor=[UIColor colorWithRed:188.0/255.0 green:190.0/255.0 blue:255.0/255.0 alpha:1];
					break;
					
				default:
					break;
		}
		cell.backgroundView=myView;
		return cell;
		
	}
}

#pragma mark Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tag==true) {
		return 80.0;
	}else{
		return 95.0;
	}
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

#pragma mark Table Delegate Methods


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if (tag==true) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 32)];
		/* Create custom view to display section header... */
		UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(31, 2,38, 21)];
		label1.text=@"Time";
		UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(160, 2, 73, 21)];
		label2.text=@"Summary";
		UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(275, 2, 83, 21)];
		NSString *de=(weatherTag==true)?@"F":@"C";
		label3.text=[[@"Temp(°" stringByAppendingString:de]stringByAppendingString:@")"] ;
		[view addSubview:label1];
		[view addSubview:label2];
		[view addSubview:label3];
		[view setBackgroundColor:[UIColor colorWithRed:63/255.0 green:254/255.0 blue:210/255.0 alpha:1.0]]; //your background color...
		return view;

	}else{
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0)];
		return view;
	}
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
	return NO;
}



- (IBAction)clickAdd:(id)sender {
	NSLog(@"clickadd");
	[self.addBtn removeFromSuperview];
	for(int i=24;i<[anotherHour count];i++){
		[hour addObject:[anotherHour objectAtIndex:i]];
	}
	[myTable reloadData];
	
}

-(IBAction)clickSevenBtn:(id)sender{
	tag=false;
	tableData=day;
	myTable.tableHeaderView = nil;
	[myTable reloadData];
	[detailBtn setBackgroundColor:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1]];
	[sevenDayBtn setBackgroundColor:[UIColor colorWithRed:76/255.0 green:123/255.0 blue:194/255.0 alpha:1]];
	[sevenDayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.addBtn setHidden:YES];
}

-(IBAction)clickDetailBtn:(id)sender{
	tag=true;
	tableData=hour;
	[myTable reloadData];
	[sevenDayBtn setBackgroundColor:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1]];
	[detailBtn setBackgroundColor:[UIColor colorWithRed:76/255.0 green:123/255.0 blue:194/255.0 alpha:1]];
	[detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.addBtn setHidden:NO];
}


@end
