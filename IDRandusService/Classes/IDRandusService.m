//
//  IDRandusService.m
//  objc.shoploan
//
//  Created by Андрей Бронников on 05.09.2018.
//  Copyright © 2018 sovcombank. All rights reserved.
//

#import "IDRandusService.h"

@implementation IDRandusService

+ (void)getRandomPersonWithCompletionBlock: (void (^)(IDRandusPersonObject *person))completionBlock
                                errorBlock: (void (^)(NSError *error))errorBlock {
    
    
    NSString *urlString = @"https://randus.org/api.php";
    NSURL *url = [NSURL URLWithString: urlString];
    
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *dataTask = [urlSession
                                      dataTaskWithURL:url
                                      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                          
                                          NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                          
                                          if (errorBlock != nil) {
                                              
                                              if (error != nil) {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      errorBlock(error);
                                                  });
                                                  return;
                                              }
                                              
                                              if (![jsonDict.allKeys containsObject:@"lname"]) {
                                                  NSError *notActualDataError = [NSError errorWithDomain:@"IDRandusServiceDomain"
                                                                                                    code:900
                                                                                                userInfo:@{NSLocalizedDescriptionKey : @"Incorrect JSON data"}];
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      errorBlock(notActualDataError);
                                                  });
                                                  return;
                                              }
                                          }
                                          
                                          if (completionBlock != nil) {
                                              
                                              IDRandusPersonObject *person = [self personWithJSON: jsonDict];
                                              
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  completionBlock(person);
                                              });
                                          }
                                      }];
    [dataTask resume];
}

+ (IDRandusPersonObject *)personWithJSON: (NSDictionary *)jsonDictionary {
    
    IDRandusPersonObject *person = [IDRandusPersonObject new];
    person.firstName = jsonDictionary[@"fname"];
    person.lastName = jsonDictionary[@"lname"];
    person.patronymic = jsonDictionary[@"patronymic"];
    
    NSString *rawGender = jsonDictionary[@"gender"];
    
    person.formattedGender = [self formattedGenderWithText:rawGender];
    person.gender = [self genderWithText:rawGender];
    
    NSString *rawDate = jsonDictionary[@"date"];
    person.formattedBirthdate = rawDate;
    person.birthdate = [self dateWithText:rawDate];
    
    NSURL *imageURL = [NSURL URLWithString: jsonDictionary[@"userpic"]];
    person.faceImageData = [[NSData alloc] initWithContentsOfURL: imageURL];
    person.color = jsonDictionary[@"color"];
    
    person.city = jsonDictionary[@"city"];
    person.street = jsonDictionary[@"street"];
    person.postcode = jsonDictionary[@"postcode"];
    person.house = jsonDictionary[@"house"];
    person.apartment = jsonDictionary[@"apartment"];

    person.phone = jsonDictionary[@"phone"];
    person.login = jsonDictionary[@"login"];
    person.password = jsonDictionary[@"password"];

    return person;
}

+ (IDRandusGender)genderWithText: (NSString *)text {
    
    if ([text isEqualToString:@"w"]) {
        return IDRandusGenderWoman;
    }
    else if ([text isEqualToString:@"m"]) {
        return IDRandusGenderMan;
    }
    else {
        return IDRandusGenderUnknown;
    }
}

+ (NSString *)formattedGenderWithText: (NSString *)text {
    
    if ([text isEqualToString:@"w"]) {
        return @"Женский";
    }
    else if ([text isEqualToString:@"m"]) {
        return @"Мужской";
    }
    else {
        return @"Не определен";
    }
}

+ (NSDate *)dateWithText: (NSString *)text {
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd MMMM yyyy"];
    NSDate *date = [formatter dateFromString:text];
    return date;
}

@end
