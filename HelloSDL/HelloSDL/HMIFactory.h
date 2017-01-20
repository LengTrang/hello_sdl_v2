//
//  HMIFactory.h
//  HelloSDL
//
//  Created by Leng Trang on 1/17/17.
//  Copyright © 2017 Ford. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SDLInterfaceObject) {
    LAYOUT,
    SOFTBUTTON,
    CHOICE
};

@interface HMIFactory : NSObject

+(id)buildSDL:(SDLInterfaceObject)SDL dataObj:(id)obj;

@end
