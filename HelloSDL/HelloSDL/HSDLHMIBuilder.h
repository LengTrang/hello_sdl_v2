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
    BTNID_BACK,
    BTNID_RYAN,
    BTNID_ERIC,
    BTNID_JAMES,
    BTNID_RELAY,
    BTNID_OK,
    CHOICEID_CHOICE1,
    CHOICEID_CHOICE2,
    CHOICEID_CHOICE3,
    CHOICESETID_1 = 900,
    CHOICESETID_2,
};

@interface HSDLHMIBuilder : NSObject

- (instancetype)initWithProxy:(SDLProxy *)proxy;

-(void)setLayout:(NSString *)layoutName;

-(void)buildMainSoftButtons;

-(void)buildMainView;
-(void)buildJamesView;
-(void)buildRelayAlert;
-(void)buildRyanView;
-(void)buildMainMenu;

@property (nonatomic, strong) SDLProxy *proxy;

@end
