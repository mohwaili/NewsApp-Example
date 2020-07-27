//
//  AsyncResultOperation.swift
//  NewsAPIKit
//
//  Created by Mohammed Al Waili on 25/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

open class AsyncResultOperation<Success, Failure>: AsyncOperation where Failure: Error {
    private var result: Result<Success, Failure>? {
        didSet {
            guard let result = result else { return }
            onResult?(result)
        }
    }

    public var onResult: ((Result<Success, Failure>) -> Void)?

    public override func workItemFinished() {
        fatalError("workItemFinished:with should be used instead!")
    }

    public func workItemFinished(with result: Result<Success, Failure>) {
        self.result = result
        super.workItemFinished()
    }
}
