//
//  IDRandusPersonObject.h
//  Improve Digital
//
//  Created by Андрей Бронников on 05.09.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, IDRandusGender) {
    IDRandusGenderUnknown = 0,
    IDRandusGenderMan,
    IDRandusGenderWoman
};

@interface IDRandusPersonObject : NSObject

@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *patronymic;

@property (nonatomic) IDRandusGender gender;
@property (nonatomic) NSString *formattedGender;

@property (nonatomic) NSDate *birthdate;
@property (nonatomic) NSString *formattedBirthdate;

@property (nonatomic) NSData *faceImageData;
@property (nonatomic) NSString *color;

@property (nonatomic) NSString *city;
@property (nonatomic) NSString *street;
@property (nonatomic) NSString *postcode;
@property (nonatomic) NSString *house;
@property (nonatomic) NSString *apartment;

@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *login;
@property (nonatomic) NSString *password;

@end
