//
//  ACArchiverCenter.h
//  xulinfeng
//
//  Created by xulinfeng on 2016/12/22.
//  Copyright © 2016年 xulinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ACArchiveStorage <NSObject, NSCopying, NSCoding, NSSecureCoding>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *filePath;
@property (nonatomic, copy, readonly) NSArray<NSString *> *allKeys;
@property (nonatomic, copy, readonly) NSArray<id> *allValues;
@property (nonatomic, assign, readonly) NSUInteger count;

- (NSArray<NSString *> *)allKeysForObject:(id)anObject;
- (NSArray<NSObject, NSCopying, NSCoding> *)objectsForKeys:(NSArray<NSString *> *)keys notFoundMarker:(id)marker;

- (id<NSCopying, NSCoding>)objectForKey:(NSString *)aKey;

- (id)objectForKeyedSubscript:(NSString *)key;
- (void)setObject:(id<NSObject, NSCopying, NSCoding>)anObject forKeyedSubscript:(NSString *)aKey;

- (void)setObject:(id<NSObject, NSCopying, NSCoding>)anObject forKey:(NSString *)aKey;
- (void)syncSetObject:(id<NSObject, NSCopying, NSCoding>)anObject forKey:(NSString *)aKey;

- (void)removeObjectForKey:(NSString *)aKey;

/**
 Load storage synchronizely from file. the all of cached value will be clean.
 */
- (void)reload;

/**
 Save synchronizely into file.

 @return state of saving
 */
- (BOOL)save;

@optional

- (NSString *)stringForKey:(NSString *)aKey;
- (void)setString:(NSString *)stringValue forKey:(NSString *)aKey;

- (NSDate *)dateForKey:(NSString *)aKey;
- (void)setDate:(NSDate *)dateValue forKey:(NSString *)aKey;

- (NSData *)dataForKey:(NSString *)aKey;
- (void)setData:(NSData *)dataValue forKey:(NSString *)aKey;

- (NSURL *)URLForKey:(NSString *)aKey;
- (void)setURL:(NSURL *)URL forKey:(NSString *)aKey;

- (NSInteger)integerForKey:(NSString *)aKey;
- (void)setInteger:(NSUInteger)integerValue forKey:(NSString *)aKey;

- (BOOL)boolForKey:(NSString *)aKey;
- (void)setBool:(BOOL)boolValue forKey:(NSString *)aKey;

- (double)doubleForKey:(NSString *)aKey;
- (void)setDouble:(double)doubleValue forKey:(NSString *)aKey;

- (float)floatForKey:(NSString *)aKey;
- (void)setFloat:(float)floatValue forKey:(NSString *)aKey;

- (char)charForKey:(NSString *)aKey;
- (void)setChar:(char)charValue forKey:(NSString *)aKey;

- (unsigned char)unsignedCharForKey:(NSString *)aKey;
- (void)setUnsignedChar:(unsigned char)unsignedCharValue forKey:(NSString *)aKey;

- (short)shortForKey:(NSString *)aKey;
- (void)setShort:(short)shortValue forKey:(NSString *)aKey;

- (unsigned short)unsignedShortForKey:(NSString *)aKey;
- (void)setUnsignedShort:(unsigned short)unsignedShortValue forKey:(NSString *)aKey;

- (int)intForKey:(NSString *)aKey;
- (void)setInt:(int)intValue forKey:(NSString *)aKey;

- (unsigned int)unsignedIntForKey:(NSString *)aKey;
- (void)setUnsignedInt:(unsigned int)unsignedIntValue forKey:(NSString *)aKey;

- (long)longForKey:(NSString *)aKey;
- (void)setLong:(long)longValue forKey:(NSString *)aKey;

- (unsigned long)unsignedLongForKey:(NSString *)aKey;
- (void)setUnsignedLong:(unsigned long)unsignedLongValue forKey:(NSString *)aKey;

- (long long)longLongForKey:(NSString *)aKey;
- (void)setLongLong:(long long)longLongValue forKey:(NSString *)aKey;

- (unsigned long long)unsignedLongLongForKey:(NSString *)aKey;
- (void)setUnsignedLongLong:(unsigned long long)unsignedLongLongValue forKey:(NSString *)aKey;

@end

@interface ACArchiveStorage : NSObject <ACArchiveStorage>
@end

@interface ACArchiverCenter : NSObject

@property (nonatomic, strong, readonly) NSMutableArray<NSString *> *archiveStorageNames;

@property (nonatomic, copy, readonly) NSString *directory;

@property (nonatomic, copy, readonly) NSString *uniqueIdentifier;

- (instancetype)initWithUniqueIdentifier:(NSString *)uniqueIdentifier directory:(NSString *)directory;

/**
 The default center.

 @return default instance of center, it's singleton.
 */
+ (id)defaultCenter;

/**
 The default storage for default center.
 
 @return default instance of storage.
 */
+ (id<ACArchiveStorage>)defaultStorage;

/**
 The default storage for every center.

 @return default instance of storage.
 */
- (id<ACArchiveStorage>)defaultStorage;

/**
 Require an storage, it will alloc an new storage if the storage didn't exist,
 
 @param name storage name
 @return an storage
 */
- (id<ACArchiveStorage>)requireStorageWithName:(NSString *)name;

/**
 Reload all storages from storage-files.
 */
- (void)reloadAll;

/**
 Store all storages into the files.
 */
- (void)saveAll;

@end
