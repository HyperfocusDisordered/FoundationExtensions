
//
//  OptionalChaining.swift
//  Prometheus
//
//  Created by mac on 16.05.2018.
//  Copyright © 2018 PochtaBank. All rights reserved.
//

import Foundation

/*
 Повторяет поведение map на опшеналах
 Исполняет правый аргумент - функцию от неопциональных аргументов, только в случае если что все опционалы из левого тапла непусты.
 Ретернит то, что ретернит правая функция или же nil, если левый тапл не развернулся
 (на одном опционале эквивалентно map)
 
 Пример:
 func foo(int: Int,str: String) {
 }
 
 var str: String?
 var int: Int?
 
 // ... //
 
 (int,str) ?-> { foo(int: $0, str: $1 }
 // или например
 (int,str) ?-> foo
 // или например
 int ?-> { ($0, String(describing: $0) } ?-> foo
 
 */

infix operator ?-> : MultiplicationPrecedence

@discardableResult public func ?-> <T,U> (opt:T?, f: (T) -> U?) -> U? {
    switch opt {
    case .some(let x):
        return f(x)
    case .none:
        return .none
    }
}

@discardableResult public func ?-> <T,U> (opt:T?, f: (T) throws -> U?) -> U? {
	do {
		switch opt {
		case .some(let x):
			return try f(x)
		case .none:
			return .none
		}
	} catch {
		return .none
	}
}

//infix operator ?-> : MultiplicationPrecedence

//@discardableResult public func ?-> <T,U> (opt:T?, f: @autoclosure (T) -> U?) -> U? {
//	switch opt {
//	case .some(let x):
//		return f(x)
//	case .none:
//		return .none
//	}
//}

@discardableResult public func ?-> <T,U> (opt:T?, f: (T) -> Optional<Optional<U>>) -> U? {
	switch opt {
	case .some(let x):
		return f(x)?.flatMap { $0 }
	case .none:
		return .none
	}
}



public typealias Tuple2<T1,T2> = (a0: T1,a1: T2)

@discardableResult public func ?-> <T1,T2, U>  (tuple: Tuple2<Optional<T1>,Optional<T2>> , f: (T1,T2) -> U?) -> U? {
    guard let a0 = tuple.a0, let a1 = tuple.a1 else {
        return nil
    }
    return f(a0,a1)
}


@discardableResult public func ?-> <T1,T2, U>  (tuple: Tuple2<Optional<T1>,Optional<T2>> , f: (T1,T2) -> Optional<Optional<U>>) -> U? {
	guard let a0 = tuple.a0, let a1 = tuple.a1 else {
		return nil
	}
	return f(a0,a1)?.flatMap { $0 }
}


@discardableResult public func ?-> <T0,T1,T2, U>  (tuple:(Optional<T0>, Optional<T1>, Optional<T2>) , f: (T0,T1,T2) -> U? ) -> U? {
    guard let a0 = tuple.0, let a1 = tuple.1, let a2 = tuple.2 else {
        return nil
    }
    return f(a0,a1,a2)
}

@discardableResult public func ?-> <T0,T1,T2, U>  (tuple:(Optional<T0>, Optional<T1>, Optional<T2>) , f: (T0,T1,T2) -> Optional<Optional<U>> ) -> U? {
	guard let a0 = tuple.0, let a1 = tuple.1, let a2 = tuple.2 else {
		return nil
	}
	return f(a0,a1,a2)?.flatMap { $0 }
}


infix operator --> : MultiplicationPrecedence

@discardableResult public func --> <T,U> (opt:T, f: (T) -> U) -> U {
//	switch opt {
//	case .some(let x):
		return f(opt)
//	case .none:√
//		return .none
//	}
}

infix operator --/ : MultiplicationPrecedence

@discardableResult public func --/ <T> (opt:T, f: (T) -> ()) -> T {
	//	switch opt {
	//	case .some(let x):
	 f(opt)
	return opt
	//	case .none:√
	//		return .none
	//	}
}

infix operator ?-/ : MultiplicationPrecedence

@discardableResult public func ?-/ <T> (opt:T?, f: (T) -> ()) -> T? {
		switch opt {
		case .some(let x):
			f(x)
			return opt
		case .none:
			return opt
		}
}



@discardableResult public func --> <T1,T2, U>  (tuple: Tuple2<T1,T2> , f: (T1,T2) -> U) -> U {
//	guard let a0 = tuple.a0, let a1 = tuple.a1 else {
//		return nil
//	}
	return f(tuple.0,tuple.1)
}

@discardableResult public func --> <T0,T1,T2, U>  (tuple:(T0, T1, T2) , f: (T0,T1,T2) -> U ) -> U {
//	guard let a0 = tuple.0, let a1 = tuple.1, let a2 = tuple.2 else {
//		return nil
//	}
	return f(tuple.0,tuple.1,tuple.2)
}



let b = (2,3) -->
	{ $0 + $1 } --> String.init


let a = (2,3)
--> { $0 + $1 }
//	>> String.init








infix operator => : AssignmentPrecedence

@discardableResult public func => <U> ( predict: Bool?, f: () -> U? )  ->  U? {
    switch predict {
    case .some(let bool):
        if bool {
            return f()
        } else {
            return nil
        }
    case .none:
        return .none
    }
}
