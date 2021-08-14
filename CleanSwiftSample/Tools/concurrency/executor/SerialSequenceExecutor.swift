//
//  SerialSequenceExecutor
//  RiverIOS
//
//  Created by Reza on 9/10/18.
//  Copyright © 2018 Ronak Software. All rights reserved.
//

import Foundation

/// An executor that executes sequences of tasks serially from the
/// caller thread.
///
/// - note: Generally this implementation should only be used for debugging
/// purposes, as debugging highly concurrent task executions can be very
/// challenging. Production code should use `ConcurrentSequenceExecutor`.
/// - seeAlso: `SequenceExecutor`.
/// - seeAlso: `Task`.
public class SerialSequenceExecutor: SequenceExecutor {

    /// Initializer.
    public init() {}

    /// Execute a sequence of tasks serially from the given initial task
    /// on the caller thread.
    ///
    /// - parameter initialTask: The root task of the sequence of tasks
    /// to be executed.
    /// - parameter execution: The execution defining the sequence of tasks.
    /// When a task completes its execution, this closure is invoked with
    /// the task and its produced result. This closure is invoked from
    /// the caller thread serially as each task completes. The tasks provided
    /// by this closure are executed serially on the initial caller thread.
    /// - returns: The execution handle that allows control and monitoring
    /// of the sequence of tasks being executed.
    public func executeSequence<SequenceResultType>(from initialTask: ChatTask, with execution: @escaping (ChatTask, Any) -> SequenceExecution<SequenceResultType>) -> SequenceExecutionHandle<SequenceResultType> {
        let handle: SequenceExecutionHandleImpl<SequenceResultType> = SequenceExecutionHandleImpl()
        execute(initialTask, with: handle, execution)
        return handle
    }

    // MARK: - Private

    private func execute<SequenceResultType>(_ task: ChatTask, with sequenceHandle: SequenceExecutionHandleImpl<SequenceResultType>, _ execution: @escaping (ChatTask, Any) -> SequenceExecution<SequenceResultType>) {
        guard !sequenceHandle.isCancelled else {
            return
        }

        let result = task.typeErasedExecute()
        let nextExecution = execution(task, result)
        switch nextExecution {
        case .continueSequence(let nextTask):
            self.execute(nextTask, with: sequenceHandle, execution)
        case .endOfSequence(let result):
            sequenceHandle.sequenceDidComplete(with: result)
        }
    }
}

private class SequenceExecutionHandleImpl<SequenceResultType>: SequenceExecutionHandle<SequenceResultType> {

    private var didCancel = false
    private var result: SequenceResultType?

    fileprivate var isCancelled: Bool {
        return didCancel
    }

    fileprivate override func await(withTimeout timeout: TimeInterval?) throws -> SequenceResultType {
        return result!
    }

    fileprivate func sequenceDidComplete(with result: SequenceResultType) {
        self.result = result
    }

    fileprivate override func cancel() {
        didCancel = true
    }
}
