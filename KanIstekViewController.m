//
//  KanIstekViewController.m
//  kanbagisi
//
//  Created by arif kaplan on 6.12.2013.
//  Copyright (c) 2013 arif kaplan. All rights reserved.
//

#import "KanIstekViewController.h"

@interface KanIstekViewController ()
@end

@implementation KanIstekViewController
@synthesize hasta_adi,hasta_soyadi,hastane_adi,sehir;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MainBG.png"]]];

    dataArray = [[NSArray alloc] initWithObjects:@"AB RH+",@"A RH+",@"B RH+",@"0 RH+",
                 @"AB RH-",@"A RH-",@"B RH-",@"0 RH-",nil];
    kan_grubu = @"AB RH+";
	myPicker.delegate = self;
}

- (IBAction)ilanVer:(id)sender {
    int kontrol = 1;
    NSString *msg;
    NSString *title = @"Uyarı" ;
    
    if ([hasta_adi.text length] == 0 ) {
        msg = @"Lütfen Hasta Adını giriniz..";
        [self alertStatus:msg:title];
        kontrol = 0;
    }else{
        if ([hasta_soyadi.text length] == 0 ) {
            msg = @"Lütfen Hasta Soyadını giriniz..";
            [self alertStatus:msg:title];
            kontrol = 0;
        }else{
            if ([hastane_adi.text length] == 0 ) {
                msg = @"Lütfen Hastane adını giriniz..";
                [self alertStatus:msg:title];
                kontrol = 0;
            }else{
                if ([sehir.text length] == 0 ) {
                    msg = @"Lütfen Hastanenin bulunduğu şehiri giriniz.";
                    [self alertStatus:msg:title];
                    kontrol = 0;
                }
            }
        }
    }
    // bütün alanları doldurdugunu kontrol ediyoruz.
    if ( kontrol ) {
        
        PFObject *kayit = [PFObject objectWithClassName:@"IhtiyacListesi"];
        kayit[@"userID"]= [PFUser currentUser].objectId ;
        kayit[@"hastaneAdi"] = hastane_adi.text;
        kayit[@"hastaAdi"] = hasta_adi.text;
        kayit[@"hastaSehir"] = sehir.text;
        kayit[@"hastaSoyadi"] = hasta_soyadi.text;
        kayit[@"kanGrubu"] = kan_grubu;
        kayit[@"telefon"] = [PFUser currentUser][@"additional"];

        [kayit saveInBackground];
        [self performSegueWithIdentifier:@"goMainToSearchBlood" sender:self];
    }
    else{
        NSLog(@"kayıt olmadı.");
    }
}

- (void) alertStatus:(NSString *)msg :(NSString *)title{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Tamam"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}
- (IBAction)bacgroungTab:(id)sender {
    [hastane_adi resignFirstResponder];
    [hasta_adi resignFirstResponder];
    [hasta_soyadi resignFirstResponder];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [dataArray count];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)componen{
    kan_grubu = [dataArray objectAtIndex:row];
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return  [dataArray objectAtIndex:row];
}

@end
