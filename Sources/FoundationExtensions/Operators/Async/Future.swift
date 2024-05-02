//
//  Future.swift
//  CheqApp
//
//  Created by Овчар Денис on 30/11/2018.
//  Copyright © 2018 Овчар Денис. All rights reserved.
//

//import Foundation
//class Future<T> {
//    
//    let global = DispatchQueue.global(qos: .userInitiated)
//    
//    var onSuccess: ((T) -> ())? {
//        didSet {
//            global.async {
//                self.succesSemaphore.signal()
//            }
//        }
//    }
//    var onError: ((ErrorWrapper) -> ())? {
//        didSet {
//            global.async {
//                self.errorSemaphore.signal()
//            }
//        }
//    }
//    var onSuccessEmpty: (() -> ())? {
//        didSet {
//            global.async {
//                self.succesSemaphore.signal()
//            }
//        }
//    }
//    var onErrorEmpty: (() -> ())? {
//        didSet {
//            global.async {
//                self.errorSemaphore.signal()
//            }
//        }
//    }
//    var onFinish: (() -> ())?
//    
//    
//    var queue: DispatchQueue
//    
//    init(_ queue: DispatchQueue = .main) {
//        self.queue = queue
//    }
//    
//    init(_ queue: DispatchQueue = .main, block: () -> ()) {
//        self.queue = queue
//        //
//    }
//    
//    
//    
//    func onSuccess(_ block: @escaping (T) -> ()) -> Future<T> {
//        onSuccess = block
//        return self
//    }
//    
//    @discardableResult func onSuccess(_ block: @escaping () -> ()) -> Future<T> {
//        onSuccessEmpty = block
//        return self
//    }
//    
//    @discardableResult func onError(_ block: @escaping (ErrorWrapper) -> () ) -> Future<T> {
//        onError = block
//        return self
//    }
//    
//    @discardableResult func onError(_ block: @escaping () -> () ) -> Future<T> {
//        onErrorEmpty = block
//        return self
//    }
//    
//    @discardableResult func onFinish(_ block: @escaping () -> () ) -> Future<T> {
//        onFinish = block
//        return self
//    }
//    
//    @discardableResult func `in`(_ queue: DispatchQueue) -> Future<T> {
//        self.queue = queue
//        return self
//    }
//    
//    var succesSemaphore = DispatchSemaphore(value: 0)
//    var errorSemaphore = DispatchSemaphore(value: 0)
//    
//    func success(_ value: T) {
//        global.asyncAfter(deadline: .now() + 5) {
//            self.succesSemaphore.signal()
//        }
//        global.async {
//            self.succesSemaphore.wait()
//            self.queue.async {
//                self.onFinish?()
//                self.onSuccess?(value)
//                self.onSuccessEmpty?()
//            }
//        }
//        
//    }
//    //TODO: Разобраться с удалением семафоров и пропуском дальше
//    func error(_ error: Error) {
//        global.asyncAfter(deadline: .now() + 5) {
//            self.errorSemaphore.signal()
//        }
//        global.async {
//            self.errorSemaphore.wait()
//            self.queue.async {
//                self.onFinish?()
//                self.onError?(ErrorWrapper(error: error))
//                self.onErrorEmpty?()
//            }
//        }
//        
//    }
//    
//    func finalize(value: T?, orError: Error) {
//        if let value = value {
//            success(value)
//        } else {
//            error(orError)
//        }
//    }
//
//    func get(executeIn queue: DispatchQueue = .global()) throws -> T {
//
//        var value: T?
//        var error: Error?
//        let semaphore = DispatchSemaphore(value: 0)
//        self.in(queue)
//        onFinish { semaphore.signal() }
//        onSuccess { value = $0 }
//        onError { error = $0.error }
//        semaphore.wait()
//        if let val = value {
//            return val
//        }
//        if let error = error {
//            throw error
//        }
//        throw "unknown"
//    }
//    
//}
