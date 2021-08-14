//
//  MemoryDataProvider.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/10/21.
//

import Foundation

class MemoryDataProvider<KeyType: Hashable, DataType>: DataProvider {
    private var data = [KeyType: DataType]()

    func getAll() -> Result<[DataType]> {
        var allData = [DataType]()
        
        self.data.values.forEach { dataItem in
            allData.append(dataItem)
        }
        
        let result: Result<[DataType]> = .Success(data: allData)
        
        return result
    }
    
    func get(key: KeyType) -> Result<DataType> {
        let result : Result<DataType>
        
        if let data = self.data[key] {
            result = .Success(data: data)
        } else {
            result = .Failed(error: MemoryDataProviderError(.keyNotFound))
        }

        return result
    }

    func put(key: KeyType, value: DataType) -> Result<Bool> {
        self.data[key] = value
        return .Success(data: true)
    }

    func remove(key: KeyType) -> Result<Bool> {
        self.data.removeValue(forKey: key)
        
        return .Success(data: true)
    }
    
    typealias DataType = DataType
    
    typealias KeyType = KeyType
}

struct MemoryDataProviderError: Error {
    private let errorType: DataErrorType
    
    init(_ errorType: DataErrorType) {
        self.errorType = errorType
    }

    public var localizedDescription: String {
        switch self.errorType {
        case .keyNotFound:
            return "Data Not Found"
        }
    }
}

enum DataErrorType {
    case keyNotFound
}
