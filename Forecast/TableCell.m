//
//  UITableViewCell+TableCell.m
//  Forecast
//
//  Created by lu liu on 15/11/17.
//  Copyright © 2015年 lu liu. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell
@synthesize timeLB;
@synthesize tempLB;
@synthesize tempImageView;

@synthesize timeName;
@synthesize tempName;
@synthesize imageName;
@synthesize indexPath;


-(void)setTimeName:(NSString *)time{
	if (![time isEqualToString:self.timeName]) {
		timeName=[time copy];
		self.timeLB.text=timeName;
	}
}

-(void)setTempName:(NSString *)temp{
	if (![temp isEqualToString:self.tempName]) {
		tempName=[temp copy];
		self.tempLB.text=tempName;
	}
}

-(void)setImageName:(NSString *)image{
	if (![image isEqualToString:self.imageName]) {
		imageName=[image copy];
		self.tempImageView.image=[UIImage imageNamed:imageName];
	}
}






@end
