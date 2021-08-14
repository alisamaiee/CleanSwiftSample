//
//  DataProvider.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/10/21.
//

import Foundation

protocol DataProvider {
    associatedtype DataType
    associatedtype KeyType: Hashable
    
    func getAll() -> Result<[DataType]>
    func get(key: KeyType) -> Result<DataType>
    func put(key: KeyType , value : DataType) -> Result<Bool>
    func remove(key : KeyType) -> Result<Bool>
}

enum Result<DataType> {
    case Success(data : DataType)
    case Failed(error : Error)
}
