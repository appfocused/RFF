//
//  RFFViewController.m
//  RFF
//
//  Created by Vitaly Kondratiev on 02/10/2012.
//  Copyright (c) 2012 AppFocused. All rights reserved.
//

#import "RFFViewController.h"
#import "TSLanguageManager.h"

@interface RFFViewController ()

@end

@implementation RFFViewController

- (void)setLocalizationValues:(id)sender {

    NSLog(@"--> %@", [sender title]);
    
    if ([sender title]) {
        [super switchLanguage];
    }
    
    self.topBar.topItem.title = [TSLanguageManager localizedString:@"HOME"];
    self.title = [TSLanguageManager localizedString:@"HOME"];
    
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
