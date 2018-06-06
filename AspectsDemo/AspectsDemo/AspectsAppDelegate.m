//
//  AspectsAppDelegate.m
//  AspectsDemo
//
//  Created by Peter Steinberger on 03/05/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "AspectsAppDelegate.h"
#import "AspectsViewController.h"
#import "Aspects.h"

@implementation AspectsAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AspectsViewController *aspectsController = [AspectsViewController new];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:aspectsController];
    [self.window makeKeyAndVisible];

    // Ignore hooks when we are testing.
    __block NSUInteger i = 0;
    if (!NSClassFromString(@"XCTestCase")) {
        [aspectsController aspect_hookSelector:@selector(buttonPressed:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info, id sender) {
            BOOL enable = (++i % 2) == 0;

            NSLog(@"Button was pressed by: %@, enable:%d", sender, enable);
            [info.originalInvocation invoke];
        } error:NULL];

        [aspectsController aspect_hookSelector:@selector(viewWillLayoutSubviews) withOptions:0 usingBlock:^{
            NSLog(@"Controller is layouting!");
        } error:NULL];
    }

    return YES;
}

@end
