//
//  AsyncOperation.swift
//  NewsAPIKit
//
//  Created by Mohammed Al Waili on 25/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

open class AsyncOperation: Operation {
    let lock = DispatchQueue(label: "newsapp.asyncoperations.concurrent", attributes: .concurrent)
    public override var isAsynchronous: Bool { true }

    private var _isCancelled: Bool = false
    public override var isCancelled: Bool {
        get {
            lock.sync {
                _isCancelled
            }
        }
        set {
            willChangeValue(forKey: "isCancelled")
            lock.sync(flags: .barrier) {
                _isCancelled = newValue
            }
            didChangeValue(forKey: "isCancelled")
        }
    }

    private var _isExecuting: Bool = false
    public override var isExecuting: Bool {
        get {
            lock.sync {
                _isExecuting
            }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            lock.sync(flags: .barrier) {
                _isExecuting = newValue
            }
            didChangeValue(forKey: "isExecuting")
        }
    }

    private var _isFinished: Bool = false
    public override var isFinished: Bool {
        get {
            lock.sync {
                _isFinished
            }
        }
        set {
            willChangeValue(forKey: "isFinished")
            lock.sync(flags: .barrier) {
                _isFinished = newValue
            }
            didChangeValue(forKey: "isFinished")
        }
    }

    public override func start() {
        isFinished = false
        isExecuting = true
        main()
    }

    public override func main() {
        guard !dependencies.contains(where: { $0.isCancelled }), !isCancelled else {
            isExecuting = false
            isCancelled = true
            return
        }
        workItem()
    }

    open func workItem() {
        fatalError("workItem should be implemented by the subclass!")
    }

    public func workItemFinished() {
        isExecuting = false
        isFinished = true
    }

    public override func cancel() {
        isExecuting = false
        isCancelled = true
    }
}
