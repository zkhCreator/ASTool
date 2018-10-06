//
//  ASCommonArrayDataManager.swift
//  ASTool
//
//  Created by 章凯华 on 2018/10/6.
//

import Foundation

struct ASCommonArrayDataManager<T:Equatable> {
    
    public let savedKey:String
    
    private var dataArray = [T]()
    private var mutx = pthread_mutex_t()
    
    init(with key:String = "ASCommonArrayDataManagerSavedKey") {
        savedKey = key
        let result = pthread_mutex_init(&self.mutx, nil)
        assert(result == 0, "ASCommonArrayDataManager create mutex error")
    }
    
    mutating func model(at index:Int) -> T? {
        self.lock()
        let model = dataArray[safe: index];
        self.unlock()
        return model
    }
    
    mutating func index(for item:T) -> Int {
        self.lock()
        let index = dataArray.firstIndex { (obj) -> Bool in
            return obj == item
        } ?? NSNotFound
        self.unlock()
        return index
    }
    
    mutating func lock() {
        let result = pthread_mutex_lock(&self.mutx)
        assert(result == 0, "\(self) lock error");
    }
    
    mutating func unlock() {
        let result = pthread_mutex_unlock(&self.mutx)
        assert(result == 0, "\(self) unlock error");
    }
}



