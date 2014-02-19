//
//  KanIstekViewController.h
//  kanbagisi
//
//  Created by arif kaplan on 6.12.2013.
//  Copyright (c) 2013 arif kaplan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface KanIstekViewController : UIViewController<UIPickerViewDelegate>
{
    IBOutlet UIPickerView *myPicker;
    NSArray *dataArray;
    NSString *kan_grubu;
}

@property (weak, nonatomic) IBOutlet UITextField *hasta_adi;
@property (weak, nonatomic) IBOutlet UITextField *hasta_soyadi;
@property (weak, nonatomic) IBOutlet UITextField *hastane_adi;
@property (weak, nonatomic) IBOutlet UITextField *sehir;

- (IBAction)ilanVer:(id)sender;
- (IBAction)bacgroungTab:(id)sender;

@end
