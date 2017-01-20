//
//  HMIFactory.m
//  HelloSDL
//
//  Created by Leng Trang on 1/17/17.
//  Copyright © 2017 Ford. All rights reserved.
//

#import "HMIFactory.h"
#import "HMIView.h"

// Layout imports
#import "SDLSetDisplayLayout.h"
#import "SDLSoftButtonType.h"

// SoftButtons
#import "SDLSoftButton.h"
#import "SDLSystemAction.h"

@implementation HMIFactory

+(id)buildSDL:(SDLInterfaceObject)SDL dataObj:(id)obj{
    
//    if (SDL == LAYOUT && [obj isKindOfClass:[NSString class]]) {
//        SDLSetDisplayLayout *layout = [[SDLSetDisplayLayout alloc]init];
//        [layout setDisplayLayout:(NSString *)obj];
//        return layout;
//    }
    
//    if (SDL == SOFTBUTTON ){
//        obj = (HMIView *)obj;
//        
//        SDLSoftButton *button = [[SDLSoftButton alloc]init];
//        [button setType:[SDLSoftButtonType TEXT]];
//        [button setText: [obj HMIName]];
//        [button setSoftButtonID:[obj HMINameID]];
//        [button setSystemAction:[SDLSystemAction DEFAULT_ACTION]];
//        
//        return button;
//    }
    
    switch (SDL){
        case LAYOUT:
            if([obj isKindOfClass:[NSString class]]){
                SDLSetDisplayLayout *layout = [[SDLSetDisplayLayout alloc]init];
                [layout setDisplayLayout:(NSString *)obj];
                return layout;
            }
        case SOFTBUTTON:
            if([obj isKindOfClass:[HMIView class]]){
                obj = (HMIView *)obj;
                
                SDLSoftButton *button = [[SDLSoftButton alloc]init];
                [button setType:[SDLSoftButtonType TEXT]];
                [button setText: [obj HMIName]];
                [button setSoftButtonID:[obj HMINameID]];
                [button setSystemAction:[SDLSystemAction DEFAULT_ACTION]];
                
                return button;
            }
        default:
            break;
    }

    return nil;
    
}

@end
