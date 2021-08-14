//
//  DataProviders.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/14/21.
//

import Foundation

class DataProviders {
    
    static let shared = DataProviders()
    
    private lazy var _countryMemoryDataProvider = CountryMemoryDataProvider()
    var countryMemoryDataProvider: CountryMemoryDataProvider {
        get {
            return _countryMemoryDataProvider
        }
    }
    
    private lazy var _countryNetowrkDataProvider = CountryNetworkDataProvider()
    var countryNetowrkDataProvider: CountryNetworkDataProvider {
        get {
            return _countryNetowrkDataProvider
        }
    }
}
