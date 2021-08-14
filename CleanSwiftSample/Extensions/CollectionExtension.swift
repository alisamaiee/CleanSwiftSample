//
//  CollectionExtension.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/14/21.
//

import Foundation

internal extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
}
