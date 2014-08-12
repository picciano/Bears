//
//  MainViewController.h
//  Bears
//
//  Created by Anthony Picciano on 8/11/14.
//  Copyright (c) 2014 Picciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MainViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, MFMailComposeViewControllerDelegate>

@end
