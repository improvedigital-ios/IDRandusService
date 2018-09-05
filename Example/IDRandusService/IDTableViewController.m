//
//  IDTableViewController.m
//  IDRandusService
//
//  Created by Andrey Bronnikov on 09/05/2018.
//  Copyright (c) 2018 Improve Digital. All rights reserved.
//

#import "IDTableViewController.h"
#import <IDRandusService/IDRandusService.h>

@interface IDTableViewController ()

@property (nonatomic) BOOL gotResponseData;

- (IBAction)didTapRequestButton:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *personImageView;

@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *patronymicLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdateLabel;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *streetLabel;
@property (weak, nonatomic) IBOutlet UILabel *postcodeLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;

@end

@implementation IDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.personImageView.layer.masksToBounds = YES;
    self.personImageView.layer.cornerRadius = CGRectGetHeight(self.personImageView.frame) / 2;
    self.personImageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.personImageView.layer.borderWidth = 1.f;
}


- (IBAction)didTapRequestButton:(UIButton *)sender {
    
    __weak IDTableViewController *weakSelf = self;
    [IDRandusService getRandomPersonWithCompletionBlock:^(IDRandusPersonObject *person) {
        
        weakSelf.personImageView.image = [UIImage imageWithData:person.faceImageData];
        
        weakSelf.lastNameLabel.text = person.lastName;
        weakSelf.firstNameLabel.text = person.firstName;
        weakSelf.patronymicLabel.text = person.patronymic;
        weakSelf.genderLabel.text = person.formattedGender;
        weakSelf.birthdateLabel.text = person.formattedBirthdate;
        weakSelf.cityLabel.text = person.city;
        weakSelf.streetLabel.text = [NSString stringWithFormat:@"%@, %@, %@",
                                     person.street,
                                     person.house,
                                     person.apartment];
        weakSelf.postcodeLabel.text = person.postcode;
        weakSelf.phoneLabel.text = person.phone;
        weakSelf.loginLabel.text = person.login;
        weakSelf.passwordLabel.text = person.password;
        
        weakSelf.gotResponseData = YES;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        
    } errorBlock:^(NSError *error) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ошибка"
                                                                       message:error.localizedDescription
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.gotResponseData ? UITableViewAutomaticDimension : CGFLOAT_MIN;
}

@end
