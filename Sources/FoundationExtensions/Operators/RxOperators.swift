//
//  RxOperators.swift
//  Calculator&Converter
//
//  Created by Данил Войдилов on 19.07.2018.
//  Copyright © 2018 RonDesign. All rights reserved.
//

import Foundation
import RxSwift
//import RxCocoa

precedencegroup RxPrecedence {
    associativity: left
    higherThan: FunctionArrowPrecedence
}

precedencegroup DisposablePrecedence {
    associativity: left
    higherThan: RxPrecedence
}


//infix operator ~> : RxPrecedence
//infix operator >~ : RxPrecedence
//infix operator ~~> : RxPrecedence
//infix operator <~> : RxPrecedence
//infix operator =~ : RxPrecedence
//
//public func ~><O: ObservableType>(_ lhs: O?, _ rhs: @escaping (O.E) -> ()) -> Disposable? {
//    return lhs?.asObservable().subscribe(onNext: rhs)
//}
//
//public func ~><O: ObservableType>(_ lhs: O?, _ rhs: [(O.E) -> ()]) -> Disposable? {
//    return lhs?.asObservable().subscribe(onNext: { next in rhs.forEach{ $0(next) } })
//}
//
//public func ~><T: ObservableType, O: ObserverType>(_ lhs: T?, _ rhs: O) -> Disposable? where O.E == T.E {
//    return lhs?.asObservable().subscribe(rhs.asObserver())
//}
//
//public func ~><T: ObservableType, O: ObserverType>(_ lhs: T?, _ rhs: O) -> Disposable? where O.E == Optional<T.E> {
//    return lhs?.map({ $0 }).subscribe(rhs.asObserver())
//}
//
//public func =~<T, O: ObserverType>(_ lhs: O, _ rhs: T) where T == O.E {
//    lhs.onNext(rhs)
//}
//
//public func >~(_ lhs: Disposable?, _ rhs: DisposeBag) {
//    lhs?.disposed(by: rhs)
//}
//
//public func ~>(_ lhs: Disposable?, _ rhs: inout Disposable?) {
//    rhs = lhs
//}
//
//public func ~><T: ObservableType, O: SchedulerType>(_ lhs: T?, _ rhs: O) -> Observable<T.E>? {
//    return lhs?.observeOn(rhs)
//}
//
//public func ~~><O: ObservableType>(_ lhs: O?, _ rhs: @escaping (O.E) -> ()) -> Disposable? {
//    return lhs?.asObservable().observeOn(MainScheduler.asyncInstance).subscribe(onNext: rhs)
//}
//
//public func ~~><O: ObservableType>(_ lhs: O?, _ rhs: [(O.E) -> ()]) -> Disposable? {
//    return lhs?.asObservable().observeOn(MainScheduler.asyncInstance).subscribe(onNext: {next in rhs.forEach{ $0(next) } })
//}
//
//public func ~~><T: ObservableType, O: ObserverType>(_ lhs: T?, _ rhs: O) -> Disposable? where O.E == T.E {
//    return lhs?.asObservable().observeOn(MainScheduler.asyncInstance).subscribe(rhs.asObserver())
//}
//
//public func ~~><T: ObservableType, O: ObserverType>(_ lhs: T?, _ rhs: O) -> Disposable? where O.E == Optional<T.E> {
//    return lhs?.map({ $0 }).observeOn(MainScheduler.asyncInstance).subscribe(rhs.asObserver())
//}

//public func <~><T: ObservableType & ObserverType, O>(_ lhs: T, _ rhs: ControlProperty<O>) -> Disposable where O == T.E {
//    let disposeBag = Disposables.create(
//        lhs.asObservable().observeOn(MainScheduler.asyncInstance).subscribe(rhs.asObserver()),
//        rhs.asObservable().observeOn(MainScheduler.asyncInstance).subscribe(lhs.asObserver()))
//    return disposeBag
//}
//
//public func <~><T: ObservableType & ObserverType>(_ lhs: ControlProperty<T.E>, _ rhs: T) -> Disposable {
//    let disposeBag = Disposables.create(
//        lhs.asObservable().observeOn(MainScheduler.asyncInstance).subscribe(rhs.asObserver()),
//        rhs.asObservable().observeOn(MainScheduler.asyncInstance).subscribe(lhs.asObserver()))
//    return disposeBag
//}

//func +<T: ObservableType, O: ObservableType>(_ lhs: T, _ rhs: O) -> Observable<O.E> where O.E == T.E {
//    return Observable.merge([lhs.asObservable(), rhs.asObservable()])
//}
//
//func +<T: ObserverType, O: ObserverType>(_ lhs: T, _ rhs: O) -> AnyObserver<O.E> where O.E == T.E {
//    return [lhs.asObserver(), rhs.asObserver()].asObserver()
//}

//func +(_ lhs: Disposable, _ rhs: Disposable) -> Cancelable {
//    return Disposables.create(lhs, rhs)
//}
//
//extension Array: ObserverType where Element: ObserverType {
//    
//    public typealias E = Element.E
//    
//    public func on(_ event: Event<Element.E>) {
//        forEach {
//            $0.on(event)
//        }
//    }
//    
//    func asObserver() -> AnyObserver<E> {
//        return AnyObserver(map { $0.asObserver() })
//    }
//}
//
//extension Array: ObservableConvertibleType where Element: ObservableConvertibleType {
//    
//    public func asObservable() -> Observable<Element.E> {
//        return Observable<E>.merge(map({ $0.asObservable() }))
//    }
//    
//}
//
//extension Array: ObservableType where Element: ObservableType {
//   
//    public func subscribe<O>(_ observer: O) -> Disposable where O : ObserverType, E == O.E {
//        var disposables: [Disposable] = []
//        forEach {
//            disposables.append($0.subscribe(observer))
//        }
//        return Disposables.create(disposables)
//    }
//    
//}
//
//
////func +<A: ObservableType, B: ObservableType>(_ lhs: A, _ rhs: B) -> Observable<(A.E, B.E)> {
////    return Observable.combineLatest(lhs, rhs) { ($0, $1) }
////}
////
////func +<A>(_ lhs: @escaping (A) -> (), _ rhs: @escaping (A) -> ()) -> (A) -> () {
////    return { lhs($0); rhs($0) }
////}
//
//extension ObservableType {
//    
//    var awaitAll: [E] {
//        var e: [E] = []
//        let semaphore = DispatchSemaphore(value: 0)
//        let d = self.subscribe { (event) in
//            switch event {
//            case .next(let element): e.append(element)
//            default: semaphore.signal()
//            }
//        }
//        semaphore.wait()
//        d.dispose()
//        return e
//    }
//    
//    func await() throws -> E {
//        var e: E?
//        var err: Error?
//        let semaphore = DispatchSemaphore(value: 0)
//        var d: Disposable?
//        DispatchQueue.global().async {
//            d = self.single().subscribe { (event) in
//                switch event {
//                case .next(let element): e = element
//                case .error(let error): err = error; semaphore.signal()
//                case .completed: semaphore.signal()
//                }
//            }
//        }
//        semaphore.wait()
//        d?.dispose()
//        if let er = err {
//            throw er
//        } else if e == nil {
//            throw RxError.noElements
//        }
//        return e!
//    }
//    
//    
//    
//}
//
//
