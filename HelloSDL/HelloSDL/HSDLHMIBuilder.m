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
    [button setSoftButtonID:@(BTNID_RYAN)];
    [button setText:@"Ryan"];
    [button setSystemAction:[SDLSystemAction DEFAULT_ACTION]];
    
    [buttonList addObject:button];
    
    button = [[SDLSoftButton alloc]init];
    [button setType: [SDLSoftButtonType TEXT]];
    [button setSoftButtonID:@(BTNID_ERIC)];
    [button setText:@"Eric Carter"];
    [button setSystemAction:[SDLSystemAction DEFAULT_ACTION]];
    
    [buttonList addObject:button];
    
    button = [[SDLSoftButton alloc]init];
    [button setType: [SDLSoftButtonType TEXT]];
    [button setSoftButtonID:@(BTNID_JAMES)];
    [button setText:@"James"];
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

-(void)buildJamesView{
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
    
    [show setMainField1:@"James Page"];
    
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

-(void)buildRyanView{
    SDLInteractionMode *mode = [SDLInteractionMode MANUAL_ONLY];
    SDLPerformInteraction *performRequest = [[SDLPerformInteraction alloc] init];
    [performRequest setInitialText:@"Ryan Apple Devices"];
    [performRequest setInteractionChoiceSetIDList:[NSMutableArray
                                            arrayWithObjects:@(CHOICESETID_1),nil]];
    [performRequest setInteractionMode:(mode ? mode : [SDLInteractionMode BOTH])];
    [performRequest setInteractionLayout:[SDLLayoutMode LIST_ONLY]];
    [performRequest setTimeout:@(1000)];
    
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
    [request setInteractionChoiceSetID:@(CHOICESETID_1)];
    
    [_proxy sendRPC:request];
}

-(void)buildMainMenu{
    
//    SDLMenuParams *menuParams = [[SDLMenuParams alloc] init];
//    menuParams.menuName = TestCommandName;
//    SDLAddCommand *command = [[SDLAddCommand alloc] init];
//    command.vrCommands = [NSMutableArray arrayWithObject:TestCommandName];
//    command.menuParams = menuParams;
//    command.cmdID = @(BTNID_TEST_CMDID);
//    [self.proxy sendRPC:command];
    
    NSMutableArray *menuList = [[NSMutableArray alloc]init];
    
    SDLAddCommand *request = nil;
    SDLMenuParams *menuParam = nil;
    
    menuParam = [[SDLMenuParams alloc]init];
    [menuParam setMenuName:@"Ryan"];
    [menuParam setPosition:@(0)];
    request = [[SDLAddCommand alloc]init];
    [request setMenuParams:menuParam];
    [request setCmdID:@(BTNID_RYAN)];
    [request setVrCommands:[@[@"Ryan"] mutableCopy]];
    
    [menuList addObject:request];
    
    menuParam = [[SDLMenuParams alloc]init];
    [menuParam setMenuName:@"Eric"];
    [menuParam setPosition:@(1)];
    request = [[SDLAddCommand alloc]init];
    [request setMenuParams:menuParam];
    [request setCmdID:@(BTNID_ERIC)];
    [request setVrCommands:[@[@"Eric"] mutableCopy]];
    
    [menuList addObject:request];
    
    menuParam = [[SDLMenuParams alloc]init];
    [menuParam setMenuName:@"James"];
    [menuParam setPosition:@(2)];
    request = [[SDLAddCommand alloc]init];
    [request setMenuParams:menuParam];
    [request setCmdID:@(BTNID_JAMES)];
    [request setVrCommands:[@[@"James"] mutableCopy]];
    
    [menuList addObject:request];
    
    for (int i = 0; i < menuList.count; i++){
        SDLAddCommand *command = (SDLAddCommand *)menuList[i];
        
        [_proxy sendRPC:command];
    }
}

@end
