//
//  RuntimeError.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/10/21.
//

import Foundation

struct RuntimeError: Error {
    private let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    public var localizedDescription: String {
        return message
    }
}
