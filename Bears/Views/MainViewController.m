//
//  MainViewController.m
//  Bears
//
//  Created by Anthony Picciano on 8/11/14.
//  Copyright (c) 2014 Picciano. All rights reserved.
//

#import "MainViewController.h"
#import "FriendCellTableViewCell.h"

@interface MainViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;
@property (nonatomic, weak) IBOutlet UIButton *logoutButton;
@property (nonatomic, weak) IBOutlet UIButton *inviteButton;

@property (nonatomic, strong) NSArray *friends;

@end

@implementation MainViewController

NSString * const kReuseIdentifier = @"reuseIdentifier";

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
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendCellTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kReuseIdentifier];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"friendsUpdated" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateDisplay];
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (![PFUser currentUser])
    {
        [self logInOrCreateAccount];
    }
}

- (void)loadData
{
    if (![PFUser currentUser])
    {
        return;
    }
    
    // load data
    PFQuery *query = [PFQuery queryWithClassName:@"Friends"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query includeKey:@"friends"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (object)
        {
            self.friends = object[@"friends"];
        }
        else
        {
            self.friends = [NSArray array];
        }
        
        [self.tableView reloadData];
    }];
}

- (void)updateDisplay
{
    if ([PFUser currentUser])
    {
        self.usernameLabel.text = [[[PFUser currentUser] username] uppercaseString];
        self.usernameLabel.hidden = NO;
        self.logoutButton.hidden = NO;
        self.inviteButton.hidden = NO;
    }
    else
    {
        self.usernameLabel.hidden = YES;
        self.logoutButton.hidden = YES;
        self.inviteButton.hidden = YES;
        [self logInOrCreateAccount];
    }
}

- (IBAction)logout:(id)sender
{
    [PFUser logOut];
    [self updateDisplay];
}

- (IBAction)invite:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        // Show the composer
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setSubject:@"BEARS"];
        
        NSString *link = [NSString stringWithFormat:@"bears://?user=%@",[PFUser currentUser].objectId];
        NSString *message = [NSString stringWithFormat:@"<p>Hello there.</p><p>Add me to your <a href=\"%@\">BEARS list</a>.</p><p>Don't have BEARS, get it here.</p>", link];
        
        [controller setMessageBody:message isHTML:YES];
        if (controller) [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"BEARS" message:@"You need to set up email before sending an invitation." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent)
    {
        NSLog(@"It's away!");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendBear:(NSString *)recipient
{
    [PFCloud callFunctionInBackground:@"bears"
                       withParameters:@{ @"recipient" : recipient }
                                block:^(NSString *result, NSError *error) {
                                    if (!error) {
                                        NSLog(@"Result: %@", result);
                                    }
                                }];
}

- (void)logInOrCreateAccount
{
    // log in
    PFLogInViewController *viewController = [[PFLogInViewController alloc] init];
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.image = [UIImage imageNamed:@"logo"];
    [logoView sizeToFit];
    viewController.fields = PFLogInFieldsLogInButton | PFLogInFieldsUsernameAndPassword | PFLogInFieldsSignUpButton;
    viewController.logInView.logo = logoView;
    viewController.logInView.backgroundColor = [UIColor colorWithRed:1.0/256.0 green:29.0/256.0 blue:68.0/256.0 alpha:1.0];
    viewController.logInView.usernameField.backgroundColor = [UIColor whiteColor];
    viewController.logInView.usernameField.textColor = [UIColor blackColor];
    viewController.logInView.passwordField.backgroundColor = [UIColor whiteColor];
    viewController.logInView.passwordField.textColor = [UIColor blackColor];
    
    // sign up
    viewController.signUpController.fields = PFSignUpFieldsUsernameAndPassword | PFSignUpFieldsSignUpButton | PFSignUpFieldsDismissButton;
    viewController.delegate = self;
    viewController.signUpController.delegate = self;
    UIImageView *logoView2 = [[UIImageView alloc] init];
    logoView2.image = [UIImage imageNamed:@"logo"];
    [logoView2 sizeToFit];
    viewController.signUpController.signUpView.logo = logoView2;
    viewController.signUpController.signUpView.backgroundColor = [UIColor colorWithRed:1.0/256.0 green:29.0/256.0 blue:68.0/256.0 alpha:1.0];
    viewController.signUpController.signUpView.usernameField.backgroundColor = [UIColor whiteColor];
    viewController.signUpController.signUpView.usernameField.textColor = [UIColor blackColor];
    viewController.signUpController.signUpView.passwordField.backgroundColor = [UIColor whiteColor];
    viewController.signUpController.signUpView.passwordField.textColor = [UIColor blackColor];
    
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)logInViewController:(PFLogInViewController *)controller
               didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateDisplay];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateDisplay];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateDisplay];
}

- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateDisplay];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.friends)
    {
        return self.friends.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
    
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    [user fetchIfNeeded];
    
    cell.usernameLabel.text = [user.username uppercaseString];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFUser *recipient = [self.friends objectAtIndex:indexPath.row];
    [self sendBear:recipient.objectId];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
