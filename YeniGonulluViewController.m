//
//  YeniGonulluViewController.m
//  kanbagisi
//
//  Created by arif kaplan on 6.12.2013.
//  Copyright (c) 2013 arif kaplan. All rights reserved.
//

#import "YeniGonulluViewController.h"

@interface YeniGonulluViewController ()

@end

@implementation YeniGonulluViewController
@synthesize cinsiyet,alkol,son_bagis,sehir;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    
    
    //yeniden bagışcı listesine üye olacak kişi için güncelleme ekranı açılıyor.
    PFQuery *query = [PFQuery queryWithClassName:@"GonulluListesi"];
    
    [query whereKey:@"userID" equalTo:[PFUser currentUser].objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // hiç sonuç dönmezse birşey yapılmıyor
            // ancak daha önceden kayıtlı bir varsa ana sayfaya yönlendiriliyor.
            //@todo eger yetişirse bu sayfa update sayfasına yönlendirme yapabilr.
            if (objects.count != 0) {
                [self alertStatus:@"Kan Bağışcı Formuna bir kere kayıt olabilirsiniz.":@"Uyarı"];
                [self performSegueWithIdentifier:@"goMainToVolunteer" sender:self];
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
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


- (IBAction)kayit_yeni_gonullu:(id)sender {

    NSString *msg;
    NSString *title=@"Uyarı!";
    
    if ([son_bagis.text length] == 0) {
        msg = @"Lütfen son bağış tarihini giriniz..";
        [self alertStatus:msg:title];
    }else if( [sehir.text length] == 0 ){
        msg = @"Lütfen yaşadığınız şehiri giriniz..";
        [self alertStatus:msg:title];
    }else{
        NSString *tmp;
        NSString *alk;
        if ([cinsiyet selectedSegmentIndex]) {
            
            tmp = @"KADIN";
        }else{
            tmp = @"ERKEK";
        }
        
        if ([alkol selectedSegmentIndex]) {
            alk = @"VAR";
        }else{
            alk = @"YOK";
        }
        
        PFObject *kayit = [PFObject objectWithClassName:@"GonulluListesi"];
        kayit[@"userID"]= [PFUser currentUser].objectId ;
        kayit[@"sonBagis"] = son_bagis.text;
        kayit[@"sehir"] = sehir.text;
        kayit[@"cinsiyet"] = tmp;
        kayit[@"alkol"] = alk;
        kayit[@"kanGrubu"]= kan_grubu;
        
        [kayit saveEventually];
        //eger kayıt başarılı olursa bu metot ile yönlendirme yapıyoruz.
        [self performSegueWithIdentifier:@"goMainToVolunteer" sender:self];
    }
}


- (IBAction)backgroundTap:(id)sender{
    [son_bagis resignFirstResponder];

}

- (void) alertStatus:(NSString *)msg :(NSString *)title{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Tamam"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}

// kan grubu seçimi için kullanılması gereken metotlar.
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
