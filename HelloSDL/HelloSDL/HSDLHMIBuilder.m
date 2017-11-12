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
#import "SDLAlert.h"

#import "SDLCreateInteractionChoiceSet.h"
#import "SDLChoice.h"
#import "SDLInteractionMode.h"
#import "SDLPerformInteraction.h"
#import "SDLLayoutMode.h"

#import "HMIFactory.h"
#import "HMIView.h"

#import "SDLMenuParams.h"
#import "SDLAddCommand.h"

@interface HSDLHMIBuilder ()

//@property (strong, nonatomic) HSDLHMIBuilder *HSDLHMIShared;
@property (strong, nonatomic) HMIFactory *hmiFactory;

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

// Need Correlation ID
-(void)buildMainSoftButtons{
    
    SDLShow *show = [[SDLShow alloc]init];
    
    NSMutableArray *buttonList = [[NSMutableArray alloc]init];
    
    SDLSoftButton *button = nil;
    
    button = [[SDLSoftButton alloc]init];
    [button setType: [SDLSoftButtonType TEXT]];
    [button setSoftButtonID:@(BTNID_FIRST)];
    [button setText:@"FIRST"];
    [button setSystemAction:[SDLSystemAction DEFAULT_ACTION]];
    
    [buttonList addObject:button];
    
    button = [[SDLSoftButton alloc]init];
    [button setType: [SDLSoftButtonType TEXT]];
    [button setSoftButtonID:@(BTNID_SECOND)];
    [button setText:@"SECOND"];
    [button setSystemAction:[SDLSystemAction DEFAULT_ACTION]];
    
    [buttonList addObject:button];
    
    button = [[SDLSoftButton alloc]init];
    [button setType: [SDLSoftButtonType TEXT]];
    [button setSoftButtonID:@(BTNID_THIRD)];
    [button setText:@"THIRD"];
    [button setSystemAction:[SDLSystemAction DEFAULT_ACTION]];
    
    [buttonList addObject:button];
    
    SDLImage *image = [[SDLImage alloc]init];
    [image setImageType: [SDLImageType DYNAMIC]];
    [image setValue:@"ford"];
    
    [show setGraphic:image];
    
    [show setSoftButtons:buttonList];
        
    [_proxy sendRPC:show];
    
}

-(void)buildMainView{
    [self setLayout:@"TEXTBUTTONS_WITH_GRAPHIC"];
    
    [self buildMainSoftButtons];
}

-(void)buildTHIRDView{
    [_proxy sendRPC:[HMIFactory buildSDL:LAYOUT dataObj:@"GRAPHIC_WITH_TEXT_AND_SOFTBUTTONS"] ];
    
    //[self setLayout:@"GRAPHIC_WITH_TEXT_AND_SOFTBUTTONS"];
    
    SDLShow *show = [[SDLShow alloc]init];
    
    NSMutableArray *buttonList = [[NSMutableArray alloc]init];
    
        HMIView *hmiView = nil;
    
        hmiView = [[HMIView alloc]init];
        [hmiView setHMIName:@"BACK"];
        [hmiView setHMINameID:@(BTNID_BACK)];
    
        [buttonList addObject:[HMIFactory buildSDL:SOFTBUTTON dataObj:hmiView]];
    
        hmiView = [[HMIView alloc]init];
        [hmiView setHMIName:@"RELAY"];
        [hmiView setHMINameID:@(BTNID_RELAY)];
    
        [buttonList addObject:[HMIFactory buildSDL:SOFTBUTTON dataObj:hmiView]];
    
        SDLImage *image = [[SDLImage alloc]init];
        [image setImageType: [SDLImageType DYNAMIC]];
        [image setValue:@"james"];
        
        [show setGraphic:image];
    
    [show setMainField1:@"FIRST Page"];
    
    [show setSoftButtons:buttonList];
    
    [_proxy sendRPC:show];
}

-(void)buildRelayAlert{
    SDLAlert *alert = [[SDLAlert alloc]init];
    
    [alert setAlertText1:@"It's not a Relay Problem. It's never a relay problem"];
    
    NSMutableArray *buttonList = [[NSMutableArray alloc]init];
    
        SDLSoftButton *button = nil;

        button = [[SDLSoftButton alloc]init];
        [button setType: [SDLSoftButtonType TEXT]];
        [button setSoftButtonID:@(BTNID_OK)];
        [button setText:@"OK"];
        [button setSystemAction:[SDLSystemAction DEFAULT_ACTION]];
    
    [buttonList addObject:button];
    
    [alert setSoftButtons:buttonList];
    
    [_proxy sendRPC:alert];
}

-(void)buildFIRSTView{
    SDLInteractionMode *mode = [SDLInteractionMode MANUAL_ONLY];
    SDLPerformInteraction *performRequest = [[SDLPerformInteraction alloc] init];
    [performRequest setInitialText:@"Apple Devices"];
    [performRequest setInteractionChoiceSetIDList:[NSMutableArray
                                            arrayWithObject:@(100)]];
    [performRequest setInteractionMode:(mode ? mode : [SDLInteractionMode BOTH])];
    [performRequest setInteractionLayout:[SDLLayoutMode LIST_ONLY]];
    [performRequest setTimeout:@(6000)];
    
    [_proxy sendRPC:performRequest];
    
    SDLCreateInteractionChoiceSet *request = [[SDLCreateInteractionChoiceSet alloc] init];
    
    NSMutableArray *choiceList = [[NSMutableArray alloc]init];
    SDLChoice *choice;
    
    choice = [[SDLChoice alloc] init];
    [choice setChoiceID:@(CHOICEID_CHOICE1)];
    [choice setMenuName:@"iPhone 6"];
    [choice setVrCommands:[NSMutableArray arrayWithObjects:@"iPhone 6s", nil]];
    [choiceList addObject:choice];
    
    choice = [[SDLChoice alloc] init];
    [choice setChoiceID:@(CHOICEID_CHOICE2)];
    [choice setMenuName:@"Apple TV"];
    [choice setVrCommands:[NSMutableArray arrayWithObjects:@"Apple TV", nil]];
    [choiceList addObject:choice];
    
    choice = [[SDLChoice alloc] init];
    [choice setChoiceID:@(CHOICEID_CHOICE3)];
    [choice setMenuName:@"Apple Watch"];
    [choice setVrCommands:[NSMutableArray arrayWithObjects:@"Apple Watch", nil]];
    [choiceList addObject:choice];
    
    [request setChoiceSet:choiceList];
    [request setInteractionChoiceSetID:@(100)];
    
    [_proxy sendRPC:request];
}

-(void)buildMainMenu{
    NSMutableArray *menuList = [[NSMutableArray alloc]init];
    
    SDLAddCommand *request = nil;
    SDLMenuParams *menuParam = nil;
    
    menuParam = [[SDLMenuParams alloc]init];
    [menuParam setMenuName:@"FIRST"];
    [menuParam setPosition:@(0)];
    request = [[SDLAddCommand alloc]init];
    [request setMenuParams:menuParam];
    [request setCmdID:@(BTNID_FIRST)];
    [request setVrCommands:[@[@"FIRST"] mutableCopy]];
    
    [menuList addObject:request];
    
    menuParam = [[SDLMenuParams alloc]init];
    [menuParam setMenuName:@"SECOND"];
    [menuParam setPosition:@(1)];
    request = [[SDLAddCommand alloc]init];
    [request setMenuParams:menuParam];
    [request setCmdID:@(BTNID_SECOND)];
    [request setVrCommands:[@[@"SECOND"] mutableCopy]];
    
    [menuList addObject:request];
    
    menuParam = [[SDLMenuParams alloc]init];
    [menuParam setMenuName:@"THIRD"];
    [menuParam setPosition:@(2)];
    request = [[SDLAddCommand alloc]init];
    [request setMenuParams:menuParam];
    [request setCmdID:@(BTNID_THIRD)];
    [request setVrCommands:[@[@"THIRD"] mutableCopy]];
    
    [menuList addObject:request];
    
    for (int i = 0; i < menuList.count; i++){
        SDLAddCommand *command = (SDLAddCommand *)menuList[i];
        
        [_proxy sendRPC:command];
    }
}



-(void)buildAlertCustom:(NSMutableArray *)messages buttons:(NSMutableArray *)buttonList{
    SDLAlert *alert = [[SDLAlert alloc]init];

    [alert setAlertText1: (NSString*) messages[0] ];
    
    if([messages count] > 1){
        [alert setAlertText2: (NSString*) messages[1] ];
    }
    
    if([messages count] > 2){
        [alert setAlertText3: (NSString*) messages[2] ];
    }
    
    [alert setSoftButtons:buttonList];
    
    [_proxy sendRPC:alert];
}

-(NSMutableArray *)buildSoftButtons:(NSMutableArray *)messages buttons:(NSMutableArray *)buttonIDList{
    NSMutableArray *buttonsList = [[NSMutableArray alloc]init];
    
        SDLSoftButton *button = nil;
    
        button = [[SDLSoftButton alloc]init];
        [button setType:[SDLSoftButtonType TEXT]];
        [button setSoftButtonID:[NSNumber numberWithInteger:(FMCHmiButtonID)buttonIDList[0]] ];
        [button setText:(NSString *)messages[0]];
    
        [buttonsList addObject:button];
    
        if([messages count] > 1){
            button = [[SDLSoftButton alloc]init];
            [button setType:[SDLSoftButtonType TEXT]];
            [button setSoftButtonID:[NSNumber numberWithInteger:(FMCHmiButtonID)buttonIDList[1]] ];
            [button setText:(NSString *)messages[1]];
            
            [buttonsList addObject:button];
        }

        if([messages count] > 2){
            button = [[SDLSoftButton alloc]init];
            [button setType:[SDLSoftButtonType TEXT]];
            [button setSoftButtonID:[NSNumber numberWithInteger:(FMCHmiButtonID)buttonIDList[2]] ];
            [button setText:(NSString *)messages[2]];
            
            [buttonsList addObject:button];
        }
    
    return buttonsList;
}

@end
