//
//  DBManager.h
//  PrayerNow
//
//  Created by ApprocksEg on 11/4/15.
//  Copyright © 2015 ApprocksEg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject
-(instancetype)setFileName:(NSString *)dbFilename;
@property (nonatomic, strong) NSMutableArray *arrColumnNames;

@property (nonatomic) int affectedRows;

@property (nonatomic) long long lastInsertedRowID;


-(NSArray *)loadDataFromDB:(NSString *)query;

-(void)executeQuery:(NSString *)query;

-(void)executeQuery;
@end
