//
//  DataModelExtension.swift
//  ASTool
//
//  Created by 章凯华 on 2018/10/6.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
