//
//  RFFScreenViewController.m
//  RFF
//
//  Created by Vitaly Kondratiev on 02/10/2012.
//  Copyright (c) 2012 AppFocused. All rights reserved.
//

#import "RFFScreenViewController.h"
#import "TSLanguageManager.h"
#import "RFFAppDelegate.h"

@interface RFFScreenViewController ()

@end

@implementation RFFScreenViewController

@synthesize topBar = _topBar;

-(void)setLocalizationValues:(id)sender {
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    self.topBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 44)];
    UIBarButtonItem *languageButton = [[UIBarButtonItem alloc] initWithTitle:[[TSLanguageManager selectedLanguage] uppercaseString]
                                                                    style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(setLocalizationValues:)];

    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Title"];
    item.rightBarButtonItem = languageButton;

    [self.topBar pushNavigationItem:item animated:NO];
    [self.view addSubview:self.topBar];
    
    [self setLocalizationValues:nil];
}

// switch language on by one
- (void) switchLanguage {
    
    // languages available in the app
    NSMutableArray *availableLanguages = [[NSMutableArray alloc] initWithObjects:@"en", @"ru", nil];
    
    NSString *currentLanguage = [TSLanguageManager selectedLanguage];
    
    NSInteger nextLanguageIndex = 0;
    
    for (int i = 0; i < [availableLanguages count]; i++) {
        
        if (currentLanguage == [availableLanguages objectAtIndex:i]) {
            nextLanguageIndex = i + 1;
            
            if (nextLanguageIndex >= [availableLanguages count]) {
                nextLanguageIndex = 0;
            }
        }
    }
    
    [TSLanguageManager setSelectedLanguage:[availableLanguages objectAtIndex:nextLanguageIndex]];
    
    self.topBar.topItem.rightBarButtonItem.title = [[TSLanguageManager selectedLanguage] uppercaseString];

    RFFAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate translateTabBar];
    

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
