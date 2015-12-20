//
//  ResultViewController.m
//  Forecast
//
//  Created by lu liu on 15/11/16.
//  Copyright © 2015年 lu liu. All rights reserved.
//


#import "ResultViewController.h"


@interface ResultViewController ()

@end

@implementation ResultViewController

@synthesize precipitationLB;
@synthesize chanceLB;
@synthesize windLB;
@synthesize dewLB;
@synthesize humidityLB;
@synthesize visibilityLB;
@synthesize sunriseLB;
@synthesize sunsetLB;
@synthesize cityLB;
@synthesize tempLB;
@synthesize lowLB;
@synthesize highLB;
@synthesize degreeLB;
@synthesize imageView;
@synthesize detailsBtn;
@synthesize mapBtn;
@synthesize scrollView;
@synthesize fbBtn;
@synthesize result;
@synthesize backBtn;


static NSString *path=@"";


- (void)viewDidLoad {
	/*
		
	NSDictionary *allResult=[[NSDictionary alloc]initWithObjectsAndKeys:result,@"result",city.text,@"city",pickState.currentTitle,@"state",weatherTag,@"degree", nil];*/
	[super viewDidLoad];
	[fbBtn setBackgroundImage:[UIImage imageNamed:@"image/fb_icon.png"] forState:UIControlStateNormal];
		[self initScrollView];
	if (result!=nil) {
		NSDictionary* tmp=[result objectForKey:@("result")];
		current=[tmp objectForKey:@("current_result")];
		precipitationLB.text=[current objectForKey:@("precipIntensity")];
		chanceLB.text=[current objectForKey:@("precipProbability")];
		NSString *imageName=[path stringByAppendingString:[current objectForKey:@("icon_img")]];
		[imageView setImage:[UIImage imageNamed:imageName]];
		NSString *sum=[[current objectForKey:@("summary")] stringByAppendingString:@(" in ")];
		sum=[sum stringByAppendingString:[result objectForKey:@("city")]];
		sum=[[sum stringByAppendingString:@(", ")]stringByAppendingString:[result objectForKey:@("state")]];
		cityLB.text=sum;
		tempLB.text=[[current objectForKey:@("temperature")]stringByAppendingString:@"°"];
		lowLB.text=[[@("L:") stringByAppendingString:[current objectForKey:@("temperatureMin")]]stringByAppendingString:@"°"];
		highLB.text=[[@("H:") stringByAppendingString:[current objectForKey:@("temperatureMax")]]stringByAppendingString:@"°"];
		windLB.text=[current objectForKey:@("windSpeed")];
		dewLB.text=[current objectForKey:@("dewPoint")];
		humidityLB.text=[current objectForKey:@("humidity")];
		visibilityLB.text=[current objectForKey:@("visibility")];
		sunriseLB.text=[current objectForKey:@("risetime")];
		sunsetLB.text=[current objectForKey:@("settime")];
		NSString *degreeStr=[result objectForKey:@("degree")];
		if([degreeStr isEqualToString:@("us")]){
			degreeLB.text=@("F");
		}else{
			degreeLB.text=@("C");
		}
		
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)initScrollView{
	 [self.scrollView setContentSize:CGSizeMake(332, 640)];
	scrollView.maximumZoomScale = 2.0;//允许放大2倍
	scrollView.minimumZoomScale = 0.5;//允许放大到0.5倍
	scrollView.delegate=self;
	scrollView.showsVerticalScrollIndicator = YES;
	scrollView.scrollsToTop = YES;
	scrollView.bounces=FALSE;
}

-(IBAction)clickDetail:(id)sender{
	
}

-(IBAction)clickMap:(id)sender{
	
}


- (UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView{
	return self.view;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	//将page2设定成Storyboard Segue的目标UIViewController
	if ([segue.identifier isEqualToString:@"MapSegue"]) {
		id details = segue.destinationViewController;
		[details setValue:result forKey:@"result"];
	}else{
		id details = segue.destinationViewController;
		[details setValue:result forKey:@"result"];

	}
	
	
}

- (IBAction)clickBack:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)clickShare:(id)sender{
	NSString *title=[[[@"Current Weather in " stringByAppendingString:[result objectForKey:@("city")]] stringByAppendingString:@", "]stringByAppendingString:[result objectForKey:@("state")]];
	NSString *sum=[[[current objectForKey:@("summary")] stringByAppendingString:@", "]stringByAppendingString:[current objectForKey:@("temperature")]];
	NSString *index=[@"http://cs-server.usc.edu:42766/hw9/" stringByAppendingString:[current objectForKey:@("icon_img")]];
	NSDictionary *properties = [NSMutableDictionary dictionaryWithDictionary:@{
							 @"og:type": @"books.book",
							 @"og:url":@"http://forecast.io",
							 @"og:image":index,
							 @"og:title": title,
							 @"og:site_name":@"via WeatherApp",
							 @"og:description": sum,
							 @"books:isbn": @"0-553-57340-3",
							 }];


	FBSDKShareOpenGraphObject *object = [FBSDKShareOpenGraphObject objectWithProperties:properties];

	FBSDKShareOpenGraphAction *action = [[FBSDKShareOpenGraphAction alloc] init];
	action.actionType = @"books.reads";
	[action setObject:object forKey:@"books:book"];
	FBSDKShareOpenGraphContent *content = [[FBSDKShareOpenGraphContent alloc] init];
	content.action = action;
	content.previewPropertyName = @"books:book";
	FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
	
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fbauth2://"]]){
		dialog.mode = FBSDKShareDialogModeNative;
	}
	else {
		dialog.mode = FBSDKShareDialogModeBrowser; //or FBSDKShareDialogModeAutomatic
	}
	dialog.shareContent = content;
	dialog.delegate = self;
	dialog.fromViewController = self;
	[dialog show];

}

- (void) sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results {
	NSLog(@"share complete");
	NSString *message = @"Facebook Post Successful";
	
	UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
													message:message
												   delegate:nil
										  cancelButtonTitle:nil
										  otherButtonTitles:nil, nil];
	[toast show];
	
	int duration = 1; // duration in seconds
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		[toast dismissWithClickedButtonIndex:0 animated:YES];
	});
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
	NSLog(@"share error:%@",error);
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer{
	NSLog(@"share cancel");
	NSString *message = @"Post Cancelled";
	
	UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
													message:message
												   delegate:nil
										  cancelButtonTitle:nil
										  otherButtonTitles:nil, nil];
	[toast show];
	
	int duration = 1; // duration in seconds
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		[toast dismissWithClickedButtonIndex:0 animated:YES];
	});
}

@end
