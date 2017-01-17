//
//  ACArchiverCenter.m
//  pyyx
//
//  Created by xulinfeng on 2016/12/22.
//  Copyright © 2016年 Chunlin Ma. All rights reserved.
//

#import "ACArchiverCenter.h"

NSString * const ACArchiverCenterFolderPath = @"com.archiver_center.archives";
NSString * const ACArchiverCenterStorageNamesFilename = @"com.archiver_center_storage_names";
NSString * const ACArchiverCenterDefaultArchiveStorageName = @"ACArchiverCenterDefaultArchiveStorageName";

@interface ACArchiveStorage ()

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *filePath;

@property (nonatomic, strong) NSMutableDictionary *keyValues;

@end

@implementation ACArchiveStorage

+ (instancetype)archiveStorageWithName:(NSString *)name filePath:(NSString *)filePath;{
    return [[self alloc] initWithName:name filePath:filePath];
}

- (instancetype)initWithName:(NSString *)name filePath:(NSString *)filePath;{
    if (self = [super init]) {
        self.name = name;
        self.filePath = filePath;
        
        [self reload];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone;{
    ACArchiveStorage *copy = [[ACArchiveStorage allocWithZone:zone] init];
    copy.keyValues = [[self keyValues] copy];
    copy.name = [[self name] copy];
    copy.filePath = [[self filePath] copy];
    return copy;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [self init]) {
        self.keyValues = [coder decodeObjectForKey:@"keyValues"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.filePath = [coder decodeObjectForKey:@"filePath"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:[self keyValues] forKey:@"keyValues"];
    [coder encodeObject:[self name] forKey:@"name"];
    [coder encodeObject:[self filePath] forKey:@"filePath"];
}

#pragma mark NSSecureCoding

+ (BOOL)supportsSecureCoding {
    return NO;
}

#pragma mark - accessor

- (NSMutableDictionary *)keyValues{
    if (!_keyValues) {
        _keyValues = [NSMutableDictionary dictionary];
    }
    return _keyValues;
}

- (NSArray<NSString *> *)allKeys {
    return [[self keyValues] allKeys];
}

- (NSArray<id> *)allValues {
    return [[self keyValues] allValues];
}

- (NSUInteger)count{
    return [[self keyValues] count];
}

- (NSArray<NSString *> *)allKeysForObject:(id)anObject{
    return [self allKeysForObject:anObject];
}

- (NSString *)stringForKey:(NSString *)aKey;{
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    } else if ([object respondsToSelector:@selector(stringValue)]) {
        return [object stringValue];
    } else {
        return [object description];
    }
}

- (NSDate *)dateForKey:(NSString *)aKey;{
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSDate class]]) {
        return object;
    } else if ([object respondsToSelector:@selector(dateValue)]) {
        return [object dateValue];
    } else if ([object isKindOfClass:[NSNumber class]] || [object isKindOfClass:[NSString class]]) {
        return [NSDate dateWithTimeIntervalSince1970:[object floatValue]];
    } else {
        return nil;
    }
}

- (NSData *)dataForKey:(NSString *)aKey;{
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSData class]]) {
        return object;
    } else if ([object respondsToSelector:@selector(dataValue)]) {
        return [object dataValue];
    } else if ([object isKindOfClass:[NSString class]]) {
        return [object dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([object isKindOfClass:[NSNumber class]]) {
        return [[object stringValue] dataUsingEncoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

- (NSURL *)URLForKey:(NSString *)aKey;{
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSURL class]]) {
        return object;
    } else if ([object respondsToSelector:@selector(URL)]) {
        return [object URL];
    } else if ([object isKindOfClass:[NSString class]]) {
        return [NSURL URLWithString:object];
    } else {
        return nil;
    }
}

- (NSArray<NSString *> *)stringArrayForKey:(NSString *)aKey;{
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSArray class]]) {
        NSMutableArray *stringArray = [NSMutableArray array];
        for (id subObject in object) {
            if ([subObject isKindOfClass:[NSString class]]) {
                [stringArray addObject:subObject];
            } else if ([subObject respondsToSelector:@selector(stringValue)]) {
                [stringArray addObject:[subObject stringValue]];
            } else {
                [stringArray addObject:[subObject description] ?: @""];
            }
        }
        return stringArray;
    } else {
        return nil;
    }
}

- (NSInteger)integerForKey:(NSString *)aKey;{
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(integerValue)]) {
        return [object integerValue];
    } else {
        return 0;
    }
}

- (BOOL)boolForKey:(NSString *)aKey;{
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(boolValue)]) {
        return [object boolValue];
    } else {
        return NO;
    }
}

- (double)doubleForKey:(NSString *)aKey;{
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(doubleValue)]) {
        return [object doubleValue];
    } else {
        return 0.f;
    }
}

- (float)floatForKey:(NSString *)aKey;{
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(floatValue)]) {
        return [object floatValue];
    } else {
        return 0.f;
    }
}

- (int)intForKey:(NSString *)aKey;{
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(intValue)]) {
        return [object intValue];
    } else {
        return 0;
    }
}

- (long)longForKey:(NSString *)aKey;{
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(longValue)]) {
        return [object longValue];
    } else {
        return 0;
    }
}

- (id<NSCopying, NSCoding>)objectForKey:(NSString *)aKey;{
    return [self keyValues][aKey];
}

- (void)setObject:(id<NSCopying, NSCoding>)anObject forKey:(NSString *)aKey{
    self.keyValues[aKey] = anObject;
}

- (void)syncSetObject:(id<NSCopying, NSCoding>)anObject forKey:(NSString *)aKey;{
    [self setObject:anObject forKey:aKey];
    [self save];
}

- (void)removeObjectForKey:(NSString *)aKey{
    return [[self keyValues] removeObjectForKey:aKey];
}

- (void)reload;{
    self.keyValues = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]] ?: [@{} mutableCopy];
}

- (BOOL)save;{
    return [NSKeyedArchiver archiveRootObject:[self keyValues] toFile:[self filePath]];
}

@end

@interface ACArchiverCenter ()

@property (nonatomic, strong) NSMutableArray<NSString *> *archiveStorageNames;

@property (nonatomic, strong) NSMutableDictionary<NSString*, id<ACArchiveStorage>> *cachedArchiveStorage;

@property (nonatomic, copy) NSString *directory;

@property (nonatomic, copy) NSString *uniqueIdentifier;

@property (nonatomic, copy, readonly) NSString *archiverCenterFolderPath;
@property (nonatomic, copy, readonly) NSString *archiveStorageNamesFilePath;

@end

@implementation ACArchiverCenter

- (instancetype)initWithUniqueIdentifier:(NSString *)uniqueIdentifier directory:(NSString *)directory;{
    if (self = [super init]) {
        self.directory = directory;
        self.uniqueIdentifier = uniqueIdentifier;
    }
    return self;
}

- (void)initialize{
    [self reloadAllStorage];
}

#pragma mark = accessor

- (NSMutableArray<NSString *> *)archiveStorageNames{
    if (!_archiveStorageNames) {
        _archiveStorageNames = [NSMutableArray array];
    }
    return _archiveStorageNames;
}

- (NSMutableDictionary<NSString *,id<ACArchiveStorage>> *)cachedArchiveStorage{
    if (!_cachedArchiveStorage) {
        _cachedArchiveStorage = [NSMutableDictionary dictionary];
    }
    return _cachedArchiveStorage;
}

- (NSString *)archiverCenterFolderPath{
    return [fmts(@"%@/%@_%@", [self directory], ntoe([self uniqueIdentifier]), YRArchiverCenterFolderPath) copy];
}

- (NSString *)archiveStorageNamesFilePath{
    return [self _archiveStorageFilePathWithName:ACArchiverCenterStorageNamesFilename];
}

#pragma mark - private

- (NSString *)_archiveStorageFilePathWithName:(NSString *)name{
    return [fmts(@"%@/%@.archiver", [self archiverCenterFolderPath], [name base64EncodedString]) copy];
}

- (BOOL)_storeArchiverCenterStorageNames{
    
    BOOL state = [NSKeyedArchiver archiveRootObject:[self archiveStorageNames] toFile:[self archiveStorageNamesFilePath]];
    DDLogDebug(@"persistent storage state : %d", state);
    return state;
}

- (void)_readArchiverCenterStorageNames{
    BOOL isDirectory = NO;
    void (^createDirectoryHandler)() = ^{
        NSError *error = nil;
        [NSFileManager createDirectoryAtPath:[self archiverCenterFolderPath] withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DDLogError(@"Failed to create directorr with error : %@", error);
        }
    };
    if ([NSFileManager fileExistsAtPath:[self archiverCenterFolderPath] isDirectory:&isDirectory]) {
        if (!isDirectory) {
            NSError *error = nil;
            [NSFileManager removeItemAtPath:[self archiverCenterFolderPath] error:&error];
            if (error) {
                DDLogError(@"Failed to remove file path with error : %@", error);
            }
            createDirectoryHandler();
        }
    } else {
        createDirectoryHandler();
    }
    
    self.archiveStorageNames = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archiveStorageNamesFilePath]];
}

#pragma mark - public

- (id<ACArchiveStorage>)requireArchiveStorageWithName:(NSString *)name {
    NSParameterAssert([name length]);
    id<ACArchiveStorage> archiveStorage = nil;
    id<ACArchiveStorage> (^newArchiveStorage)(NSString *storageName) = ^(NSString *storageName){
        // New an storage from archive file.
        id<ACArchiveStorage> storage = [ACArchiveStorage archiveStorageWithName:storageName filePath:[self _archiveStorageFilePathWithName:storageName]];
        if (storage) {
            self.cachedArchiveStorage[name] = storage;
        }
        return storage;
    };
    // Append name if the storage hasn't loaded.
    if ([[self archiveStorageNames] containsObject:name]) {
        if ([[[self cachedArchiveStorage] allKeys] containsObject:name]) {
            archiveStorage = [self cachedArchiveStorage][name];
        } else {
            archiveStorage = newArchiveStorage(name);
        }
    } else {
        archiveStorage = newArchiveStorage(name);
        if (archiveStorage) {
            [[self archiveStorageNames] addObject:name];
        }
    }
    return archiveStorage;
}

- (void)reloadAllStorage {
    [[self archiveStorageNames] removeAllObjects];
    for (id<ACArchiveStorage> archiveStorage in [[self cachedArchiveStorage] allValues]) {
        [archiveStorage reload];
    }
    [self _readArchiverCenterStorageNames];
}

- (void)storeAllStorage;{
    for (id<ACArchiveStorage> archiveStorage in [[self cachedArchiveStorage] allValues]) {
        [archiveStorage save];
    }
    [self _storeArchiverCenterStorageNames];
}

@end
