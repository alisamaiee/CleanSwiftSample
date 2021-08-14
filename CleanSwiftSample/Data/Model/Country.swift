//
//  Country.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/10/21.
//

import Foundation

struct Country: Codable {
    var key: String {
        get {
            return name.lowercased()
        }
    }
    var name : String
    var selected : Bool
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        selected = false
    }
    
    init(name: String, selected: Bool) {
        self.name = name
        self.selected = selected
    }
}

class CountryToViewSelectCountry: AbstractMapper {
    typealias First = Country
    typealias Second = SelectCountries.Response.FetchCountry.Country
    
    func map(first: Country) -> SelectCountries.Response.FetchCountry.Country {
        let viewCountry = SelectCountries.Response.FetchCountry.Country(name: first.name, selected: first.selected)
        return viewCountry
    }
    
    func map(second: SelectCountries.Response.FetchCountry.Country) -> Country {
        return Country(name: second.name, selected: second.selected)
    }
    
    func map(listOf first: [Country]) -> [SelectCountries.Response.FetchCountry.Country] {
        return first.map { (country) -> SelectCountries.Response.FetchCountry.Country in
            return map(first: country)
        }
    }
    
    func map(listOf second: [SelectCountries.Response.FetchCountry.Country]) -> [Country] {
        return second.map { (viewCountry) -> Country in
            return map(second: viewCountry)
        }
    }
}
