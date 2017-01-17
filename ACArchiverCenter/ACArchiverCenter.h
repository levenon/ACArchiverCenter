//
//  ACArchiverCenter.h
//  Marke Jave
//
//  Created by Marke Jave on 2016/12/22.
//  Copyright © 2016年 Marke Jave. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ACArchiveStorage <NSCopying, NSObject, NSCoding, NSSecureCoding>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *filePath;
@property (nonatomic, copy, readonly) NSArray<NSString *> *allKeys;
@property (nonatomic, copy, readonly) NSArray<id> *allValues;
@property (nonatomic, assign, readonly) NSUInteger count;

- (NSArray<NSString *> *)allKeysForObject:(id)anObject;

- (NSString *)stringForKey:(NSString *)aKey;

- (NSDate *)dateForKey:(NSString *)aKey;
- (NSData *)dataForKey:(NSString *)aKey;
- (NSURL *)URLForKey:(NSString *)aKey;
- (NSArray<NSString *> *)stringArrayForKey:(NSString *)aKey;
- (NSInteger)integerForKey:(NSString *)aKey;

- (BOOL)boolForKey:(NSString *)aKey;
- (double)doubleForKey:(NSString *)aKey;
- (float)floatForKey:(NSString *)aKey;
- (int)intForKey:(NSString *)aKey;
- (long)longForKey:(NSString *)aKey;

- (id<NSCopying, NSCoding>)objectForKey:(NSString *)aKey;
- (void)setObject:(id<NSCopying, NSCoding>)anObject forKey:(NSString *)aKey;
- (void)syncSetObject:(id<NSCopying, NSCoding>)anObject forKey:(NSString *)aKey;

- (void)removeObjectForKey:(NSString *)aKey;

/**
 Load storage from file. the all of cached value will be clean.
 */
- (void)reload;

/**
 Save into file.

 @return state of saving
 */
- (BOOL)save;

@end

@interface ACArchiveStorage : NSObject <ACArchiveStorage>
@end

@interface ACArchiverCenter : NSObject

@property (nonatomic, strong, readonly) NSMutableArray<NSString *> *archiveStorageNames;

@property (nonatomic, copy, readonly) NSString *directory;

@property (nonatomic, copy, readonly) NSString *uniqueIdentifier;

- (instancetype)initWithUniqueIdentifier:(NSString *)uniqueIdentifier directory:(NSString *)directory;

/**
 Require an storage, it will alloc an new storage if the storage didn't exist,
 
 @param name storage name
 @return an storage
 */
- (id<ACArchiveStorage>)requireArchiveStorageWithName:(NSString *)name;

/**
 Reload all storages from storage-files.
 */
- (void)reloadAllStorage;

/**
 Store all storages into the files.
 */
- (void)storeAllStorage;

@end
