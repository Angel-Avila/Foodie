//
//  CancellableToken.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation

/// An object fto be used on operations that can be cancelled, ie. network requests.
final class CancellableToken {
    private let lock: DispatchSemaphore = DispatchSemaphore(value: 1)
    private let cancelAction: () -> Void
    
    /// Wether if the action has been cancelled or not.
    fileprivate(set) var isCancelled = false
    
    /// New instance of CancellableToken
    ///
    /// - Parameter action: A closure that would be executed when the cancel function is called.
    init(action: @escaping () -> Void) {
        self.cancelAction = action
    }
    
    /// Calling this function will execute the cancel action.
    func cancel() {
        lock.wait()
        defer { lock.signal() }
        guard !isCancelled else { return }
        isCancelled = true
        cancelAction()
    }
}
