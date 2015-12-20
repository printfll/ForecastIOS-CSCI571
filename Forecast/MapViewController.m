//
//  UIViewController+MapViewController.m
//  Forecast
//
//  Created by lu liu on 15/11/22.
//  Copyright © 2015年 lu liu. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController
@synthesize backBtn;


- (void)viewDidLoad {
	/*
		
	 NSDictionary *allResult=[[NSDictionary alloc]initWithObjectsAndKeys:result,@"result",city.text,@"city",pickState.currentTitle,@"state",weatherTag,@"degree", nil];
	 "status"=>"OK",
	 "lat"=>"".$lat,
	 "lng"=>"".$lng,
	 "link"=>$link,
	 "degree"=>$units,
	 "current_result"=>$current_result,
	 "hour_result"=>$hourly_result,
	 "day_result"=>$days_result*/
	[super viewDidLoad];
	NSDictionary *tmp=[result objectForKey:@"result"];
	current=[tmp objectForKey:@"current_result"];
	
	NSString *latS=[tmp objectForKey:@"lat" ];
	lat=[latS doubleValue];
	NSString *lngS=[tmp objectForKey:@"lng"];
	lng=[lngS doubleValue];
	
	[self loadMap];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)returnToFirstPage:(id)sender {
	[self dismissViewControllerAnimated:YES completion:^{}];
}


-(void)loadMap{
//	AWFWeatherMap *weatherMap = [[AWFWeatherMap alloc] initWithMapType:AWFWeatherMapTypeApple];weatherMap.weatherMapView.frame = self.view.bounds;
//	
//
//	CLLocationCoordinate2D location=CLLocationCoordinate2DMake(lat, lng);
//	
//	[weatherMap setMapCenterCoordinate:location zoomLevel:15 animated:true];
//	//[weatherMap addLayerType:AWFLayerTypeRadarSatellite];
//	[weatherMap insertLayerType:AWFLayerTypeRadar atIndex:4];
//	weatherMap.delegate = self;
//	[self.view addSubview:weatherMap.weatherMapView];
//	NSLog((@"is true: %d"), [weatherMap containsLayerType:AWFLayerTypeRadar]);
//	[weatherMap refreshLayerType:AWFLayerTypeRadar];
//	//[weatherMap addLayerType:AWFLayerTypeRadarSatellite];
	
	weatherMapController = [[AWFWeatherMapViewController alloc] initWithNibName:nil bundle:nil];
	weatherMapController.weatherMapType = AWFWeatherMapTypeApple;
	weatherMapController.config.animationEnabled = YES;
	weatherMapController.config.refreshInterval = 15 * AWFMinuteInterval;
	
	CLLocationCoordinate2D location=CLLocationCoordinate2DMake(lat, lng);
	weatherMapController.weatherMap.delegate = self;
	weatherMapController.view.frame=self.view.bounds;
	[weatherMapController.weatherMap setMapCenterCoordinate:location zoomLevel:5 animated:true];
	[weatherMapController.weatherMap addLayerType:AWFLayerTypeRadarSatellite];
	[self.view addSubview:weatherMapController.view];
	
}

- (void)weatherMap:(AWFWeatherMap *)weatherMap didAddLayerType:(AWFLayerType)layerType {
	[weatherMapController.legendView addLegendForLayerType:layerType];
}

- (void)weatherMap:(AWFWeatherMap *)weatherMap didRemoveLayerType:(AWFLayerType)layerType {
	[weatherMapController.legendView removeLegendForLayerType:layerType];
}


@end
