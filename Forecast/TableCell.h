//
//  UITableViewCell+TableCell.h
//  Forecast
//
//  Created by lu liu on 15/11/17.
//  Copyright © 2015年 lu liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell:UITableViewCell

@property(retain,nonatomic)IBOutlet UILabel *timeLB;
@property(retain,nonatomic)IBOutlet UILabel *tempLB;
@property (nonatomic, strong)IBOutlet UIImageView *tempImageView;

@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *timeName;
@property(nonatomic,copy)NSString *tempName;
@property (nonatomic, retain) NSIndexPath *indexPath;

@end
