//
//  Task
//  RiverIOS
//
//  Created by Reza on 9/10/18.
//  Copyright © 2018 Ronak Software. All rights reserved.
//

import Foundation

/// An individual unit of work that can be executed in a concurrent
/// environment by an executor.
// Task cannot be generic since it needs to be referenced by the executor
// class which cannot provide type information for specific tasks.
public protocol ChatTask {

    /// Execute this task without any type information.
    ///
    /// - note: This method should only be used by internal executor
    /// implementations.
    /// - returns: The type erased execution result of this task.
    // Return type cannot be generic since the `Task` type needs to be
    // referenced by the executor class which cannot provide type information
    // for results.
    func typeErasedExecute() -> Any
}

/// The base abstraction of a task that has a defined execution result
/// type.
// This class is used to allow subclasses to declare result type generics,
// while allowing the internal executor implementations to operate on the
// non-generic, type-erased `Task` protocol, since Swift does not support
// wildcard generics.
open class AbstractTask<ResultType>: ChatTask {

    /// Initializer.
    public init() {}

    /// Execute this task without any type information.
    ///
    /// - note: This method should only be used by internal executor
    /// implementations.
    /// - returns: The type erased execution result of this task.
    // Return type cannot be generic since the `Task` type needs to be
    // referenced by the executor class which cannot provide type information
    // for results.
    public final func typeErasedExecute() -> Any {
        return execute()
    }

    /// Execute this task and return the result.
    ///
    /// - returns: The execution result of this task.
    open func execute() -> ResultType {
        fatalError("\(self).execute is not yet implemented.")
    }
}

open class BooleanTask : AbstractTask<Bool> {
    let runnableFunction : () -> Bool
    
    init(_ runnable : @escaping () -> Bool) {
        self.runnableFunction = runnable
    }
    
    override open func execute() -> Bool {
        return self.runnableFunction()
    }
}
