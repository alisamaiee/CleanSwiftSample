//
//  AtomicBool.swift
//  RiverIOS
//
//  Created by Reza on 9/10/18.
//  Copyright © 2018 Ronak Software. All rights reserved.
//

import Foundation

/// A concurrency utility class that supports locking-free synchronization on mutating an boolean
/// value. Unlike using a lock, concurrent read and write accesses to this class is allowed. At
/// the same time, concurrent operations using the atomic functions provided by this class ensures
/// synchronization correctness without the higher cost of locking.
public class AtomicBool {
    
    /// The value that guarantees atomic read and write-through memory behavior.
    public var value: Bool {
        get {
            return AtomicBool.intToBool(value: backingAtomic.value)
        }
        set {
            let intValue = AtomicBool.boolToInt(value: newValue)
            backingAtomic.value = intValue
        }
    }
    
    /// Initializer.
    ///
    /// - parameter initialValue: The initial value.
    public init(initialValue: Bool) {
        let intValue = AtomicBool.boolToInt(value: initialValue)
        backingAtomic = AtomicInt(initialValue: intValue)
    }
    
    /// Atomically sets the new value, if the current value equals the expected value.
    ///
    /// - parameter expect: The expected value to compare against.
    /// - parameter newValue: The new value to set to if the comparison succeeds.
    /// - returns: true if the comparison succeeded and the value is set. false otherwise.
    @discardableResult
    public func compareAndSet(expect: Bool, newValue: Bool) -> Bool {
        let expectInt = AtomicBool.boolToInt(value: expect)
        let newValueInt = AtomicBool.boolToInt(value: newValue)
        return backingAtomic.compareAndSet(expect: expectInt, newValue: newValueInt)
    }
    
    /// Atomically sets to the given new value and returns the old value.
    ///
    /// - parameter newValue: The new value to set to.
    /// - returns: The old value.
    public func getAndSet(newValue: Bool) -> Bool {
        let newValueInt = AtomicBool.boolToInt(value: newValue)
        let resultIntValue = backingAtomic.getAndSet(newValue: newValueInt)
        return AtomicBool.intToBool(value: resultIntValue)
    }
    
    // MARK: - Private
    private static let falseIntValue = 0
    private static let trueIntValue = 1
    private let backingAtomic: AtomicInt
    
    private static func boolToInt(value: Bool) -> Int {
        return value ? AtomicBool.trueIntValue : AtomicBool.falseIntValue
    }
    
    private static func intToBool(value: Int) -> Bool {
        return (value == AtomicBool.trueIntValue) ? true : false
    }
}
