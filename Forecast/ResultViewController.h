//
//  ResultViewController.h
//  Forecast
//
//  Created by lu liu on 15/11/16.
//  Copyright © 2015年 lu liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <Social/Social.h>


@interface ResultViewController:UIViewController<UIScrollViewDelegate,FBSDKSharingDelegate>{
	NSDictionary*current;
}
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property(nonatomic,retain)IBOutlet UILabel *precipitationLB;
@property(nonatomic,retain)IBOutlet UILabel *chanceLB;
@property(nonatomic,retain)IBOutlet UILabel *windLB;
@property(nonatomic,retain)IBOutlet UILabel *dewLB;
@property(nonatomic,retain)IBOutlet UILabel *humidityLB;
@property(nonatomic,retain)IBOutlet UILabel *visibilityLB;
@property(nonatomic,retain)IBOutlet UILabel *sunriseLB;
@property(nonatomic,retain)IBOutlet UILabel *sunsetLB;
@property(nonatomic,retain)IBOutlet UILabel *cityLB;
@property(nonatomic,retain)IBOutlet UILabel *tempLB;
@property(nonatomic,retain)IBOutlet UILabel *lowLB;
@property(nonatomic,retain)IBOutlet UILabel *highLB;
@property(nonatomic,retain)IBOutlet UILabel *degreeLB;

@property(nonatomic,retain)IBOutlet UIImageView *imageView;
@property(nonatomic,retain)IBOutlet UIButton *detailsBtn;
@property(nonatomic,retain)IBOutlet UIButton *mapBtn;
@property(nonatomic,retain)IBOutlet UIButton *fbBtn;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSDictionary *result;

- (IBAction)clickBack:(id)sender;
-(IBAction)clickShare:(id)sender;




@end
