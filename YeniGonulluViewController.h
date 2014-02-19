//
//  YeniGonulluViewController.h
//  kanbagisi
//
//  Created by arif kaplan on 6.12.2013.
//  Copyright (c) 2013 arif kaplan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface YeniGonulluViewController : UIViewController<UIPickerViewDelegate>
{
    IBOutlet UIPickerView *myPicker;
    NSArray *dataArray;
    NSString *kan_grubu;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *cinsiyet;
@property (weak, nonatomic) IBOutlet UISegmentedControl *alkol;
@property (weak, nonatomic) IBOutlet UITextField *son_bagis;
@property (weak, nonatomic) IBOutlet UITextField *sehir;



- (IBAction)kayit_yeni_gonullu:(id)sender;
- (IBAction)backgroundTap:(id)sender;

@end
