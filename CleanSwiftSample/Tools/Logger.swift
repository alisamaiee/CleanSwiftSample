//
//  Logger.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/9/21.
//

import Foundation

/// Custom logger to handle app logs, develop features for it as you wish
class Logger {
    static func printToConsole(_ message: Any) {
        #if DEBUG
            print(message)
        #endif
    }
}
