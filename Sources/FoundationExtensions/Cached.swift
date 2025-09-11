//
//  Plist.swift
//  Compass
//
//  Created by  Denis Ovchar new on 17.12.2020.
//  Copyright © 2020 work. All rights reserved.
//

import Foundation
import FoundationExtensions
import Combine
//import CombineOperators
//import CombineCocoa
import VDCodable

public protocol NameSpaceReadable {
    static var nameSpace: String { get }
}
public extension NameSpaceReadable {
    static var nameSpace: String {
        let fullTypeName = String(reflecting: type(of: Self.self))
        return fullTypeName
    }
}

public class PlistManager {
    static func set< T: Codable>(_ value: T, for key: String) {
        if  let dictionary = try? VDJSONEncoder().encode(value) {
            UserDefaults.standard.set(dictionary, forKey: key)
        } else {
            UserDefaults.standard.set( value as AnyObject, forKey: key)
        }
    }
    
    static func value< T: Codable>(for key: String) -> T? {
        let value = UserDefaults.standard.value(forKey: key)

        if let data = value as? Data {
			do {
				return try VDJSONDecoder().decode(T.self, from: data)
			} catch {
				print("error decoding: ", key)
				print(error)
				return nil
			}
        } else {
            return value as? T
        }
    }
    
    static func clearAll() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}

@available(macOS 10.15, *)
@propertyWrapper
public struct Cached <T: Codable> {
	
	let key: String
	let deflt: T
	

	public var projectedValue: CurrentValueSubject<T, Never> {
		cachedInstance.subject
	}
	
	public var wrappedValue: T {
		get {
			mainSync {
				cachedInstance.subject.value
			}
		}
		set {
			mainIfNeeded {
				cachedInstance.subject.value = newValue
			}
		}
	}
	
	public init(wrappedValue: T, _ key: String) {
		self.key = key
		self.deflt = wrappedValue

	}
	
	public init<V>(_ key: String) where V? == T {
		self.key = key
		self.deflt = nil
	}
	
	var cachedInstance: CachedInstance<T> {
		mainSync {
			getCachedInstance(key: key, deflt: deflt)
		}
	}
}

fileprivate enum Statics {

	fileprivate static var cachedInstances: [String: Any] = [:]
}


func mainSync<R>(_ lambda: @escaping ()->R) -> R {
	if Thread.current.isMainThread {
		return lambda()
	} else {
		return DispatchQueue.main.sync {
				lambda()
		}
	}
}

func mainIfNeeded(_ lambda: @escaping ()->()) {
	if Thread.current.isMainThread {
		lambda()
	} else {
		DispatchQueue.main.async {

				lambda()
		}
	}
}


@available(macOS 10.15, *)
class CachedInstance<T: Codable> {


	let key: String

	public let subject: CurrentValueSubject<T, Never>
	
	private var didInit = false
    var cancelables: Set<AnyCancellable> = []

	init(key: String, deflt: T) {
		self.key = key
		
		let storedValue: T? = PlistManager.value(for: key)
		subject = .init(storedValue ?? deflt)

		subject
			.receive(on: DispatchQueue.main)
			.sink {
//			print("SINK")
			if self.didInit {
//				print("SET", $0)
				PlistManager.set($0, for: key)
			} else {
//				print("DIDINIt")
				self.didInit = true
			}
		}.store(in: &cancelables)
	}
}

@available(macOS 10.15, *)
func getCachedInstance<T>(key: String, deflt: T) -> CachedInstance<T> {
	mainSync {
		if let instance = Statics.cachedInstances[key] as? CachedInstance<T> {
			return instance
		} else {
			let new = CachedInstance<T>(key: key, deflt: deflt)
			Statics.cachedInstances[key] = new
			return new
		}
	}
}






import os

public final class UnfairLockWrapper {
	private let pointer: os_unfair_lock_t

	public init() {
		self.pointer = .allocate(capacity: 1)
		self.pointer.initialize(to: os_unfair_lock())
	}

	deinit {
		self.pointer.deinitialize(count: 1)
		self.pointer.deallocate()
	}

	public func lock() {
		os_unfair_lock_lock(self.pointer)
	}

	public func unlock() {
		os_unfair_lock_unlock(self.pointer)
	}

	public func withLock<T>(_ f: () -> T) -> T {
		defer { unlock() }
		lock()
		return f()
	}
}

@propertyWrapper
public final class UnfairLock<T> {
	private let lock = UnfairLockWrapper()

	private var value: T

	public init(wrappedValue: T) {
		self.value = wrappedValue
	}

	public var projectedValue: UnfairLock<T> { self }

	public var wrappedValue: T {
		get {
			lock.lock()
			defer { lock.unlock() }
			return value
		}
		set {
			lock.lock()
			defer { lock.unlock() }
			value = newValue
		}
	}

	public func write(_ f: (inout T) -> Void) {
		lock.lock()
		defer { lock.unlock() }
		return f(&value)
	}

	public func access(_ f: (T) -> Void) {
		lock.lock()
		defer { lock.unlock() }
		return f(value)
	}
}




@propertyWrapper
public struct Atomic<Value> {
    @UnfairLock private var value: Value

    public init(wrappedValue: Value) {
        self.value = wrappedValue
    }

    public var wrappedValue: Value {
        get {
            return value
        }
        set {
            value = newValue
        }
    }
}



@available(macOS 10.15, *)
extension Cached: Equatable where T: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
}

@available(macOS 10.15, *)
extension Cached: Hashable where T: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }

    public var hashValue: Int {
        wrappedValue.hashValue
    }
}

//extension Cached: Codable where T: Codable {
//    public func encode(to encoder: Encoder) throws {
//        try wrappedValue.encode(to: encoder)
//    }
//
//    public init(from decoder: Decoder) throws {
//
//        //self.init(wrappedValue: <#T##Decodable & Encodable#>, <#T##key: String##String#>)
////        fatalError()
//    }
//}
