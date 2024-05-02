//
//  AsyncSintaxis.swift
//  zakazKarti
//
//  Created by mac on 30.05.2018.
//  Copyright © 2018 mac. All rights reserved.
//

//example:
//
//typealias StringAndInt = (string: String, int: Int)
//
//public func foo( completion: @escaping (StringAndInt) -> () ) -> () {
//    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0 ) {
//        completion(("sdfds",3))
//    }
//}
//
//public func bar(int: Int, completion: @escaping (String) -> () ) {
//    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0 ) {
//        completion(String(int))
//    }
//}
//
//
//DispatchQueue.global().async {
//    let fooRes = .utility <~| self.foo
//    let barRes = <~|{ self.bar(int: fooRes.int, completion: $0) }
//
//    print(fooRes)
//    print(barRes)
//
//    let fooBarFoo = parallel(
//        <~|self.foo,
//        .userInitiated <~| { self.bar(int: Int(barRes)!, completion: $0) },
//        .main <~| self.foo
//    )
//
//    print(fooBarFoo)
//    print(fooBarFoo.0)
//
//
//}


import Foundation

public enum GCDQueuePriority: String {
    case background
    case utility
    case `default`
    case userInitiated
    case userInteractive
    case unspecified
    case main
    
    var queue: DispatchQueue {
        switch self {
        case .main: return DispatchQueue.main
        case .background: return DispatchQueue.global(qos: .background)
        case .utility: return DispatchQueue.global(qos: .utility)
        case .default: return DispatchQueue.global(qos: .default)
        case .userInitiated: return DispatchQueue.global(qos: .userInitiated)
        case .userInteractive: return DispatchQueue.global(qos: .userInteractive)
        case .unspecified: return DispatchQueue.global(qos: .unspecified)
        }
    }
}

prefix operator <~|

prefix public func <~| <A0> (f: @escaping ( @escaping (  A0 ) -> () )  -> ()) -> ( A0 ) {
    return .default <~| f
}

//prefix public func <~| <A0, A1> (f:  @escaping ( @escaping ( A0, A1 ) -> () )  -> ()) -> ( A0, A1 ) {
//    return .default <~| f
//}

infix operator <~|: MultiplicationPrecedence

public func <~| <A0> (priority: GCDQueuePriority, f: @escaping ( @escaping (  A0 ) -> () )  -> ()) -> ( A0 ) {
    let semaphore = DispatchSemaphore(value: 0)
    var result: (A0)?
    priority.queue.async {
        f() {
            result = $0
            semaphore.signal()
        }
    }
    semaphore.wait()
    return result!
}

public func <~| <A0, A1> (priority: GCDQueuePriority, f: @escaping ( @escaping (  A0, A1 ) -> () )  -> ()) -> ( A0, A1 ) {
    let semaphore = DispatchSemaphore(value: 0)
    var result: (A0, A1)?
    priority.queue.async {
        f() {
            result = ($0,$1)
            semaphore.signal()
        }
    }
    semaphore.wait()
    return result!
}

public func parallel<A0, A1>(_ a0: @escaping @autoclosure () -> A0, _ a1: @escaping @autoclosure () -> A1) -> (A0, A1) {
    var a0Res: A0?
    var a1Res: A1?
    
    let semaphore = DispatchSemaphore(value: 0)
    DispatchQueue.global().async {
        a0Res = a0()
        semaphore.signal()
    }
    DispatchQueue.global().async {
        a1Res = a1()
        semaphore.signal()
    }
    
    semaphore.wait()
    semaphore.wait()
    
    return (a0Res!,a1Res!)
}

public func parallel<A0, A1, A2>(_ a0: @escaping @autoclosure () -> A0, _ a1: @escaping @autoclosure () -> A1, _ a2: @escaping @autoclosure () -> A2 ) -> (A0, A1, A2) {
    var a0Res: A0?
    var a1Res: A1?
    var a2Res: A2?
    
    let semaphore = DispatchSemaphore(value: 0)
    DispatchQueue.global().async {
        a0Res = a0()
        semaphore.signal()
    }
    DispatchQueue.global().async {
        a1Res = a1()
        semaphore.signal()
    }
    DispatchQueue.global().async {
        a2Res = a2()
        semaphore.signal()
    }
    
    semaphore.wait()
    semaphore.wait()
    semaphore.wait()
    
    return (a0Res!,a1Res!,a2Res!)
}
