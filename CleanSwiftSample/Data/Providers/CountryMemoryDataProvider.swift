//
//  CountryMemoryDataProvider.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/10/21.
//

import Foundation

class CountryMemoryDataProvider: MemoryDataProvider<String, Country>, CountryDataProvider {
    func setSelected(key: String, selected: Bool) -> Result<Country> {
        let countryRes = get(key: key)
        
        switch countryRes {
        case .Success(var country):
            country.selected = selected
            let putRes = put(key: key, value: country)
            switch putRes {
            case .Success(_):
                return .Success(data: country)
            case .Failed(let error):
                return .Failed(error: error)
            }
        case.Failed(let error):
            return .Failed(error: error)
        }
    }
}

protocol CountryDataProvider: class, DataProvider {
    associatedtype KeyType = String
    associatedtype DataType = Country
    
    func setSelected(key: KeyType, selected: Bool) -> Result<DataType>
}
