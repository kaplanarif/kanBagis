//
//  ViewController.h
//  kanbagisi
//
//  Created by arif kaplan on 25.11.2013.
//  Copyright (c) 2013 arif kaplan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface ViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>



- (IBAction)loadTable:(id)sender;

@end
