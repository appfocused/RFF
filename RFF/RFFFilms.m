//
//  RFFFilms.m
//  RFF
//
//  Created by Vitaly Kondratiev on 02/10/2012.
//  Copyright (c) 2012 AppFocused. All rights reserved.
//

#import "RFFFilms.h"
#import "TSLanguageManager.h"

@interface RFFFilms ()

@end

@implementation RFFFilms

- (void)setLocalizationValues:(id)sender {
    
    NSLog(@"--> %@", [sender title]);
    
    if ([sender title]) {
        [super switchLanguage];
    }
    
    self.topBar.topItem.title = [TSLanguageManager localizedString:@"FILMS"];
    self.title = [TSLanguageManager localizedString:@"FILMS"];
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
