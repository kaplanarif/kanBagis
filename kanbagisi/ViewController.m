//
//  ViewController.m
//  kanbagisi
//
//  Created by arif kaplan on 25.11.2013.
//  Copyright (c) 2013 arif kaplan. All rights reserved.
//

#import "ViewController.h"
#import "MyLogInViewController.h"
#import "MySignUpViewController.h"
#import "MyTableController.h"




@interface ViewController ()



@end


@implementation ViewController


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    if (![PFUser currentUser]) {
       
        MyLogInViewController *logInViewController = [[MyLogInViewController alloc] init];
        [logInViewController setDelegate:self];
        
        [logInViewController setFields:PFLogInFieldsUsernameAndPassword
         | PFLogInFieldsSignUpButton
         | PFLogInFieldsDismissButton];
        
        MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
        [signUpViewController setDelegate:self];
        [signUpViewController setFields:PFSignUpFieldsDefault | PFSignUpFieldsAdditional | PFSignUpFieldsDismissButton];
        
        [logInViewController setSignUpController:signUpViewController];
       
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }else{
    
        //kullanıcı gönüllü listesine üye olduğunda currentUser içine şehir bilgisi ekleniyor.
        PFQuery *query = [PFQuery queryWithClassName:@"GonulluListesi"];
        [query whereKey:@"userID" equalTo:[PFUser currentUser].objectId];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!object) {
                NSLog(@"Önce gönüllü listesine üye olmanız gerekiyor.");
            } else {
                [PFUser currentUser][@"sehir"] = object[@"sehir"];
            }
        }];
    }
    
    
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    UINavigationBar *naviBarObj = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [self.view addSubview:naviBarObj];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Çıkış"         style:UIBarButtonItemStyleBordered target:self action:@selector(exitButton)];
    
    
    UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:@"Mobil Kan"];
    
    navigItem.rightBarButtonItem = cancelItem;
    
        naviBarObj.items = [NSArray arrayWithObjects: navigItem,nil];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MainBG.png"]]];
    
  
}

- (void) alertStatus:(NSString *)msg :(NSString *)title{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Tamam"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}
- (IBAction)loadTable:(id)sender {
    
    MyTableController *controller = [[MyTableController alloc] init];
    [self presentModalViewController:controller animated:YES];
    
}
- (void)exitButton{
    [PFUser logOut];
    [self viewDidAppear:YES];
    
}

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Eksik Bilgi"
                                message:@"Gerekli alanları doldurduğunuza emin olunuz!"
                               delegate:nil
                      cancelButtonTitle:@"Tamam"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}
// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Kesik Bilgi"
                                    message:@"Gerekli alanları doldurduğunuza emin olunuz."
                                   delegate:nil
                          cancelButtonTitle:@"Tamam"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}
// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    //[self dismissModalViewControllerAnimated:YES]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}





@end