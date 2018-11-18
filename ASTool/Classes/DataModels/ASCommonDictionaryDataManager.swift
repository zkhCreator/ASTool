//
//  ASCommonDictionaryDataManager.swift
//  ASTool
//
//  Created by 章凯华 on 2018/10/6.
//

import Foundation

public class ASCommonDictionaryDataManager<K:Hashable, T:Equatable>: NSObject {
    
    public let savedKey:String
    
    private var dataDictionary = [K: T]()
    private var mutx = pthread_mutex_t()
    
    init(with key:String = "ASCommonArrayDataManagerSavedKey") {
        savedKey = key
        let result = pthread_mutex_init(&self.mutx, nil)
        assert(result == 0, "ASCommonArrayDataManager create mutex error")
    }
    
    public func value(for key:K) -> T? {
        self.lock()
        let model = dataDictionary[key];
        self.unlock()
        return model
    }
    
    public func update(for key:K, value:T) {
        self.lock()
        dataDictionary.updateValue(value, forKey: key)
        self.unlock()
    }
    
    public func has(key: K) -> Bool {
        let keysArray = dataDictionary.keys;
        return keysArray.contains(key)
    }
    
    public func has(value: T) -> Bool {
        let valuesArray = dataDictionary.values;
        return valuesArray.contains(value)
    }
    
    public func remove(key: K) -> Bool {
        if !self.has(key: key) {
            return false
        }
        self.lock()
        self.dataDictionary.removeValue(forKey: key)
        self.unlock()
        return true
    }
    
    public func lock() {
        let result = pthread_mutex_lock(&self.mutx)
        assert(result == 0, "\(self) lock error");
    }
    
    public func unlock() {
        let result = pthread_mutex_unlock(&self.mutx)
        assert(result == 0, "\(self) unlock error");
    }
}
