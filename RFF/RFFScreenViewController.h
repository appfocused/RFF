//
//  RFFScreenViewController.h
//  RFF
//
//  Created by Vitaly Kondratiev on 02/10/2012.
//  Copyright (c) 2012 AppFocused. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFFScreenViewController : UIViewController

@property (strong, nonatomic) IBOutlet UINavigationBar *topBar;

- (void) switchLanguage;

- (void) setLocalizationValues:(id)sender;

@end
