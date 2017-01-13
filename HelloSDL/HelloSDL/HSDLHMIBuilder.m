//
//  HSDLHMIBuilder.m
//  HelloSDL
//
//  Created by Leng Trang on 1/12/17.
//  Copyright © 2017 Ford. All rights reserved.
//

#import "HSDLHMIBuilder.h"
#import "SDLProxy.h"

// HMI UI
#import "SDLSetDisplayLayout.h"
#import "SDLShow.h"
#import "SDLSoftButton.h"
#import "SDLSoftButtonType.h"
#import "SDLSystemAction.h"
#import "SDLImage.h"
#import "SDLImageType.h"

@interface HSDLHMIBuilder ()

@property (strong, nonatomic) HSDLHMIBuilder *HSDLHMIShared;

@end

@implementation HSDLHMIBuilder

- (instancetype)initWithProxy:(SDLProxy *)proxy{
    
    if (self = [super init]){
        _proxy = proxy;
    }
    
    return self;
}

-(instancetype)init
{
    return [self initWithProxy:nil];
}

-(void)setLayout:(NSString *)layoutName{
    SDLSetDisplayLayout *layout = [[SDLSetDisplayLayout alloc]init];
    [layout setDisplayLayout:layoutName];
    [_proxy sendRPC:layout];
}

-(void)buildMainSoftButtons:(NSNumber *)correlation{
    
    SDLShow *show = [[SDLShow alloc]init];
    
    NSMutableArray *buttonList = [[NSMutableArray alloc]init];
    
    SDLSoftButton *button = nil;
    
    button = [[SDLSoftButton alloc]init];
    [button setType: [SDLSoftButtonType TEXT]];
    [button setSoftButtonID:@(BTNID_NAME_ONE)];
    [button setText:@"Button One"];
    [button setSystemAction:[SDLSystemAction DEFAULT_ACTION]];
    
    [buttonList addObject:button];
    
    button = [[SDLSoftButton alloc]init];
    [button setType: [SDLSoftButtonType TEXT]];
    [button setSoftButtonID:@(BTNID_NAME_TWO)];
    [button setText:@"Button Two"];
    [button setSystemAction:[SDLSystemAction DEFAULT_ACTION]];
    
    [buttonList addObject:button];
    
    button = [[SDLSoftButton alloc]init];
    [button setType: [SDLSoftButtonType TEXT]];
    [button setSoftButtonID:@(BTNID_NAME_THREE)];
    [button setText:@"Button Three"];
    [button setSystemAction:[SDLSystemAction DEFAULT_ACTION]];
    
    [buttonList addObject:button];
    
    [show setCorrelationID:correlation];
    [show setSoftButtons:buttonList];
    
    [_proxy sendRPC:show];
    
}

-(void)buildMainSoftButtons{
    
    SDLShow *show = [[SDLShow alloc]init];
    
    NSMutableArray *buttonList = [[NSMutableArray alloc]init];
    
    SDLSoftButton *button = nil;
    
    button = [[SDLSoftButton alloc]init];
    [button setType: [SDLSoftButtonType TEXT]];
    [button setSoftButtonID:@(BTNID_NAME_ONE)];
    [button setText:@"Ryan"];
    [button setSystemAction:[SDLSystemAction DEFAULT_ACTION]];
    
    [buttonList addObject:button];
    
    button = [[SDLSoftButton alloc]init];
    [button setType: [SDLSoftButtonType TEXT]];
    [button setSoftButtonID:@(BTNID_NAME_TWO)];
    [button setText:@"Eric Carter"];
    [button setSystemAction:[SDLSystemAction DEFAULT_ACTION]];
    
    [buttonList addObject:button];
    
    button = [[SDLSoftButton alloc]init];
    [button setType: [SDLSoftButtonType TEXT]];
    [button setSoftButtonID:@(BTNID_NAME_THREE)];
    [button setText:@"Oscar"];
    [button setSystemAction:[SDLSystemAction DEFAULT_ACTION]];
    
    [buttonList addObject:button];
    
    [show setSoftButtons:buttonList];
    
//    SDLImage *image = [[SDLImage alloc]init];
//    [image setImageType: [SDLImageType DYNAMIC]];
//    [image setValue:@"ford"];
//    
//    [show setGraphic:image];
    
    [_proxy sendRPC:show];
    
}

@end
