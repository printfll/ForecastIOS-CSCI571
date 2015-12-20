//
//  Network.h
//  Forecast
//
//  Created by lu liu on 15/11/13.
//  Copyright © 2015年 lu liu. All rights reserved.
//

#ifndef Network_h
#define Network_h


#endif /* Network_h */

@interface Network:NSObject
-(void)getLocation:(NSDictionary *)para completion:(void(^)(NSDictionary *))callback;

@end