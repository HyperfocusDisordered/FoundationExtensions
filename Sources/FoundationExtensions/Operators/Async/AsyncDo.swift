//
//  AsyncDo.swift
//  CheqApp
//
//  Created by Овчар Денис on 30/11/2018.
//  Copyright © 2018 Овчар Денис. All rights reserved.
//

//import RxSwift

//struct ErrorWrapper {
//    let error: Error
//}
//
//class AsyncDoResult {
//    let isCatchInited = BehaviorSubject<Bool>(value: false)
//    
//    init() {}
//    var errorHandler: ((ErrorWrapper) -> () )? = nil
//    
//    @discardableResult func `catch`(catchBlock: @escaping (ErrorWrapper) -> () ) {
//        self.errorHandler = catchBlock
//        isCatchInited =~ true
//    }
//}
//
//
//func asyncDo(_ queue: DispatchQoS.QoSClass = .default, block: @escaping () throws -> () ) -> AsyncDoResult {
//    let result = AsyncDoResult()
//    DispatchQueue.global(qos: queue).async {
//        result.isCatchInited ~> {
//            if $0 {
//                do {
//                    try block()
//                } catch {
//                    result.errorHandler?(ErrorWrapper(error: error))
//                }
//            }
//        }
//    }
//    return result
//}
//
//
//
//struct FutureWrapper<T> {
//    let future: Future<T>
//}
//struct FutureErrorWrapper<T> {
//    let future: Future<T>
//    let error: Error
//}
//
//func asyncDoWithFuture<T>(_ queue: DispatchQoS.QoSClass = .default, block: @escaping (FutureWrapper<T>) throws -> () ) -> AsyncDoFutureResult<T> {
//    let future = Future<T>()
//    let result = AsyncDoFutureResult<T>(future)
//
//    DispatchQueue.global(qos: queue).async {
//        result.isCatchInited ~> {
//            if $0 {
//                do {
//                    try block(FutureWrapper(future: future))
//                } catch {
//                    result.errorHandler?(FutureErrorWrapper(future: future ,error: error))
//                }
//            }
//        }
//    }
//    return result
//}
//
//class AsyncDoFutureResult<T> {
//    let isCatchInited = BehaviorSubject<Bool>(value: false)
//    let future: Future<T>
//    
//    init(_ future: Future<T>) {
//        self.future = future
//    }
//    var errorHandler: ((FutureErrorWrapper<T>) -> () )? = nil
//    
//    func `catch`(catchBlock: @escaping (FutureErrorWrapper<T>) -> () ) -> Future<T> {
//        self.errorHandler = catchBlock
//        isCatchInited =~ true
//        return future
//    }
//}
