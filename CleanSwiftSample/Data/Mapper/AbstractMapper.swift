//
//  AbstractMapper.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/10/21.
//

import Foundation

protocol AbstractMapper {
    associatedtype First
    associatedtype Second
    
    func map(first: First) -> Second
    func map(second: Second) -> First
    func map(listOf first: [First]) -> [Second]
    func map(listOf second: [Second]) -> [First]
}
