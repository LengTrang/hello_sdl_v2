//
//  HSDLHMIBuilder.h
//  HelloSDL
//
//  Created by Leng Trang on 1/12/17.
//  Copyright © 2017 Ford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDLProxy.h"

typedef NS_ENUM(NSUInteger, FMCHmiButtonID) {
    BTNID_TEST_CMDID,
    BTNID_NAME_ONE,
    BTNID_NAME_TWO,
    BTNID_NAME_THREE,
};

@interface HSDLHMIBuilder : NSObject

- (instancetype)initWithProxy:(SDLProxy *)proxy;

-(void)setLayout:(NSString *)layoutName;
-(void)buildMainSoftButtons:(NSNumber *)correlation;
-(void)buildMainSoftButtons;

@property (nonatomic, strong) SDLProxy *proxy;

@end
