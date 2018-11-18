//
//  ASCommonArrayDataManager.swift
//  ASTool
//
//  Created by 章凯华 on 2018/10/6.
//

import Foundation

public class ASCommonArrayDataManager<T:Equatable>: NSObject {
    
    public let savedKey:String
    
    private var dataArray = [T]()
    private var mutx = pthread_mutex_t()
    
    init(with key:String = "ASCommonArrayDataManagerSavedKey") {
        savedKey = key
        let result = pthread_mutex_init(&self.mutx, nil)
        assert(result == 0, "ASCommonArrayDataManager create mutex error")
    }
    
    public func dataCount() -> Int {
        return self.dataArray.count
    }
    
    public func push(model:T) -> Bool {
        self.lock()
        self.dataArray.append(model)
        self.unlock()
        return true
    }
    
    public func model(at index:Int) -> T? {
        self.lock()
        let model = dataArray[safe: index];
        self.unlock()
        return model
    }
    
    public func index(for item:T) -> Int {
        self.lock()
        let index = dataArray.firstIndex { (obj) -> Bool in
            return obj == item
            } ?? NSNotFound
        self.unlock()
        return index
    }
    
    public func clearAll() {
        self.lock()
        self.dataArray.removeAll()
        self.unlock()
    }
    
    public func allModel() -> [T] {
        let newArray = self.dataArray
        return newArray
    }
    
    public func hasModel(model:T) -> Bool {
        var isContain = false
        self.lock()
        isContain = self.dataArray.contains(model)
        self.unlock()
        
        return isContain
    }
    
    /// MARK: lock
    public func lock() {
        let result = pthread_mutex_lock(&self.mutx)
        assert(result == 0, "\(self) lock error");
    }
    
    public func unlock() {
        let result = pthread_mutex_unlock(&self.mutx)
        assert(result == 0, "\(self) unlock error");
    }
}



